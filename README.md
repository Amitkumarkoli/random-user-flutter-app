# Random User Flutter App

This is a Flutter application built as part of an internship task. It fetches and displays random user profiles using the RandomUser API, following Clean Architecture with Riverpod for state management.

## Features
- Displays a grid of user profiles on the home screen (profile picture, name, age, location, like toggle).
- Navigates to a detail screen on image click with a Hero transition.
- Syncs like status between home and detail screens.
- Handles loading and error states.
- Includes bonus features:
  - Pull-to-refresh.
  - Country filter dropdown.
  - Responsive layout.
  - Heart icon animation.
  - Hero transition for image.

## Requirements
- Flutter SDK (latest stable version).
- Android/iOS emulator or physical device.

## How to Run
1. Clone the repository: `git clone https://github.com/Amitkumarkoli/random-user-flutter-app.git`
2. Navigate to the project folder: `cd random-user-flutter-app`
3. Install dependencies: `flutter pub get`
4. Run the app: `flutter run`

## Architecture
- **Data Layer**: Handles API calls (data/datasources, data/repositories).
- **Domain Layer**: Contains models and repository interfaces (domain/models, domain/repositories).
- **Presentation Layer**: Manages UI and state (presentation/screens, presentation/providers).

## GitHub Repository
https://github.com/yourusername/random-user-flutter-app

## Notes
- Replace `yourusername` with your actual GitHub username in the clone URL.
- Ensure internet access for API calls.