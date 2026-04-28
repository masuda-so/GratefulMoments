# GratefulMoments

A SwiftUI gratitude journal app for capturing small wins, notes, and optional photos. The project includes a SwiftData-backed model layer and a prepared moment entry screen for future app flow integration.

## Why this project is useful

- Provides a simple foundation for a gratitude journaling app.
- Includes a `Moment` model with title, note, timestamp, and optional image support.
- Uses `SwiftData` for local persistence and sample data loading for previewing content.
- Demonstrates modern SwiftUI patterns such as `PhotosPicker`, `NavigationStack`, and data environment injection.

## Key features

- Add gratitude moments with a title, note, and optional photo.
- Persist entries locally using `SwiftData`.
- Sample data is available in previews for quick UI validation.
- Clean, modular structure separated into `Models`, `Logic`, and UI tabs.

## Getting started

### Requirements

- Xcode 15 or later
- iOS 17 or later SDK

### Open the project

```bash
cd /path/to/GratefulMoments
open GratefulMoments.xcodeproj
```

### Run in Xcode

1. Select the `GratefulMoments` target.
2. Choose a simulator or device.
3. Build and run.

### Development notes

- `GratefulMomentsApp.swift` is the app entry point and creates the `DataContainer`.
- `DataContainer.swift` configures the `SwiftData` model container and sample data loader.
- `Models/Moment.swift` defines the persisted gratitude entry model.
- `Tabs/Moments/MomentEntryView.swift` provides the moment creation UI and photo picker integration.

## Project structure

- `GratefulMoments/` – main app source files
- `GratefulMoments/Models/` – data model definitions
- `GratefulMoments/Logic/` – persistence and data container logic
- `GratefulMoments/Tabs/` – feature-specific UI views
- `LICENSE` – project license

## Help and contributions

If you have questions or want to contribute, open an issue or submit a pull request.

For license details, see `LICENSE`.
