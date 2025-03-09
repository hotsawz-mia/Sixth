//
//  ContentView.swift
//  Sixth
//
//  Created by Mark James on 09/03/2025.
//

import SwiftUI

struct Todo: Codable {
    let title: String
}

struct ContentView: View {
    @State private var data: String = "Loading..."
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text(data)
                .padding()
            Button("Fetch Data") {
                fetchData()
            }
        }
        .padding()
    }
    func fetchData() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/todos/1") else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, let todo = try? JSONDecoder().decode(Todo.self, from: data) {
                DispatchQueue.main.async {
                    self.data = todo.title
                }
            }
        }.resume()
    }
}

#Preview {
    ContentView()
}
