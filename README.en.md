# GratefulMoments

[日本語](./README.md) | English

---

## What is GratefulMoments?

**GratefulMoments** is a personal gratitude journal app built with SwiftUI. Capture daily moments of gratitude with a title, note, and optional photo. Track your journaling streak, unlock achievement badges, and build a collection of positive memories.

![iOS](https://img.shields.io/badge/iOS-17%2B-blue)
![Swift](https://img.shields.io/badge/Swift-5.9-orange)
![Platform](https://img.shields.io/badge/Platform-iOS%20%7C%20macOS-lightgray)

---

## Key Features & Benefits

- **Capture moments**: Create gratitude entries with title, note, and photo
- **Streak tracking**: Visualize your daily journaling habit
- **Earn badges**: Unlock achievements as you progress
- **Hexagonal UI**: Unique, visually appealing grid layout
- **SwiftData persistence**: All data is stored locally and securely
- **Sample data**: Pre-built moments for preview and testing

### Available Badges
- Start the Journey (log your first moment)
- 5 Stars (record five moments)
- Shutterbug (add three entries with photos)
- Expressive (add five moments with both photo and text)
- Perfect 10 (collect all badges and record at least 10 moments)

---

## Getting Started

### Requirements
- Xcode 15 or later
- iOS 17 SDK or later / macOS 14 or later

### Installation
1. Clone the repository:
    ```bash
    git clone https://github.com/yourusername/GratefulMoments.git
    cd GratefulMoments
    ```
2. Open `GratefulMoments.xcodeproj` in Xcode
3. Select a simulator or device, then press **Cmd+R** to build and run

### Usage
1. Tap the `+` button in the Moments tab to create a new entry
2. Enter a title, note, and optionally select a photo
3. Switch to the Achievements tab to view your streak and badges

---

## Project Structure

```
GratefulMoments/
├── Custom Views/          # Custom UI components
├── Logic/                 # Business logic
├── Models/                # Data models
├── Tabs/                  # Main app tabs
├── Assets.xcassets/       # Images, badges, and other assets
├── ContentView.swift      # Main tab view
└── GratefulMomentsApp.swift # App entry point
```

---

## Where to Get Help
- For questions or bug reports, open a [GitHub Issue](https://github.com/yourusername/GratefulMoments/issues)

---

## License
This project is licensed under the Apache License 2.0. See the [LICENSE](./LICENSE) file for details.

---

## Who Maintains and Contributes
- Soh Masuda — Original developer
- Contributions are welcome! See [CONTRIBUTING.md](./CONTRIBUTING.md) (coming soon) for details.