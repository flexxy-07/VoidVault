# Clean Architecture Structure

This project follows **Clean Architecture** principles for better maintainability, scalability, and testability.

## Directory Structure

```
lib/
├── main.dart                          # Application entry point
│
├── config/
│   └── theme/
│       └── app_theme.dart            # Theme configuration
│
├── core/
│   ├── constants/
│   │   └── app_constants.dart        # Application-wide constants
│   ├── utils/
│   │   └── (utility functions)
│   └── widgets/
│       └── (reusable widgets)
│
└── features/
    ├── onboarding/
    │   ├── controllers/
    │   │   └── onboarding_controller.dart
    │   └── screens/
    │       └── onboarding_screen.dart
    │
    ├── authentication/
    │   ├── controllers/
    │   │   └── login_controller.dart
    │   ├── models/
    │   │   └── login_model.dart
    │   └── screens/
    │       └── login_screen.dart
    │
    ├── gallery/
    │   ├── controllers/
    │   │   └── gallery_controller.dart
    │   ├── models/
    │   │   └── image_model.dart
    │   ├── screens/
    │   │   └── main_gallery_screen.dart
    │   └── widgets/
    │       └── upload_bottom_sheet.dart
    │
    ├── image_viewer/
    │   ├── controllers/
    │   │   └── image_viewer_controller.dart
    │   ├── models/
    │   │   └── image_detail_model.dart
    │   └── screens/
    │       └── fullscreen_image_view_screen.dart
    │
    └── accounts/
        ├── controllers/
        │   └── accounts_controller.dart
        ├── models/
        │   └── account_model.dart
        ├── screens/
        │   └── accounts_management_screen.dart
        └── widgets/
            └── (feature-specific widgets)
```

## Architecture Layers

### 1. **Models Layer** (`models/`)
- Data structures representing domain entities
- Contains business logic validation methods
- Examples: `LoginModel`, `ImageModel`, `AccountModel`
- **Benefits**: Centralized data structure, easy validation

### 2. **Controllers Layer** (`controllers/`)
- Business logic and state management using `ChangeNotifier` (Provider pattern)
- Handles API calls, data processing, and state updates
- Notifies listeners when state changes
- Examples: `LoginController`, `GalleryController`, `AccountsController`
- **Benefits**: Separation of concerns, reusable logic, easy testing

### 3. **Screens Layer** (`screens/`)
- UI presentation layer (Pages/Screens)
- Listens to controllers and rebuilds on state changes
- Handles user interactions and navigation
- Examples: `LoginScreen`, `MainGalleryScreen`
- **Benefits**: Clean, maintainable UI code

### 4. **Widgets Layer** (`widgets/`)
- Reusable UI components used within a feature
- Examples: `UploadBottomSheet`, custom buttons, cards
- **Benefits**: DRY principle, component reusability

### 5. **Config Layer** (`config/`)
- Application configuration (theme, constants, routes)
- Centralized settings management
- Examples: `AppTheme`, theme colors, styling

### 6. **Core Layer** (`core/`)
- Shared utilities, constants, and widgets across features
- **Benefits**: DRY principle, single source of truth

## State Management

The project uses **Provider** pattern with `ChangeNotifier` for state management:

```dart
// Controller extends ChangeNotifier
class LoginController extends ChangeNotifier {
  void login() {
    // ... logic
    notifyListeners(); // Notify UI to rebuild
  }
}

// Usage in Screen
class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginController(),
      child: Consumer<LoginController>(
        builder: (context, controller, _) {
          // UI updates when controller changes
        },
      ),
    );
  }
}
```

## Benefits of This Architecture

✅ **Separation of Concerns** - Each layer has a specific responsibility
✅ **Reusability** - Components can be reused across features
✅ **Testability** - Controllers and models can be tested independently
✅ **Scalability** - Easy to add new features without affecting existing code
✅ **Maintainability** - Clear structure makes code easy to navigate and modify
✅ **Collaboration** - Team members can work on different features independently

## Adding a New Feature

1. Create feature folder: `lib/features/new_feature/`
2. Create subfolders: `models/`, `controllers/`, `screens/`, `widgets/`
3. Implement models with validation logic
4. Create controller extending `ChangeNotifier`
5. Create screen consuming the controller
6. Update routing in `main.dart` if needed

## Dependencies

- **provider**: ^6.0.0 - State management
- **google_fonts**: ^8.0.2 - Custom fonts
- **flutter_staggered_grid_view**: ^0.7.0 - Masonry grid layout
