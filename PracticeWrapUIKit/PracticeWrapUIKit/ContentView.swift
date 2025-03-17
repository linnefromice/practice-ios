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
            
            // Username field using CustomTextField
            VStack(alignment: .leading) {
                Text("Username")
                    .font(.headline)
                CustomTextField(
                    text: $username,
                    placeholder: "Enter your username",
                    keyboardType: .default,
                    returnKeyType: .next,
                    onCommit: {
                        print("Username entered: \(username)")
                    }
                )
                .frame(height: 40)
            }
            .padding(.horizontal)
            
            // Password field using CustomTextField
            VStack(alignment: .leading) {
                Text("Password")
                    .font(.headline)
                CustomTextField(
                    text: $password,
                    placeholder: "Enter your password",
                    returnKeyType: .done,
                    isSecureTextEntry: true,
                    onCommit: {
                        print("Password entered")
                    }
                )
                .frame(height: 40)
            }
            .padding(.horizontal)
            
            // Save button using CustomButton
            CustomButton(
                title: "Save",
                action: {
                    savedUsername = username
                    savedPassword = password
                    showSavedInfo = true
                    hideKeyboard()
                },
                backgroundColor: UIColor.systemBlue
            )
            .frame(width: 200, height: 50)
            .padding(.top, 20)
            
            // Clear button using CustomButton with red background
            CustomButton(
                title: "Clear",
                action: {
                    // Clear all fields and hide saved info
                    username = ""
                    password = ""
                    savedUsername = ""
                    savedPassword = ""
                    showSavedInfo = false
                    hideKeyboard()
                },
                backgroundColor: UIColor.systemRed
            )
            .frame(width: 200, height: 50)
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
