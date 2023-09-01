//
//  TaskViewModel.swift
//  ToDoList
//
//  Created by Kyle Zeller on 8/31/23.
//
//  This ViewModel is responsible for managing tasks in the application.
//  It provides a centralized point for reading and writing tasks to a local storage file.

import Foundation
import Combine

// MARK: - TaskViewModel

/// Manages the tasks for the application.
class TaskViewModel: ObservableObject {
    
    // MARK: - Properties
    
    /// The list of tasks managed by the ViewModel.
    @Published var tasks: [Task] = []
    
    // MARK: - Initializer
    
    /// Initializes the ViewModel and loads tasks from storage.
    /// Expected state: Empty or pre-populated task list.
    init() {
        loadTasks()
    }
    
    // MARK: - Computed Properties
    
    /// Filtered list of tasks that are currently being worked on.
    var workingOnTasks: [Task] { tasks.filter { $0.state == .workingOn } }
    
    /// Filtered list of tasks that are yet to be done.
    var todoTasks: [Task] { tasks.filter { $0.state == .todo } }
    
    /// Filtered list of tasks that are completed.
    var doneTasks: [Task] { tasks.filter { $0.state == .done } }
    
    // MARK: - Private Methods
    
    /// Loads tasks from local storage.
    /// Expected state: The tasks array should be empty before this call.
    private func loadTasks() {
        let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let filePath = documentsPath.appendingPathComponent("tasks.txt")

        // Check if file exists
        if FileManager.default.fileExists(atPath: filePath.path) {
            do {
                let data = try Data(contentsOf: filePath)
                if let decodedTasks = try? JSONDecoder().decode([Task].self, from: data) {
                    self.tasks = decodedTasks
                }
            } catch {
                print("Error reading tasks: \(error)")
            }
        }
    }
    
    /// Saves tasks to local storage.
    /// Expected state: `tasks` array should contain the tasks to be saved.
    private func saveTasks() {
        let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let filePath = documentsPath.appendingPathComponent("tasks.txt")

        if let data = try? JSONEncoder().encode(tasks) {
            do {
                try data.write(to: filePath)
            } catch {
                print("Error saving tasks: \(error)")
            }
        }
    }
    
    // MARK: - Public Methods
    
    /// Adds a new task.
    /// - Parameter task: The task to be added. Must not be nil.
    /// - Precondition: `task` must be a non-nil Task object.
    /// - Postcondition: The task is appended to the list and saved.
    func addTask(_ task: Task) {
        tasks.append(task)
        saveTasks()
    }
    
    /// Updates an existing task.
    /// - Parameter updatedTask: The updated task. Must not be nil, and should have a valid `id`.
    /// - Precondition: `updatedTask` must have a non-nil and valid `id`.
    /// - Postcondition: The task is updated in the list and saved. If the task does not exist, no operation is performed.
    func updateTask(_ updatedTask: Task) {
        if let index = tasks.firstIndex(where: { $0.id == updatedTask.id }) {
            tasks[index] = updatedTask
            saveTasks()
        }
    }
    
    // MARK: - Task Deletion

    /// Removes a task based on its index in the `tasks` array.
    /// - Parameter indexSet: An index set containing the indices of the tasks to be removed.
    func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
        saveTasks()  // Persist the changes
    }
}
