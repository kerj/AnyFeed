import SwiftUI

struct RideListView: View {
    @StateObject private var viewModel: ViewModel
    
    func color(for iconColor: IconColor) -> Color {
        switch iconColor {
        case .gold: return .yellow
        case .silver: return .gray
        case .bronze: return .brown
        }
    }
    
    init(rides: [Ride]) {
        _viewModel = StateObject(wrappedValue: ViewModel(rides: rides))
    }
    
    var body: some View {
        NavigationView {
            List(viewModel.displayRides.reversed()) { ride in
                RideListRow(ride: ride) {
                    iconColor in color(for: iconColor)
                }
            }
        }
    }
}
