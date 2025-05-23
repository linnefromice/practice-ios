import SwiftUI

struct TaskListView: View {
    @State var taskData = TaskViewModel()
    @State private var selectedTask: TaskModel? = nil
    @State private var isEdit = false
    
    var body: some View {
        VStack {
            List {
                ForEach($taskData.tasks) { $task in
                    Button {
                        selectedTask = task
                    } label: {
                        HStack {
                            Text(task.name)
                            Spacer()
                            Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                        }
                    }
                }
            }
            Spacer()
            Button("Add Task") {
                isEdit = true
            }
            .padding(.bottom)
            .sheet(item: $selectedTask) { task in
                TaskDetailsView(task: task)
            }
            .sheet(isPresented: $isEdit, content: {
                AddTaskView(taskData: taskData)
            })
            
        }
    }
}

#Preview {
    TaskListView()
}
