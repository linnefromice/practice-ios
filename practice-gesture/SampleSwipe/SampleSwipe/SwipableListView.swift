import SwiftUI

let rows: [(name: String, imageId: String)] = [
    (name: "John Doe", imageId: "person"),
    (name: "Alice", imageId: "person"),
    (name: "Bob", imageId: "person"),
    (name: "Carol", imageId: "person"),
    (name: "Dan", imageId: "person"),
    (name: "Eve", imageId: "person"),
    (name: "Frank", imageId: "person"),
    (name: "Grace", imageId: "person"),
    (name: "Hank", imageId: "person"),
    (name: "Ivy", imageId: "person"),
    (name: "Jack", imageId: "person"),
    (name: "Kate", imageId: "person")
]

public struct SwipableListView: View {
    public init() {}

    public var body: some View {
        List {
            ForEach(rows, id: \.name) { row in
                SwipableRow(id: UUID().uuidString, name: row.name, imageId: row.imageId)
                    .listRowBackground(Color.clear)
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 4, trailing: 0))
            }
        }
    }
}

public struct SwipableRow: View {
    public let id: String
    public let name: String
    public let imageId: String

    public init(
        id: String,
        name: String,
        imageId: String
    ) {
        self.id = id
        self.name = name
        self.imageId = imageId
    }

    public var body: some View {
        HStack {
            Image(systemName: imageId)
                .frame(width: 40, height: 40)
            VStack(alignment: .leading) {
                Text(name)
                    .font(.headline)
                    .foregroundColor(.primary)
                Text("@\(id)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .swipeActions(edge: .trailing) {
            Button(action: {}) {
                Text("Mute")
            }
                .tint(.yellow)
            Button(action: {}) {
                Text("Dismiss")
            }
                .tint(.gray)
            Button(action: {}) {
                Text("Delete")
            }
                .tint(.red)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray, lineWidth: 1)
        )
    }
}

