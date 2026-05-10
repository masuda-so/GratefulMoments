# GratefulMoments

[日本語](./README.md) | English

---

## What is GratefulMoments?

**GratefulMoments** is a personal gratitude journal app built with SwiftUI. Capture daily moments of gratitude with a title, note, and optional photo. Track your journaling streak, unlock achievement badges, and build a collection of positive memories.

![iOS](https://img.shields.io/badge/iOS-18.6%2B-blue)
![Swift](https://img.shields.io/badge/Swift-SwiftUI%20%7C%20SwiftData-orange)
![Platform](https://img.shields.io/badge/Platform-iOS-lightgray)

---

## Key Features

- **Capture moments**: Create gratitude entries with a title, note, and photo
- **Photo support**: Attach images from the photo library with `PhotosPicker`
- **Hexagonal UI**: Display moments with a custom `HexagonLayout`
- **Streak tracking**: Visualize your daily journaling habit
- **Achievement badges**: Unlock badges as you progress
- **Assistant**: Reflect on saved moments with a chat experience on iOS 26 or later with Apple Intelligence
- **SwiftData persistence**: Store moments and badges locally
- **Sample data**: Preview and test the app with built-in sample moments

### Available Badges

- **Start the Journey**: Log your first moment
- **5 Stars**: Record five moments
- **Shutterbug**: Add three entries with photos
- **Expressive**: Add five moments with both photo and text
- **Perfect 10**: Collect all other badges and record at least 10 moments

---

## Getting Started

### Requirements

- Xcode with the iOS 26 SDK
- App deployment target: iOS 18.6 or later
- Assistant feature: iOS 26 or later, an Apple Intelligence eligible device, and Apple Intelligence enabled

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/masuda-so/GratefulMoments.git
   cd GratefulMoments
   ```
2. Open `GratefulMoments.xcodeproj` in Xcode
3. Select a simulator or device, then press **Cmd+R** to build and run

### Usage

1. Tap the `+` button in the Moments tab to create a new entry
2. Enter a title, note, and optionally select a photo
3. Switch to the Achievements tab to view your streak and badges
4. On supported devices, use the Assistant tab to reflect on your saved moments

---

## Project Structure

```text
GratefulMoments/
├── Custom Views/            # Reusable UI components
├── Logic/                   # Data container and streak calculation
├── Models/                  # Moment, Badge, and badge management
├── Tabs/
│   ├── Achievements/        # Streak and badge screens
│   ├── Assistant/           # Apple Intelligence reflection chat
│   └── Moments/             # Moment list, entry, and detail screens
├── Resources/               # Assets, colors, and localization
├── ContentView.swift        # Main tab view
└── GratefulMomentsApp.swift # App entry point
```

---

## Where to Get Help

- Support information: [Support](https://masuda-so.github.io/GratefulMoments/support/)
- Privacy policy: [Privacy Policy](https://masuda-so.github.io/GratefulMoments/privacy/)
- For questions or bug reports, open a [GitHub Issue](https://github.com/masuda-so/GratefulMoments/issues)

---

## License

This project is licensed under the Apache License 2.0. See the [LICENSE](./LICENSE) file for details.

---

## Who Maintains and Contributes

- Soh Masuda - Original developer
- Contributions are welcome. Contribution guidelines are coming soon.
