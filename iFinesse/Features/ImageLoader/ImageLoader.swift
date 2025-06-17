//
//  ImageLoader.swift
//  iFinesse
//
//  Created by Justin Kerntz on 6/17/25.
//
import SwiftUI

struct RemoteImageView: View {
    @StateObject private var loader = ImageLoader()
    
    let urlString: URL
    let systemImageFallback: String

    var body: some View {
        Group {
            if let image = loader.image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else {
                Image(systemName: systemImageFallback)
            }
        }
        .onAppear {
            Task {
                await loader.load(from: urlString)
            }
        }
    }
}
