
# TaskManager - SwiftUI

![SwiftUI Badge](https://img.shields.io/badge/SwiftUI-orange)
![iOS Badge](https://img.shields.io/badge/iOS-15.0+-blue.svg)
![JSON Badge](https://img.shields.io/badge/Storage-JSON-yellow)

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

## Overview

TaskManager is a SwiftUI-based iOS application designed for task management. Categorize your tasks into "Working On", "To Do", and "Done" sections and manage your daily activities with ease. This project leverages the MVVM architecture and uses JSON encoding to save data to a text file.

![App Screenshot](./docs/screenshot.png)

## Features

- Intuitive UI built with SwiftUI
- Three categories for task management: Working On, To Do, Done
- Swipe to delete tasks
- Tap to edit tasks
- Data persistence using JSON encoding to a text file

## Requirements

- iOS 15.0+
- Xcode 13.0+
- SwiftUI 3.0+

## Installation

1. Clone the repository:

    ```bash
    git clone https://github.com/KyleZeller02/TaskManager.git
    ```

2. Navigate to the project directory:

    ```bash
    cd TaskManager
    ```

3. Open the Xcode project:

    ```bash
    open TaskManager.xcodeproj
    ```

4. Run the app using the Xcode simulator or a physical device.

## Usage

1. **Add a Task**: Use the "Add" button on the navigation bar to create a new task.
2. **Edit a Task**: Tap on an existing task to modify its content.
3. **Delete a Task**: Swipe left on a task to delete it.
4. **Category Navigation**: Scroll through different sections to see tasks categorized as "Working On", "To Do", and "Done".
