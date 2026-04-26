```markdown
# GratefulMoments Development Patterns

> Auto-generated skill from repository analysis

## Overview
This skill teaches the core development patterns and conventions used in the GratefulMoments Swift codebase. It covers file naming, import/export styles, commit message conventions, and testing patterns. The repository does not use a detected framework or automated workflows, focusing on clear, maintainable Swift code.

## Coding Conventions

### File Naming
- Use **PascalCase** for all file names.
  - Example: `GratefulEntry.swift`, `UserProfileView.swift`

### Import Style
- Use **relative imports** within the codebase.
  - Example:
    ```swift
    import "../Models/GratefulEntry"
    ```

### Export Style
- Use **named exports** for all Swift entities.
  - Example:
    ```swift
    public struct GratefulEntry { ... }
    ```

### Commit Messages
- Follow **conventional commit** patterns.
- Prefixes: `chore`, `feat`
- Average length: ~44 characters.
  - Example:
    ```
    feat: add daily gratitude entry model
    chore: update README with usage instructions
    ```

## Workflows

_No automated workflows detected in this repository._

## Testing Patterns

- **Framework:** Unknown (no specific testing framework detected)
- **Test File Pattern:** All test files follow the `*.test.*` naming convention.
  - Example: `GratefulEntry.test.swift`
- Tests are likely written in Swift, matching the main language of the codebase.

## Commands
| Command   | Purpose                                   |
|-----------|-------------------------------------------|
| /new-file | Create a new Swift file using PascalCase  |
| /test     | Create a new test file (*.test.swift)     |
| /commit   | Generate a conventional commit message    |
```