# GratefulMoments

A starter SwiftUI gratitude journal app that captures small wins, notes, and optional photos. The codebase includes a SwiftData-backed model layer, a reusable `MomentEntryView`, and a basic app shell ready for UI flow expansion.

## What this project does

`GratefulMoments` provides the foundation for a personal gratitude journal app. It defines a persisted `Moment` model, sample data for previews, and an entry form for adding titled notes with optional images.

## Why this project is useful

- Builds a modern SwiftUI + SwiftData app scaffold.
- Demonstrates local persistence with `ModelContainer` and `ModelContext`.
- Includes a working moment entry screen with `PhotosPicker` support.
- Separates concerns into `Models`, `Logic`, and UI tabs for easier extension.

## Key features

- Captures gratitude moments with title, note, timestamp, and optional photo.
- Saves entries locally using SwiftData.
- Provides sample data in previews for fast UI development.
- Uses `@Observable`, environment injection, and navigation tooling.

## Getting started

### Requirements

- Xcode 15 or later
- iOS 17 or later SDK

### Open the project

```bash
cd /path/to/GratefulMoments
open GratefulMoments.xcodeproj
```

### Run the app

1. Open `GratefulMoments.xcodeproj` in Xcode.
2. Select the `GratefulMoments` target.
3. Choose a simulator or connected device.
4. Build and run.

### Usage

The app currently includes the starter app shell and a moment entry screen component. Extend the UI to display saved moments, connect tabs, and wire navigation to `MomentEntryView`.

## Project structure

- `GratefulMoments/` – SwiftUI app source files
- `GratefulMoments/Models/` – persisted data models
- `GratefulMoments/Logic/` – data container and sample data loader
- `GratefulMoments/Tabs/` – feature UI views and tab screens
- `LICENSE` – project license

## Help and contributions

This repository is open for contributions. If you want to improve the app, please open an issue or submit a pull request.

For license details, see `LICENSE`.
