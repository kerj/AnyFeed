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
        @Published var authToken: String?
        @Published var appId: String = ""
        @Published var secret: String = ""

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
            let scopes = "activity:read"  // or "activity:read,profile:read_all"
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
                authSession?.prefersEphemeralWebBrowserSession = true
                authSession?.start()
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
                    let accessToken = json["access_token"] as? String
                {
                    // Main thread update
                    await MainActor.run {
                        self.authToken = accessToken
                    }

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

        func fetchStravaRideList() async -> [Ride] {
            guard self.authToken != nil else { return [] }

            do {
                let rides = try await RideService().fetchRides(
                    token: self.authToken!)
                return rides
            } catch {
                print("Error on fetching rides....")
                return []
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
