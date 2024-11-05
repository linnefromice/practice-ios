import SwiftUI

struct AddTaskView: View {
    @State var taskData: TaskViewModel
    @State private var newTaskName = ""
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        let _ = print("Add Task view....")
        VStack {
            Text("Add Task Name")
                .font(.headline)
                .padding(.bottom, 30)
             TextField("Enter task name", text: $newTaskName)
                .padding()
            Button("Add Task") {
                taskData.addTask(name: newTaskName)
                newTaskName = ""
                dismiss()
            }
        }
    }
}
