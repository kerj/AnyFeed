//
//  Utility.swift
//  iFinesse
//
//  Created by Justin Kerntz on 6/12/25.
//
import Foundation

extension Optional {
    func or(_ defaultValue: Wrapped) -> Wrapped {
        self ?? defaultValue
    }
}
// String formmating
func formatDistance(_ meters: Double) -> String {
    let km = meters / 1000
    
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.maximumFractionDigits = 2
    
    if let formatted = formatter.string(from: NSNumber(value: km)) {
        return "\(formatted) km"
    } else {
        return String(format: "%.2f km", km)
    }
}

func formatElevation(_ meters: Double) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.maximumFractionDigits = 2
    
    if let formatted = formatter.string(from: NSNumber(value: meters)) {
        return "\(formatted) m"
    } else {
        return String(format: "%.0f m", meters)
    }
}

func formatDuration(_ seconds: Int) -> String {
    let hrs = seconds / 3600
    let mins = (seconds % 3600) / 60
    let secs = seconds % 60
    if hrs > 0 {
        return String(format: "%dh %02dm %02ds", hrs, mins, secs)
    } else {
        return String(format: "%dm %02ds", mins, secs)
    }
}
