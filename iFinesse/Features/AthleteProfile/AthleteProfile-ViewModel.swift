//
//  AthleteProfile-ViewModel.swift
//  iFinesse
//
//  Created by Justin Kerntz on 6/18/25.
//
import Foundation

extension AthleteProfile {
    class ViewModel: ObservableObject {
        @Published var zones: Zones
        @Published var totals: Totals
        @Published var athlete: Athlete
        

        init(zones: Zones, stats: Totals, athlete: Athlete) {
            self.zones = zones
            self.totals = stats
            self.athlete = athlete
        }

        
    }
}
