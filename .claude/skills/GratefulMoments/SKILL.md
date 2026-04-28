# GratefulMoments Development Patterns

> Repository-specific skill from ECC repository analysis, corrected against the current Swift project.

## Overview
GratefulMoments is a SwiftUI and SwiftData iOS app with a dedicated Swift Testing target. Use this skill when making code, test, or workflow changes in this repository so changes stay aligned with the existing Xcode project structure.

## Project Shape

- App target: `GratefulMoments`
- Test target: `GratefulMomentsTests`
- Xcode project: `GratefulMoments.xcodeproj`
- Main app sources live under `GratefulMoments/`.
- Tests live in target-specific folders such as `StreakCalculatorTests/`.
- Feature UI is grouped by tab under `GratefulMoments/Tabs/`.
- Shared models and business logic live in `GratefulMoments/Models/` and `GratefulMoments/Logic/`.

## Coding Conventions

### File Naming
- Use **PascalCase** for all file names.
- Keep SwiftUI view files, model files, and test files named after their primary type.
- Existing examples: `MomentEntryView.swift`, `BadgeManager.swift`, `StreakCalculatorTests.swift`

### Import Style
- Swift files import modules and frameworks directly; do not use relative path imports.
- Common imports in this project include `SwiftUI`, `SwiftData`, `Foundation`, `PhotosUI`, and `Testing`.
- Tests use `@testable import GratefulMoments` when they need access to app internals.

### Type and Member Visibility
- Prefer Swift's default internal visibility for app-only types.
- Add `private` for view helpers and state that should not escape the file or type.
- Add broader access only when a real cross-module need appears.

### Commit Messages
- Follow **conventional commit** patterns.
- Prefixes: `chore`, `feat`
- Keep subjects concise and imperative.
- Existing examples: `feat: add Assistant tab with on-device LLM chat`, `chore: ignore .claude worktree directory`

## Workflows

- Open the project with Xcode: `open GratefulMoments.xcodeproj`
- Use the `GratefulMoments` scheme for app builds and tests.
- No GitHub Actions workflow is currently present in this repository.

## Testing Patterns

- **Framework:** Swift Testing
- Test files use PascalCase names ending in `Tests.swift`.
- Use `@Test` and `#expect(...)` for assertions.
- Keep logic tests in a dedicated test target folder, as with `StreakCalculatorTests/StreakCalculatorTests.swift`.

## Commands
| Command | Purpose |
| --- | --- |
| `xcodebuild -list -project GratefulMoments.xcodeproj` | Confirm schemes and targets |
| `xcodebuild test -project GratefulMoments.xcodeproj -scheme GratefulMoments -destination '<available iOS Simulator>'` | Run the Swift Testing suite |
| `open GratefulMoments.xcodeproj` | Open the app in Xcode |
