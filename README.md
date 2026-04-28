# GratefulMoments

A SwiftUI gratitude journal app that helps you capture daily moments of gratitude with notes and photos. Track your journaling streak, earn badges, and build a collection of positive memories.

![iOS](https://img.shields.io/badge/iOS-17%2B-blue)
![Swift](https://img.shields.io/badge/Swift-5.9-orange)
![Platform](https://img.shields.io/badge/Platform-iOS%20%7C%20macOS-lightgray)

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
- **macOS 14** or later (for Mac support)

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/GratefulMoments.git
   cd GratefulMoments
   ```

2. Open the project in Xcode:
   ```bash
   open GratefulMoments.xcodeproj
   ```

3. Select a simulator (e.g., iPhone 15 Pro) and press **Cmd+R** to build and run.

### Usage

1. **Add a moment** — Tap the `+` button in the Moments tab
2. **Enter details** — Add a title, optional note, and optionally select a photo
3. **Save** — Your moment is persisted automatically
4. **View achievements** — Switch to the Achievements tab to see your streak and badges

## Project structure

```
GratefulMoments/
├── Custom Views/           # Reusable UI components
│   ├── Hexagon.swift
│   ├── HexagonAccessoryView.swift
│   └── HexagonLayout.swift
├── Logic/                  # Business logic
│   ├── DataContainer.swift
│   └── StreakCalculator.swift
├── Models/                # Data models
│   ├── Badge.swift
│   ├── BadgeDetails.swift
│   ├── BadgeManager.swift
│   └── Moment.swift
├── Tabs/                  # Main app tabs
│   ├── Achievements/
│   │   ├── AchievementsView.swift
│   │   ├── BadgeDetailView.swift
│   │   ├── LockedBadgeView.swift
│   │   ├── StreakView.swift
│   │   └── UnlockedBadgeView.swift
│   └── Moments/
│       ├── MomentDetailView.swift
│       ├── MomentEntryView.swift
│       ├── MomentHexagonView.swift
│       └── MomentsView.swift
├── Assets.xcassets/       # App assets
├── ContentView.swift      # Main tab view
└── GratefulMomentsApp.swift  # App entry point
```

## Contributing

Contributions are welcome! Please read our [CONTRIBUTING.md](CONTRIBUTING.md) for details on the process for submitting pull requests.

### Development setup

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License — see the [LICENSE](LICENSE) file for details.

## Support

- **Issues** — Report bugs and request features via [GitHub Issues](https://github.com/yourusername/GratefulMoments/issues)
- **Discussions** — Use GitHub Discussions for questions and general feedback

---

Built with ❤️ using SwiftUI and SwiftData
