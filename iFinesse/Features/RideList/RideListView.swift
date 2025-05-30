import SwiftUI

struct RideListView: View {
    @State private var viewModel = ViewModel()

    func color(for iconColor: IconColor) -> Color {
        switch iconColor {
        case .gold: return .yellow
        case .silver: return .gray
        case .bronze: return .brown
        }
    }

    var body: some View {
        List(viewModel.displayRides) { ride in
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "person")
                    VStack(alignment: .leading) {
                        Text(ride.athlete).fontWeight(.bold)
                        HStack(alignment: .top) {
                            Image(systemName: "bicycle").foregroundColor(.black)
                            VStack(alignment: .leading) {
                                Text(ride.formattedStartDate).font(.caption)
                            }

                        }

                    }
                }
                VStack(alignment: .leading) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text(ride.name)
                            .font(.headline)
                        Text("This is a description placeholder!!!")
                            .font(.subheadline).padding(.vertical, 4)
                    }
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Distance")
                                .font(.caption2)
                            Text(ride.formatted)
                                .font(.headline)
                        }
                        VStack(alignment: .leading) {
                            Text("Elev Gain")
                                .font(.caption2)
                            Text(ride.totalElevationGain)
                                .font(.headline)
                        }

                        Spacer()
                        VStack(alignment: .trailing) {
                            Text("Achievements")
                                .font(.caption2)
                            HStack(spacing: 4) {
                                ForEach(
                                    Array(ride.medalIcons.enumerated()),
                                    id: \.offset
                                ) { index, icon in
                                    let (iconName, iconColor) = icon
                                    Image(systemName: iconName)
                                        .foregroundColor(color(for: iconColor))
                                }
                                Text("\(ride.achievementCount)")
                                    .font(.headline)
                            }
                        }

                    }
                }.padding(.vertical, 8)
            }

        }
        .onAppear {
            viewModel.loadRides()
        }
    }
}
