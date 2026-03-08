# Time Tracker Flutter App

A complete Flutter time tracking application with local storage support.

## Features

- ✅ Track time entries with projects, tasks, notes, and dates
- ✅ View entries in two modes: All Entries and Grouped by Projects
- ✅ Empty state messages when no entries exist
- ✅ Add, view, and delete time entries
- ✅ Manage projects and tasks
- ✅ Local storage using SharedPreferences
- ✅ Material Design 3 UI
- ✅ Swipe-to-delete or delete button functionality
- ✅ Navigation drawer menu

## Setup Instructions

### Prerequisites

- Flutter SDK (3.0.0 or higher)
- Android Studio / VS Code with Flutter extensions
- An Android Emulator or iOS Simulator

### Installation

1. Navigate to the project directory:
   ```bash
   cd time_tracker
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app:
   ```bash
   flutter run
   ```

## How to Capture Required Screenshots

Follow these steps in order to capture all the required screenshots:

### 1. home-empty.png
**Empty state with no time entries**
- Launch the app for the first time
- You should see the empty state message on the "All Entries" tab
- Take a screenshot

### 2. home-empty-group.png
**Empty state on Projects tab**
- From the home screen, switch to the "Projects" tab
- You should see the empty state message
- Take a screenshot

### 3. entry-project-list.png
**Project dropdown when adding entry**
- Tap the + (floating action button)
- On the Add Time Entry screen, tap on the "Project" dropdown
- The dropdown should show the list of projects (Mobile App Development, Web Development, Backend API)
- Take a screenshot

### 4. entry-task-list.png
**Task dropdown when adding entry**
- While still on the Add Time Entry screen
- Tap on the "Task" dropdown
- The dropdown should show the list of tasks (Design, Development, Testing, Documentation)
- Take a screenshot

### 5. entry-add.png
**Add TimeEntry form filled but before submission**
- Fill in all fields:
  - Total Time: `2.5`
  - Project: `Mobile App Development`
  - Task: `Development`
  - Notes: `Working on home screen UI`
  - Date: (select today's date)
- DO NOT tap "Save Time Entry" yet
- Take a screenshot showing all filled fields

### 6. home-entries.png
**Home screen with multiple entries**
- Tap "Save Time Entry" to save the first entry
- Go back to home screen
- Add 3-4 more time entries with different projects and tasks:
  - Entry 2: 1.5 hours, Web Development, Design
  - Entry 3: 3.0 hours, Backend API, Development
  - Entry 4: 1.0 hours, Mobile App Development, Testing
- The home screen should now show multiple entries
- Take a screenshot

### 7. home-entries-group.png
**Home screen grouped by projects**
- From the home screen with multiple entries
- Switch to the "Projects" tab
- You should see entries grouped by project name with expandable sections
- Take a screenshot

### 8. entry-delete.png
**Swipe-to-delete or delete button**
- On the home screen with entries visible
- Either:
  - Swipe an entry from right to left to reveal the red delete background
  - OR hover over the delete (recycle bin) icon button on an entry
- Take a screenshot showing the delete action in progress

### 9. menu.png
**Hamburger menu open**
- From the home screen, tap the hamburger menu icon (☰) in the top left
- The drawer should open showing: Home, Projects, and Tasks menu items
- Take a screenshot

### 10. project-management.png
**Project management page**
- From the menu, tap "Projects"
- You should see the project list with the + button
- Take a screenshot

### 11. project-add.png
**Adding a new project**
- On the Project Management screen, tap the + button
- A dialog should appear with "Add New Project" title and a text field
- Type a new project name (e.g., "Marketing Campaign")
- Before tapping "Add", take a screenshot

### 12. task-management.png
**Task management page**
- From the menu, tap "Tasks"
- You should see the task list with the + button
- Take a screenshot

### 13. task-add.png
**Adding a new task**
- On the Task Management screen, tap the + button
- A dialog should appear with "Add New Task" title and a text field
- Type a new task name (e.g., "Code Review")
- Before tapping "Add", take a screenshot

### 14. local-storage-empty.png
**Local storage showing empty list**

For this screenshot, you need to inspect the app's local storage:

**Option 1 - Using Chrome DevTools (for Flutter Web):**
1. Run the app in Chrome: `flutter run -d chrome`
2. Open Chrome DevTools (F12)
3. Go to Application > Storage > Local Storage
4. Find SharedPreferences or the storage location
5. Take a screenshot showing empty storage

**Option 2 - Using Android Studio Device File Explorer:**
1. Run app on Android emulator
2. Open Android Studio > View > Tool Windows > Device File Explorer
3. Navigate to: `/data/data/com.example.time_tracker/shared_prefs/`
4. You might see the SharedPreferences XML file
5. View its contents showing empty arrays
6. Take a screenshot

**Option 3 - Using ADB:**
```bash
# For Android
adb shell
run-as com.example.time_tracker
cat /data/data/com.example.time_tracker/shared_prefs/FlutterSharedPreferences.xml
```

### 15. local-storage-filled.png
**Local storage with entries**
- After adding several time entries (from step 6)
- Use the same method as step 14 to view local storage
- You should now see JSON data with the saved entries
- Take a screenshot

## Project Structure

```
time_tracker/
├── lib/
│   ├── models/
│   │   ├── project.dart
│   │   ├── task.dart
│   │   └── time_entry.dart
│   ├── screens/
│   │   ├── home_screen.dart
│   │   ├── add_entry_screen.dart
│   │   ├── project_management_screen.dart
│   │   └── task_management_screen.dart
│   ├── services/
│   │   └── storage_service.dart
│   └── main.dart
├── pubspec.yaml
└── README.md
```

## Additional Notes

### Taking Screenshots

- **Android Emulator**: Press Ctrl+S or use the camera icon in the emulator toolbar
- **iOS Simulator**: Press Cmd+S
- **Physical Device**: Use the device's screenshot shortcut (e.g., Power + Volume Down)

### Viewing Local Storage

For local storage screenshots, you may need to:
1. Enable developer options on your device
2. Use platform-specific tools (Android Studio Device File Explorer, Xcode, etc.)
3. Or run the app in debug mode and print storage contents to console

### Troubleshooting

If you encounter any issues:
- Make sure you have Flutter installed: `flutter doctor`
- Clear app data if needed to reset storage: `flutter clean`
- Reinstall dependencies: `flutter pub get`

## Dependencies

- `shared_preferences: ^2.2.2` - Local storage
- `intl: ^0.18.1` - Date formatting
- `cupertino_icons: ^1.0.2` - iOS-style icons

## License

This is a sample project for educational purposes.
