import SwiftData
import SwiftUI

public struct UserListView: View {
    @Query private var users: [User]
    @Environment(\.modelContext) private var modelContext
    @State private var showingAddUser = false

    public init() {}

    public var body: some View {
        NavigationStack {
            List {
                ForEach(users) { user in
                    VStack(alignment: .leading) {
                        Text(user.name)
                            .font(.headline)

                        Text("ID: \(user.id.uuidString.prefix(8))...")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                .onDelete(perform: deleteUsers)
            }
            .navigationTitle("ユーザーリスト")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingAddUser = true
                    }) {
                        Label("追加", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddUser) {
                AddUserView()
            }
        }
    }

    private func deleteUsers(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(users[index])
        }
    }
}

// User追加用のビュー
struct AddUserView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    @State private var name = ""

    var body: some View {
        NavigationStack {
            Form {
                TextField("名前", text: $name)
            }
            .navigationTitle("新しいユーザー")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("キャンセル") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button("追加") {
                        addUser()
                    }
                    .disabled(name.isEmpty)
                }
            }
        }
    }

    private func addUser() {
        let newUser = User(name: name)
        modelContext.insert(newUser)
        dismiss()
    }
}

#Preview {
    UserListView()
        .modelContainer(for: [User.self], inMemory: true)
}
