//
//  StravaView.swift
//  iFinesse
//
//  Created by Justin Kerntz on 6/12/25.
//

import SwiftUI

struct StravaView: View {
    @StateObject private var viewModel = ViewModel()
    @State private var rides: [Ride]? = nil
    

    var body: some View {
        VStack {
            if viewModel.authToken != nil {
                Group {
                    if let rides = rides {
                        RideListView(rides: rides)
                    } else {
                        Text("Fetching Activities...")
                    }
                }.task {
                    let fetched = await viewModel.fetchStravaRideList()
                    rides = fetched
                }
                
            } else {
                VStack {
                    TextField("Enter App ID:", text: $viewModel.appId)
                        .textFieldStyle(.roundedBorder)
                    TextField("Enter Client Secret:", text: $viewModel.secret)
                        .textFieldStyle(.roundedBorder)
                }.padding()

                HStack {
                    Button(action: viewModel.signIn) {
                        Label("Login with Strava", systemImage: "bicycle")
                    }.disabled(!viewModel.isAuthDisabled).padding().opacity(
                        !viewModel.isAuthDisabled ? 0.5 : 1)
                }

            }
        }

    }
}
