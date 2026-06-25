# GratefulMoments

[English](README.en.md) · [日本語](README.ja.md)

![Platform](https://img.shields.io/badge/Platform-iOS%2018.6%2B-blue)
![Swift](https://img.shields.io/badge/Swift-SwiftUI%20%7C%20SwiftData-orange)
![License](https://img.shields.io/badge/License-Apache%202.0-lightgrey)

A private gratitude journal built with SwiftUI and SwiftData. Capture small moments with a title, note, and optional photo, and let streaks and badges turn reflection into a gentle daily habit.

---

## About

**GratefulMoments** is a private gratitude journal app built with SwiftUI and SwiftData. It helps you notice and keep everyday gratitude by recording small moments with a title, note, and optional photo. A streak tracker and achievement badges turn reflection into a gentle daily habit.

## Key Features

- **Moment journaling**: Log grateful moments with a title, note, and photo
- **Photo support**: Attach images from your photo library with `PhotosPicker`
- **Hexagonal UI**: Visualize moments with a custom `HexagonLayout`
- **Streak tracking**: See your daily journaling habit at a glance
- **Achievement badges**: Unlock badges as you progress
- **Assistant**: Reflect on saved entries with a chat experience on iOS 26 or later with Apple Intelligence
- **SwiftData persistence**: Store moments and badges locally on device
- **Premium subscriptions**: Monthly and yearly subscriptions via StoreKit
- **PDF and CSV export**: Export your journal on Premium

### Available Badges

- **Start the Journey**: Log your first moment
- **5 Stars**: Record five moments
- **Shutterbug**: Add three entries with photos
- **Expressive**: Add five moments with both photo and text
- **Perfect 10**: Collect all other badges and record at least 10 moments

## Architecture

### Project Structure

```
GratefulMoments/
├── GratefulMoments/
│   ├── Custom Views/         # Reusable UI components
│   ├── Logic/                # Data container, streak calculation, and StoreKit
│   ├── Models/               # Moment, Badge, and badge management
│   ├── Resources/            # Assets, colors, and localization
│   ├── Tabs/
│   │   ├── Achievements/     # Streak and badge screens
│   │   ├── Assistant/        # Apple Intelligence reflection chat
│   │   ├── Moments/          # Moment list, entry, and detail screens
│   │   ├── Premium/          # StoreKit paywall and marketing content
│   │   └── Settings/         # App settings and legal links
│   ├── ContentView.swift     # Main tab view
│   └── GratefulMomentsApp.swift # App entry point
├── StreakCalculatorTests/    # Unit tests
└── Scripts/                  # Build and screenshot automation
```

## Privacy

- Moments and photos are stored locally on device with SwiftData.
- Your entries are not sent to external servers; exports happen only when you choose them.
- The Assistant runs on-device with Apple Intelligence on supported devices.
- No ads.

## Plans

GratefulMoments is free to start, with optional Premium subscriptions via StoreKit.

- **Free**: up to 30 moments
- **Premium** (monthly / yearly): unlimited moments, PDF & CSV export, and the reflection Assistant

## Getting Started

### Requirements

- Xcode with the iOS 26 SDK
- App deployment target: iOS 18.6 or later
- Assistant feature: iOS 26 or later, an Apple Intelligence eligible device, and Apple Intelligence enabled

### Build and Run

1. Clone the repository:
   ```bash
   git clone https://github.com/masuda-so/GratefulMoments.git
   cd GratefulMoments
   ```
2. Open `GratefulMoments.xcodeproj` in Xcode
3. Select a simulator or device, then press **Cmd+R** to build and run

### StoreKit Testing

- The shared `GratefulMoments` scheme is configured with `GratefulMoments.storekit`. Run that scheme from Xcode with **Cmd+R** to verify the Premium screen against the local StoreKit catalog.
- Direct `xcodebuild` or `simctl` launches do not attach the Xcode Run action's local StoreKit configuration, so they may show Sandbox/App Store Connect product state instead.
- Production builds on real devices can only load products that are approved and available in App Store Connect.

## Usage

1. Tap the `+` button in the Moments tab to create a new entry
2. Enter a title, note, and optionally select a photo
3. Switch to the Achievements tab to view your streak and badges
4. On supported devices, use the Assistant tab to reflect on your saved moments
5. After the free 30-moment limit, use the Premium screen to unlock unlimited moments and exports

## Status

Preparing for App Store release. See the in-repo App Store checklist for submission details.

## Support

- Support: <https://masuda-so.github.io/GratefulMoments/support/>
- Privacy Policy: <https://masuda-so.github.io/GratefulMoments/privacy/>
- Questions or bug reports: open a [GitHub Issue](https://github.com/masuda-so/GratefulMoments/issues)
- Email: so.masuda.2003@pm.me

## License

Licensed under the Apache License 2.0. See the [LICENSE](./LICENSE) file for details.

## Maintainer

- **Soh Masuda** (増田創) — original developer

Contributions are welcome. See [CONTRIBUTING](./CONTRIBUTING.md).
