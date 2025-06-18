import AuthenticationServices
//
//  StravaView-Model.swift
//  iFinesse
//
//  Created by Justin Kerntz on 6/12/25.
//
import Foundation

extension StravaView {
    class ViewModel: NSObject, ObservableObject {

        private var authSession: ASWebAuthenticationSession?
        // 6 Hour validity
        @Published var appId: String = ""
        @Published var secret: String = ""
        @Published var currentAthlete: Athlete?
        @Published var zones: Zones?
        @Published var stats: Totals?
        @Published var rides: [Ride]?

        var isAuthDisabled: Bool {
            !appId.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
                && !secret.trimmingCharacters(in: .whitespacesAndNewlines)
                    .isEmpty
        }

        let appOAuthUrlStravaScheme = URL(
            string:
                "strava://oauth/mobile/authorize?client_id=37306&redirect_uri=ifinesse://auth/callback&response_type=code&approval_prompt=auto&scope=activity%3Cread&state=test"
        )!

        var stravaAuthURL: URL {
            let clientId = self.appId
            // update plist if changed :// name of app on strava dev
            let redirectURI = "ifinesse://ifinesse"
            let responseType = "code"
            let approvalPrompt = "auto"
            let scopes = "activity:read,profile:read_all"  // or "activity:read,profile:read_all"
            let state = "test"

            let encodedScopes = scopes.addingPercentEncoding(
                withAllowedCharacters: .urlQueryAllowed)!

            let authURLString =
                "https://www.strava.com/oauth/mobile/authorize?client_id=\(clientId)&redirect_uri=\(redirectURI)&response_type=\(responseType)&approval_prompt=\(approvalPrompt)&scope=\(encodedScopes)&state=\(state)"

            return URL(string: authURLString)!
        }

        func authenticate() {
            // If the user has strava on their device, we can try to use it, untested!!
            if UIApplication.shared.canOpenURL(appOAuthUrlStravaScheme) {
                UIApplication.shared.open(appOAuthUrlStravaScheme, options: [:])
            } else {
                authSession = ASWebAuthenticationSession(
                    url: stravaAuthURL, callbackURLScheme: "ifinesse"
                ) { url, error in
                    if let callbackURL = url {
                        print("Received callback URL: \(callbackURL)")

                        Task {
                            await self.exchangeCodeForToken(
                                code: self.handleRedirectURL(callbackURL))
                        }

                    } else if let error = error {
                        print("Authentication failed: \(error)")
                    }
                }

                authSession?.presentationContextProvider = self
                authSession?.start()
            }
        }

        func getAthleteFromAuth(athleteJson: [String: Any]) {
            do {
                let data = try JSONSerialization.data(
                    withJSONObject: athleteJson)
                let dto = try JSONDecoder().decode(AthleteDTO.self, from: data)
                DispatchQueue.main.async {
                    self.currentAthlete = Athlete(from: dto)
                }

            } catch {
                print("Failed to decode athlete DTO:", error)
            }
        }

        func exchangeCodeForToken(code: String?) async {
            guard
                let url = URL(
                    string: "https://www.strava.com/api/v3/oauth/token"),
                code != nil
            else {
                return
            }

            var request = URLRequest(url: url)
            request.httpMethod = "POST"

            let params = [
                "client_id": self.appId,
                "client_secret": self.secret,
                "code": code,
                "grant_type": "authorization_code",
            ]

            var components = URLComponents()
            components.queryItems = params.map {
                URLQueryItem(name: $0.key, value: $0.value)
            }

            request.httpBody = components.query?.data(using: .utf8)

            request.setValue(
                "application/x-www-form-urlencoded",
                forHTTPHeaderField: "Content-type"
            )

            do {
                let (data, _) = try await URLSession.shared.data(for: request)
                if let json = try JSONSerialization.jsonObject(with: data)
                    as? [String: Any],
                    let accessToken = json["access_token"] as? String,
                    let athlete = json["athlete"] as? [String: Any]
                {
                    // Main thread update
                    await MainActor.run {
                        RideService.authToken = accessToken
                    }
                    getAthleteFromAuth(athleteJson: athlete)

                    print(json.keys, json.values)
                } else {
                    print("unexpected response")
                }
            } catch {
                print(error)
            }

        }

        func handleRedirectURL(_ url: URL) -> String? {
            if let comp = URLComponents(
                url: url, resolvingAgainstBaseURL: false),
                let queryItems = comp.queryItems,
                let code = queryItems.first(where: { $0.name == "code" })?.value
            {

                print("Auth Code recieved from Strava")
                return code
            } else {
                print("Failed to parse redirect")
                return nil
            }
        }

        func signIn() {
            print("start sign in!!")
            self.authenticate()
            return print("pressed sign in")
        }

        func getAthleteProfile() async {
            guard let athlete = self.currentAthlete,
                athlete.id != -1
            else { return }

            do {
                let zones = try await RideService().getZones()
                await MainActor.run {
                    self.zones = zones
                }
            } catch {
                print("Error getting zones")
            }

            do {
                let stats = try await RideService().getProfile(
                    athleteId: athlete.id)
                await MainActor.run {
                    self.stats = stats
                }
            } catch {
                print("Error getting stats")
            }

        }
    }
}

extension StravaView.ViewModel: ASWebAuthenticationPresentationContextProviding
{
    func presentationAnchor(for session: ASWebAuthenticationSession)
        -> ASPresentationAnchor
    {
        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow } ?? ASPresentationAnchor()
    }
}
