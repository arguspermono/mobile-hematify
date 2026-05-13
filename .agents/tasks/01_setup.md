# Task 01 — Project Setup

## Goal
Initialize the Flutter project with correct folder structure and all required dependencies.

## Requirements
- Add `sqflite`, `path`, `provider`, `intl` to `pubspec.yaml`
- Run `flutter pub get`
- Create folder structure inside `lib/`:
  ```
  lib/
  ├── main.dart
  ├── models/
  ├── database/
  ├── providers/
  ├── screens/
  └── widgets/
  ```
- Set up `MaterialApp` in `main.dart` with a placeholder `HomeScreen`

## Output
- Updated `pubspec.yaml`
- Empty folder structure under `lib/`
- `main.dart` with `MaterialApp` pointing to a placeholder `HomeScreen`

## Dependencies
- None (first task)

## Done Criteria
- [ ] `flutter pub get` runs with no errors
- [ ] App runs on emulator showing a blank scaffold
- [ ] No lint errors from `flutter analyze`
