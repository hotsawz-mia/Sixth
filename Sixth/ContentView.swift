import SwiftUI

struct ContentView: View {
    @State private var message: String = "Loading..."
    @State private var isLoading = true
    @State private var showError = false

    var body: some View {
        VStack {
            if isLoading {
                ProgressView("Fetching data...")  // Show a loading indicator
            } else if showError {
                Text("Failed to fetch data. Please try again.")
                    .foregroundColor(.green)
                    .padding()
            } else {
                Text(message)
                    .font(.title)
                    .padding()
            }
        }
        .onAppear {
            fetchData()
        }
    }

    func fetchData() {
        guard let url = URL(string: "http://127.0.0.1:8000/") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false  // Stop loading
                
                if let error = error {
                    print("Request failed: \(error.localizedDescription)")
                    self.showError = true
                    return
                }
                
                if let data = data, let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
                    self.message = json["message"] as? String ?? "No message has been found"
                } else {
                    self.showError = true
                }
            }
        }.resume()
    }
}
