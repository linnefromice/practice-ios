import SwiftData
import SwiftUI

public struct TodoListView: View {
    @Query private var todos: [Todo]
    @Query private var users: [User]
    @Environment(\.modelContext) private var modelContext
    @State private var showingAddTodo = false

    public init() {}

    public var body: some View {
        NavigationStack {
            List {
                ForEach(todos) { todo in
                    VStack(alignment: .leading, spacing: 6) {
                        Text(todo.title)
                            .font(.headline)

                        Text("作成日: \(formattedDate(todo.createdAt))")
                            .font(.caption)
                            .foregroundColor(.secondary)

                        // Text("アサインID: \(todo.assigneeIds)")
                        //     .font(.caption)
                        //     .foregroundColor(.secondary)

                        if !todo.assigneeIds.isEmpty {
                            HStack(spacing: 4) {
                                Text("担当者:")
                                    .font(.caption)
                                    .foregroundColor(.secondary)

                                ForEach(getAssignees(for: todo), id: \.id) { user in
                                    Text(user.name)
                                        .font(.caption)
                                        .padding(.horizontal, 6)
                                        .padding(.vertical, 2)
                                        .background(Color.blue.opacity(0.2))
                                        .cornerRadius(4)
                                }
                            }
                        }
                    }
                    .padding(.vertical, 4)
                }
                .onDelete(perform: deleteTodos)
            }
            .navigationTitle("Todo リスト")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingAddTodo = true
                    }) {
                        Label("追加", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddTodo) {
                AddTodoView(users: users)
            }
        }
    }

    private func getAssignees(for todo: Todo) -> [User] {
        // switch todo.assigneeIds {
        // case .solo(let id):
        //     return users.filter { $0.id == id }
        // case .multiple(let ids):
        //     return users.filter { ids.contains($0.id) }
        // }
        return users.filter { todo.assigneeIds.contains($0.id) }
    }

    private func deleteTodos(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(todos[index])
        }
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.locale = Locale(identifier: "ja_JP")
        return formatter.string(from: date)
    }
}

// Todo追加用のビュー
struct AddTodoView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    @State private var title = ""
    @State private var selectedUserIds: [UUID] = []

    let users: [User]

    init(users: [User] = []) {
        self.users = users
    }

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("タイトル")) {
                    TextField("タイトル", text: $title)
                }

                Section(header: Text("担当者")) {
                    ForEach(users) { user in
                        Button(action: {
                            toggleUser(user)
                        }) {
                            HStack {
                                Text(user.name)
                                Spacer()
                                if selectedUserIds.contains(user.id) {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.blue)
                                }
                            }
                        }
                        .foregroundColor(.primary)
                    }
                }
            }
            .navigationTitle("新しいTodo")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("キャンセル") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button("追加") {
                        addTodo()
                    }
                    .disabled(title.isEmpty)
                }
            }
        }
    }

    private func toggleUser(_ user: User) {
        if selectedUserIds.contains(user.id) {
            selectedUserIds.removeAll { $0 == user.id }
        } else {
            selectedUserIds.append(user.id)
        }
    }

    private func addTodo() {
        // let assigneeIds: AssigneeVariant = selectedUserIds.count == 1
        //     ? .solo(selectedUserIds[0])
        //     : .multiple(selectedUserIds)
        let newTodo = Todo(title: title, assigneeIds: selectedUserIds)
        modelContext.insert(newTodo)
        dismiss()
    }
}

#Preview {
    TodoListView()
        .modelContainer(for: [Todo.self, User.self], inMemory: true)
}
