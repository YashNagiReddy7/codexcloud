# CodexCloud - WakeUp iOS Alarm App

This repository now contains the full latest SwiftUI MVVM alarm app code under the `WakeUp/` directory.

## Project structure

```text
WakeUp/
├── Models/
│   └── Alarm.swift
├── Services/
│   ├── AlarmStorageService.swift
│   └── NotificationService.swift
├── ViewModels/
│   ├── AlarmViewModel.swift
│   └── AppNavigationState.swift
├── Views/
│   ├── AlarmSetupView.swift
│   ├── HomeView.swift
│   └── TaskView.swift
└── WakeUpApp.swift
```

## Current features included

- Alarm model (`time`, `isActive`, `streak`)
- `UserDefaults` persistence for alarm state
- Local notification permission + daily scheduling
- Notification tap routing into Task flow
- Locked full-screen `TaskView` that only dismisses on task completion action
- Simple SwiftUI MVVM structure with `NavigationStack`

## Quick verification commands

From repo root:

```bash
find WakeUp -maxdepth 3 -type f | sort
```

To print all current source files:

```bash
for f in $(find WakeUp -type f | sort); do
  echo "\n===== $f ====="
  cat "$f"
done
```
