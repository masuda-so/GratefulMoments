# Grateful Moments

A native iOS gratitude journal app built with SwiftUI and SwiftData that helps users cultivate daily gratitude through journaling moments with photos and text.

![iOS](https://img.shields.io/badge/iOS-18.2+-blue.svg)
![Swift](https://img.shields.io/badge/Swift-6.0-orange.svg)
![SwiftUI](https://img.shields.io/badge/SwiftUI-6.0-blue.svg)
![SwiftData](https://img.shields.io/badge/SwiftData-Latest-green.svg)

## Features

### 📝 Moment Journaling
- Create gratitude entries with titles, notes, and optional photos
- View moments in a unique hexagonal layout path
- Navigate through your gratitude journey with smooth scroll transitions
- Each moment is timestamped for streak tracking

### 🏆 Achievement System
- Unlock badges as you progress on your gratitude journey:
  - **Start the Journey**: Log your first moment
  - **5 Stars**: Record five moments
  - **Shutterbug**: Add three entries with photos
  - **Expressive**: Add five moments with both photos and text
  - **Perfect 10**: Record at least 10 moments while collecting all other badges
- Track unlocked and locked badges with visual indicators
- Receive congratulatory messages when unlocking achievements

### 🔥 Streak Tracking
- Maintain your daily gratitude practice
- Visual streak counter shows consecutive days of logging moments
- Streak continues even if you haven't posted yet today

### 🎨 Beautiful UI
- Custom hexagon views with dynamic layouts
- Smooth scroll animations and transitions
- Dark mode support
- Dynamic Type support (up to XXXLarge)
- Color-coded badges with custom assets

## Requirements

- iOS 18.2 or later
- Xcode 16.0 or later
- Swift 6.0

## Getting Started

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

3. Build and run the project:
   - Select a simulator or connected device
   - Press `Cmd + R` to build and run

### Usage

#### Creating a Moment
```swift
// The app provides a simple interface to create moments
// Users can:
// 1. Tap the + button in the Moments tab
// 2. Add a title and note
// 3. Optionally attach a photo
// 4. Save the moment
```

#### Viewing Achievements
Navigate to the Achievements tab to:
- View your current streak
- See unlocked badges with timestamps
- Browse locked badges and their requirements

## Project Structure

```
GratefulMoments/
├── Models/
│   ├── Moment.swift          # Core data model for gratitude entries
│   ├── Badge.swift           # Badge data model
│   ├── BadgeDetails.swift    # Badge requirements and metadata
│   └── BadgeManager.swift    # Badge unlock logic
├── Tabs/
│   ├── Moments/              # Moment viewing and creation UI
│   └── Achievements/         # Achievement tracking UI
├── Logic/
│   ├── DataContainer.swift   # SwiftData container setup
│   └── StreakCalculator.swift # Streak calculation logic
├── Custom Views/
│   ├── Hexagon.swift         # Hexagon shape
│   ├── HexagonLayout.swift   # Hexagon layout system
│   └── HexagonAccessoryView.swift
└── Assets.xcassets/
    ├── Badges/               # Badge imagery
    ├── Colors/               # Custom color palette
    └── Samples/              # Sample images
```

## Architecture

The app follows a clean SwiftUI architecture:

- **SwiftData**: Used for persistent storage of moments and badges
- **MVVM Pattern**: Views are separated from data models
- **Observable Framework**: Modern state management with `@Observable`
- **SwiftUI Navigation**: NavigationStack for hierarchical navigation

### Key Components

#### Moment Model
```swift
@Model
class Moment {
    var title: String
    var note: String
    var imageData: Data?
    var timestamp: Date
    var badges: [Badge]
}
```

#### Streak Calculation
The `StreakCalculator` counts consecutive days with at least one moment logged, measuring from the end of each day.

#### Badge System
Badges are automatically unlocked when criteria are met through the `BadgeManager`, which monitors moment creation and updates badge states.

## Testing

The project includes unit tests for core functionality:

```bash
# Run tests in Xcode
Cmd + U

# Tests are located in:
GratefulMomentsTests/
└── StreakCalculatorTests.swift
```

## Contributing

Contributions are welcome! Here's how you can help:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

Please ensure your code:
- Follows Swift style guidelines
- Includes appropriate documentation
- Passes all existing tests
- Adds tests for new functionality

## Support

For questions, issues, or feature requests:
- Open an issue on GitHub
- Check existing issues for similar problems
- Provide detailed reproduction steps for bugs

## Roadmap

Potential future enhancements:
- iCloud sync across devices
- Export/backup functionality
- Customizable themes
- Reminder notifications
- Share moments with friends
- Statistics and insights
- Additional badge types

## License

This project is available for educational and portfolio purposes. Please check the LICENSE file for more details.

## Acknowledgments

- Built with SwiftUI and SwiftData
- Custom hexagon layout for unique visual presentation
- Badge assets and color palette designed for encouraging user engagement

---

**Note**: This app is designed to help users develop a gratitude practice. Regular journaling has been shown to improve mental well-being and overall happiness.
