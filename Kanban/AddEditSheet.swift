//  NewTaskFormView.swift
//  ToDoList
//  Created by Kyle Zeller on 8/31/23.
//
//  This file contains the form view for adding and editing tasks.

import SwiftUI

// MARK: - NewTaskFormView

/// Represents the form for adding a new task or editing an existing one.
/// It provides the user interface for inputting task details and saves it to the view model.
struct NewTaskFormView: View {
    
    // MARK: - Environment
    
    /// An environment object that allows dismissing this view.
    @Environment(\.presentationMode) var presentationMode
    
    // MARK: - Properties
    
    /// The view model for managing tasks.
    @ObservedObject var taskViewModel: TaskViewModel
    
    /// A binding to the task that is being edited, if any.
    @Binding var task: Task?
    
    // MARK: - Temporary State Variables
    
    /// Temporary storage for the task title.
    @State private var title = ""
    
    /// Temporary storage for the task state.
    @State private var state = TaskState.workingOn
    
    // MARK: - Body
    
    /// The body of the `NewTaskFormView`.
    var body: some View {
        NavigationView {
            Form {
                // TextField for editing the task's title
                // `title` is a @State property and should not be nil or empty when saving
                TextField("Title", text: $title)
                
                // Picker for selecting the task's state (e.g., Working On, To Do, Done)
                // `state` is a @State property and will always have a default value
                Picker("State", selection: $state) {
                    ForEach(TaskState.allCases, id: \.self) { state in
                        Text(state.rawValue).tag(state)
                    }
                }
            }
            // Sets the title of the navigation bar based on whether a task is being edited or created
            .navigationBarTitle(task == nil ? "New Task" : "Edit Task", displayMode: .inline)
            
            // Adds Cancel and Save buttons to the navigation bar
            .navigationBarItems(leading: Button("Cancel") {
                // Dismisses the view when the Cancel button is tapped
                presentationMode.wrappedValue.dismiss()
            }, trailing: Button("Save") {
                // Checks if a task is being edited (i.e., task is not nil)
                if let taskToEdit = task {
                    // Updates the existing task with new values
                    // Note: Assumes `title` and `state` are valid
                    taskViewModel.updateTask(Task(id: taskToEdit.id, title: title, state: state))
                } else {
                    // Creates a new task with the given `title` and `state`
                    // Generates a new UUID for the task
                    // Note: Assumes `title` is not empty
                    taskViewModel.addTask(Task(id: UUID().uuidString, title: title, state: state))
                }
                
                // Dismisses the view after saving or updating the task
                presentationMode.wrappedValue.dismiss()
            })
        }
        .onAppear {
            // Initializes state variables with the task data if a task is passed for editing
            // This block will only execute if `task` is not nil
            if let task = task {
                title = task.title
                state = task.state
            }
        }
    }

}
