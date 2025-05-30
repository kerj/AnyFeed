//
//  ContentView.swift
//  iFinesse
//
//  Created by Justin Kerntz on 5/25/25.
//

import SwiftUI

struct ActivityResponse: Codable {
  let name: String
  let distance: Double
  let moving_time: Int
  let type: String
  // Add more fields as needed, or omit if you only want to show raw string.
}

struct ContentView: View {

  @State private var message = "Loading..."

  var body: some View {
    VStack {
      Text(message).fixedSize()
        .multilineTextAlignment(.leading)
        .padding()
    }.onAppear {
      print("appeared")
      loadMessage()
    }
  }

  func loadMessage() {
    guard let url = URL(string: "http://192.168.1.151:5266/api/fitnessdata/data") else {
      DispatchQueue.main.async {
        message = "Invalid URL"
      }
      return
    }

    URLSession.shared.dataTask(with: url) { data, response, error in
      if let error = error {
        DispatchQueue.main.async {
          message = "Error: \(error.localizedDescription)"
        }
        return
      }

      if let data = data {
        do {
          let decoded = try JSONDecoder().decode([ActivityResponse].self, from: data)
          DispatchQueue.main.async {
            if let first = decoded.first {
              message = "First activity: \(first.name), distance: \(first.distance)m"
            } else {
              message = "No activities found"
            }
          }
        } catch {
          // Decoding failed — fallback to raw string
          if let rawString = String(data: data, encoding: .utf8) {
            DispatchQueue.main.async {
              message = "Failed decoding, raw response:\n" + rawString
            }
          } else {
            DispatchQueue.main.async {
              message = "Failed to decode and failed to read raw response"
            }
          }
        }
      } else {
        DispatchQueue.main.async {
          message = "No data"
        }
      }
    }.resume()
  }

  struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
      ContentView()
    }
  }
}
