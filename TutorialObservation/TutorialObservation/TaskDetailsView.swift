import SwiftUI

struct TaskDetailsView: View {
    @Bindable var task: TaskModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            Text("Update Task Detail")
                .font(.headline)
                .padding(.bottom)
            TextField("Enter task name", text: $task.name)
                .padding()
            Toggle("Completed", isOn: $task.isCompleted)
                .padding([.bottom, .horizontal], 30)
            Button("Close") {
                dismiss()
            }
        }
    }
}
