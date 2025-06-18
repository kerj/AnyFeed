import SwiftUI

struct AthleteProfile: View {
    @StateObject private var viewModel: ViewModel

    init(zones: Zones, stats: Totals, athlete: Athlete) {
        _viewModel = StateObject(
            wrappedValue: ViewModel(
                zones: zones, stats: stats, athlete: athlete))
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .center, spacing: 16) {
                    NavigationLink {
                        RideListView(
                            athlete: viewModel.athlete
                        )
                        .navigationTitle("Recent Activites")
                        .navigationBarTitleDisplayMode(.inline)
                    } label: {
                        ZStack {
                            RemoteImageView(
                                urlString: viewModel.athlete.profileURL!,
                                systemImageFallback: "person"
                            )
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())

                            // Chevron overlay
                            HStack {
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 12)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                    }
                    .buttonStyle(PlainButtonStyle())


                    VStack(alignment: .center) {
                        Text(
                            "\(viewModel.athlete.firstname) \(viewModel.athlete.lastname)"
                        )
                        .fontWeight(.bold)
                        Spacer()
                        Text("Rider Stats").font(.headline)
                    }
                    Divider().padding(.vertical, 4)

                    // Ride Totals Table
                    HStack(alignment: .top, spacing: 32) {
                        // Recent
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Recent Ride Totals")
                                .font(.headline)
                            RideStatRow(
                                label: "Distance",
                                value: formatDistance(
                                    viewModel.totals.recentRideTotals.distance))
                            RideStatRow(
                                label: "Count",
                                value:
                                    "\(viewModel.totals.recentRideTotals.count)"
                            )
                            RideStatRow(
                                label: "Moving Time",
                                value: formatDuration(
                                    viewModel.totals.recentRideTotals.movingTime
                                ))
                            RideStatRow(
                                label: "Elevation Gain",
                                value: formatElevation(
                                    viewModel.totals.recentRideTotals
                                        .elevationGain)
                            )
                        }

                        // All Time
                        VStack(alignment: .leading, spacing: 6) {
                            Text("All Time Ride Totals")
                                .font(.headline)
                            RideStatRow(
                                label: "Distance",
                                value: formatDistance(
                                    viewModel.totals.allRideTotals.distance))
                            RideStatRow(
                                label: "Count",
                                value: "\(viewModel.totals.allRideTotals.count)"
                            )
                            RideStatRow(
                                label: "Moving Time",
                                value: formatDuration(
                                    viewModel.totals.allRideTotals.movingTime))
                            RideStatRow(
                                label: "Elevation Gain",
                                value: formatElevation(
                                    viewModel.totals.allRideTotals.elevationGain
                                ))
                        }
                    }

                    // Heart Rate Zones
                    Text("Heart Rate Zones")
                        .font(.headline)

                    tableHeader()
                    ForEach(viewModel.zones.heartRate?.zones ?? [], id: \.min) {
                        zone in
                        zoneRow(zone)
                    }

                    Divider().padding(.vertical, 4)

                    // Power Zones
                    Text("Power Zones")
                        .font(.headline)

                    tableHeader()
                    ForEach(viewModel.zones.power?.zones ?? [], id: \.min) {
                        zone in
                        zoneRow(zone)
                    }

                    Divider().padding(.vertical, 4)

                }
                .padding()
            }
        }

    }

    // Shared header
    private func tableHeader() -> some View {
        HStack {
            Text("Min").fontWeight(.semibold).frame(
                maxWidth: .infinity, alignment: .leading)
            Text("Max").fontWeight(.semibold).frame(
                maxWidth: .infinity, alignment: .leading)
        }
        .font(.subheadline)
    }

    // Shared row
    private func zoneRow(_ zone: Zone) -> some View {
        HStack {
            Text("\(zone.min)").frame(maxWidth: .infinity, alignment: .leading)
            Text(zone.max == -1 ? "\(zone.min)+" : "\(zone.max)")
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .font(.subheadline)
    }
}

struct RideStatRow: View {
    let label: String
    let value: String

    var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: 4) {
            Text("\(label):")
                .fontWeight(.semibold)
            Text(value)
        }
        .font(.subheadline)
    }
}
