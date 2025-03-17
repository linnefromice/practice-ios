import SwiftUI
import UIKit

struct ContentView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var savedUsername = ""
    @State private var savedPassword = ""
    @State private var showSavedInfo = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Login")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 20)
            
            // Username field
            VStack(alignment: .leading) {
                Text("Username")
                    .font(.headline)
                TextField("Enter your username", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(height: 40)
            }
            .padding(.horizontal)
            
            // Password field
            VStack(alignment: .leading) {
                Text("Password")
                    .font(.headline)
                SecureField("Enter your password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(height: 40)
            }
            .padding(.horizontal)
            
            // Save button
            Button("Save") {
                savedUsername = username
                savedPassword = password
                showSavedInfo = true
                hideKeyboard()
            }
            .frame(width: 200, height: 50)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
            .padding(.top, 20)
            
            // Clear button
            Button("Clear") {
                savedUsername = ""
                savedPassword = ""
                username = ""
                password = ""
                showSavedInfo = false
                hideKeyboard()
            }
            .frame(width: 200, height: 50)
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(8)
            .padding(.top, 10)
            
            // Display saved information
            if showSavedInfo {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Saved Information:")
                        .font(.headline)
                    Text("Username: \(savedUsername)")
                    Text("Password: \(savedPassword.map { _ in "•" }.joined())")
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
                .padding(.horizontal)
                .padding(.top, 20)
            }
            
            Spacer()
        }
        .padding()
        .onTapGesture {
            hideKeyboard()
        }
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

#Preview {
    ContentView()
}
