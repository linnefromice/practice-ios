import Foundation

@Observable
class TaskModel: Identifiable {
    let id = UUID()
    var name: String
    var isCompleted: Bool = false
    
    init(name: String, isCompleted: Bool) {
        self.name = name
        self.isCompleted = isCompleted
    }
}

@Observable
class TaskViewModel {
    var tasks: [TaskModel] = []
    
    init() {
        // mock data
        tasks.append(TaskModel(name: "Task 1", isCompleted: false))
        tasks.append(TaskModel(name: "Task 2", isCompleted: false))
        tasks.append(TaskModel(name: "Task 3", isCompleted: true))
    }
    
    func addTask(name: String) {
        tasks.append(TaskModel(name: name, isCompleted: false))
    }
}
