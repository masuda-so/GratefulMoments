# GratefulMoments

A SwiftUI gratitude journal app that helps you capture daily moments of gratitude with notes and photos. Track your journaling streak, earn badges, and build a collection of positive memories.

![iOS](https://img.shields.io/badge/iOS-17%2B-blue)
![Swift](https://img.shields.io/badge/Swift-5.9-orange)
![Platform](https://img.shields.io/badge/Platform-iOS%20%7C%20macOS-lightgray)

[日本語](./README.md) | English

## What the project does

GratefulMoments is a personal gratitude journal app that lets you:

- **Capture moments** — Record gratitude entries with a title, note, and optional photo
- **Track your streak** — Monitor consecutive days of journaling to build a consistent habit
- **Earn badges** — Unlock achievements as you progress on your gratitude journey
- **Browse history** — View your past moments in a visually appealing hexagonal layout

## Why the project is useful

- **Build positive habits** — Daily gratitude journaling has been linked to improved well-being
- **Modern SwiftUI patterns** — Demonstrates `@Observable`, SwiftData, and environment injection
- **Custom UI components** — Includes a unique hexagonal grid layout for displaying moments
- **Badge motivation system** — Gamifies the journaling experience with unlockable achievements

## Key features

| Feature | Description |
|---------|-------------|
| Moment capture | Create entries with title, note, and optional photo |
| Photo support | Use `PhotosPicker` to attach images from your library |
| SwiftData persistence | All moments stored locally using SwiftData |
| Streak tracking | Calculate consecutive journaling days |
| Badge system | Unlock achievements based on activity |
| Hexagonal UI | Custom `HexagonLayout` for visual moment display |
| Sample data | Pre-built sample moments for previews and testing |

### Available Badges

- **Start the Journey** — Log your first moment
- **5 Stars** — Record five moments
- **Shutterbug** — Add three entries with photos
- **Expressive** — Add five moments with both photo and text
- **Perfect 10** — Record at least 10 moments while collecting all other badges

## Getting started

### Requirements

- **Xcode 15** or later
- **iOS 17** or later SDK

### Build and run

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/GratefulMoments.git
   ```

2. Open `GratefulMoments.xcodeproj` in Xcode

3. Select a target simulator or device

4. Press `Cmd + R` to build and run

### Usage

1. **Record a moment**: Tap the `+` button to create a new gratitude entry
2. **Add photos**: Use the photo picker to attach images
3. **View history**: Browse past moments in the hexagonal layout
4. **View achievements**: Switch to the Achievements tab to see unlocked badges

## Project structure

```
GratefulMoments/
├── Custom Views/          # Custom UI components
│   ├── Hexagon.swift
│   ├── HexagonAccessoryView.swift
│   └── HexagonLayout.swift
├── Logic/                 # Business logic
│   ├── DataContainer.swift
│   └── StreakCalculator.swift
├── Models/                # Data models
│   ├── Badge.swift
│   ├── BadgeDetails.swift
│   ├── BadgeManager.swift
│   └── Moment.swift
└── Tabs/                  # Screen tabs
    ├── Achievements/
    └── Moments/
```

## Where to get help

- If you have issues or questions, create a [GitHub Issue](https://github.com/yourusername/GratefulMoments/issues)
- Bug reports and feature requests are welcome

## License

This project is licensed under the MIT License - see the [LICENSE](../LICENSE) file for details.

## Who maintains and contributes

- 増田創 (Soh Masuda) — Original developer

Contributions are welcome! See [CONTRIBUTING.md](../CONTRIBUTING.md) (coming soon) for details.