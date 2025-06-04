import SwiftUI

struct RideListView: View {
    @StateObject private var viewModel = ViewModel()

    func color(for iconColor: IconColor) -> Color {
        switch iconColor {
        case .gold: return .yellow
        case .silver: return .gray
        case .bronze: return .brown
        }
    }

    var body: some View {
        NavigationView {
            List(viewModel.displayRides) { ride in
                RideListRow(ride: ride) {
                    iconColor in color(for: iconColor)
                }
            }
            .onAppear {
                viewModel.loadRides()
            }
        }
    }
}
