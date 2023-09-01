//  ContentView.swift
//  ToDoList
//  Created by Kyle Zeller on 8/31/23.
//
//  This file contains the main view and the section view for displaying tasks.

import SwiftUI

// MARK: - TaskManagerView

/// Represents the main view of the Task Manager application.
/// It provides the user interface for listing tasks categorized by their states,
/// and for adding new tasks.
// MARK: - TaskManagerView

struct TaskManagerView: View {
    
    // MARK: - Properties
    @ObservedObject var taskViewModel = TaskViewModel()
    @State private var showingNewTaskSheet = false
    @State private var editingTask: Task?
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            VStack {
                TaskSectionView(title: "Working On 🎨", taskViewModel: taskViewModel, tasks: taskViewModel.workingOnTasks, showingNewTaskSheet: $showingNewTaskSheet, editingTask: $editingTask)
                TaskSectionView(title: "To Do 📝", taskViewModel: taskViewModel, tasks: taskViewModel.todoTasks, showingNewTaskSheet: $showingNewTaskSheet, editingTask: $editingTask)
                TaskSectionView(title: "Done ✔️", taskViewModel: taskViewModel, tasks: taskViewModel.doneTasks, showingNewTaskSheet: $showingNewTaskSheet, editingTask: $editingTask)
            }
            .navigationBarTitle("Task Manager", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                editingTask = nil  // Clear the task being edited
                showingNewTaskSheet = true
            }) {
                Text("Add")
                    .fontWeight(.bold)
                    .foregroundColor(Color.blue)
            })
            .sheet(isPresented: $showingNewTaskSheet) {
                NewTaskFormView(taskViewModel: self.taskViewModel, task: self.$editingTask)
            }
        }
    }
}


// MARK: - TaskSectionView

/// Represents a section of tasks, categorized by their states.
/// Provides UI for each task and allows tasks to be tapped for editing.
// MARK: - TaskSectionView

struct TaskSectionView: View {
    
    // MARK: - Properties
    var title: String
    @ObservedObject var taskViewModel: TaskViewModel
    var tasks: [Task]
    @Binding var showingNewTaskSheet: Bool
    @Binding var editingTask: Task?
    
    // MARK: - Body
    var body: some View {
        List {
            Section(header: Text(title)
                        .font(.headline)
                        .foregroundColor(Color.orange)) {
                ForEach(tasks, id: \.id) { task in
                    HStack {
                        Image(systemName: task.state == .done ? "checkmark.circle.fill" : "circle")
                            .foregroundColor(task.state == .done ? .green : .red)
                        Text(task.title)
                            .foregroundColor(.black)
                    }
                    .swipeActions {
                        Button("Delete") {
                            if let index = taskViewModel.tasks.firstIndex(where: { $0.id == task.id }) {
                                taskViewModel.deleteTask(at: IndexSet(integer: index))
                            }
                        }
                        .tint(.red)
                    }
                    .onTapGesture {
                        self.editingTask = task  // Setting for editing
                        showingNewTaskSheet = true
                    }
                }
            }
        }
    }
}



// MARK: - SwiftUI Preview

/// Provides a preview of `TaskManagerView` in the Xcode canvas.
struct TaskManagerView_Previews: PreviewProvider {
    static var previews: some View {
        TaskManagerView()
    }
}
