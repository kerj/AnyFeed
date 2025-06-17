//
//  ImageLoader-ViewModel.swift
//  iFinesse
//
//  Created by Justin Kerntz on 6/17/25.
//

import SwiftUI

@MainActor
class ImageLoader: ObservableObject {
    @Published var image: Image? = nil

    func load(from urlString: URL) async {
        do {
            let (data, _) = try await URLSession.shared.data(from: urlString)
            if let uiImage = UIImage(data: data) {
                self.image = Image(uiImage: uiImage)
            }
        } catch {
            print("Image load failed:", error)
        }
    }
}
