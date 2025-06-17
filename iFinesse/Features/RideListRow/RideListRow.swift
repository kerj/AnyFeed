//
//  RideListRow.swift
//  iFinesse
//
//  Created by Justin Kerntz on 6/2/25.
//

import SwiftUI

struct RideListRow: View {

    let ride: RideViewModel
    let colorProvider: (IconColor) -> Color

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                RemoteImageView(
                    urlString: ride.athlete.profileURL!,
                    systemImageFallback: "person"
                ).frame(width: 40, height: 40).clipShape(Circle())
                VStack(alignment: .leading) {
                    Text("\(ride.athlete.firstname) \(ride.athlete.lastname)")
                        .fontWeight(.bold)
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
                    Spacer()
                    //                    Text("This is a description placeholder!!!")
                    //                        .font(.subheadline).padding(.vertical, 4)
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
                                    .foregroundColor(colorProvider(iconColor))
                            }
                            Text("\(ride.achievementCount)")
                                .font(.headline)
                        }
                    }

                }
                //                HStack(spacing: 16) {
                //                    Image(systemName: "trophy.fill").foregroundColor(
                //                        .yellow
                //                    ).font(.title)
                //
                //                    Text("Hello World!").font(.subheadline)
                //                    Spacer()
                //                }.padding(8).frame(maxWidth: .infinity)
                //                    .background(
                //                        RoundedRectangle(cornerRadius: 10).fill(
                //                            Color.gray.opacity(0.2)))

            }.padding(.vertical, 8)

            if let region = ride.mapCenter {
                RideMapSnapshotWithLink(
                    region: region,
                    polyline: ride.map.summary_polyline,
                    start: ride.startCoordinate,
                    end: ride.endCoordinate
                )
            }
        }
    }
}
