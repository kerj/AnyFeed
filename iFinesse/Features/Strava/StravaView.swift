//
//  StravaView.swift
//  iFinesse
//
//  Created by Justin Kerntz on 6/12/25.
//

import SwiftUI

struct StravaView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            if viewModel.currentAthlete != nil {
                Group {
                    if let loadedZones = viewModel.zones,
                       let loadedStats = viewModel.stats,
                       let currentAthlete = viewModel.currentAthlete
                    {
                        AthleteProfile(
                            zones: loadedZones, stats: loadedStats, athlete: currentAthlete)
                    } else {
                        Text("Loading Profile...")
                    }

                }.task {
                    await viewModel.getAthleteProfile()
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
