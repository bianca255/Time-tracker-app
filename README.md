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
