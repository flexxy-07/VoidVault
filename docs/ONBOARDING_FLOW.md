# Onboarding Flow Implementation

## Overview
The app now implements a complete flow:
1. **App Start** → Show Onboarding Screen
2. **After Onboarding** → Show Auth Wrapper (Login or Gallery)

## Architecture

### Flow Diagram
```
App Start
    ↓
RootWrapper (checks onboarding status)
    ├─ If onboarding NOT completed
    │       ↓
    │   OnboardingPage
    │       ↓
    │   User completes onboarding
    │       ↓
    │   OnboardingNotifier.completeOnboarding()
    │       ↓
    │   Writes to SharedPreferences
    │       ↓
    │ (UI rebuilds due to Riverpod state change)
    │
    └─ If onboarding completed
            ↓
        AuthWrapper
            ├─ If user NOT logged in
            │   ↓
            │   LoginPage
            │
            └─ If user logged in
                ↓
                GalleryScreen
```

## Components

### 1. **OnboardingNotifier** (`lib/features/onboarding/controllers/onboarding_controller.dart`)
- StateNotifier that manages onboarding completion state
- Persists state to SharedPreferences
- Methods:
  - `completeOnboarding()` - Marks onboarding as completed
  - `resetOnboarding()` - Resets onboarding (for testing)

### 2. **RootWrapper** (`lib/core/root_wrapper.dart`)
- Main entry point widget
- Watches onboarding state via `onboardingStateProvider`
- Conditionally renders:
  - `OnboardingPage` if onboarding not completed
  - `AuthWrapper` if onboarding completed

### 3. **Providers** (in `lib/core/root_wrapper.dart`)
```dart
// SharedPreferences provider
final sharedPreferencesProvider = FutureProvider<SharedPreferences>((ref) async {
  return await SharedPreferences.getInstance();
});

// Onboarding state provider
final onboardingStateProvider = StateNotifierProvider<OnboardingNotifier, bool>((ref) {
  // Implementation...
});
```

### 4. **OnboardingPage** (Updated)
- Now accepts `onCompleted` callback
- Calls `onCompleted()` when user clicks "ENTER THE VOID"
- No longer directly navigates to LoginPage

## State Management with Riverpod

### How It Works
1. **Initial Load**: `RootWrapper` watches `onboardingStateProvider`
2. **User Completes**: `OnboardingPage` calls `onboardingNotifier.completeOnboarding()`
3. **Save to Storage**: Writes `onboarding_completed: true` to SharedPreferences
4. **State Update**: `OnboardingNotifier` updates `state = true`
5. **Widget Rebuild**: Riverpod notifies listeners, `RootWrapper` rebuilds
6. **Show AuthWrapper**: Condition `!onboardingCompleted` is now false, so AuthWrapper is shown

## Usage

### For Users
1. Install app → See onboarding screen
2. Click "ENTER THE VOID" → Onboarding state saved
3. See login screen (AuthWrapper handles auth)
4. Login → See gallery

### For Developers
Reset onboarding in development:
```dart
final notifier = ref.read(onboardingStateProvider.notifier);
await notifier.resetOnboarding();
```

## Dependencies
- `flutter_riverpod: ^3.1.0` - State management
- `shared_preferences: ^2.0.0` - Local persistent storage

## Key Benefits
✅ **Persistent State** - Onboarding status survives app restarts
✅ **Reactive Updates** - UI automatically updates when state changes
✅ **Clean Separation** - Onboarding logic separate from auth logic
✅ **Testable** - Easy to test onboarding flow independently
✅ **User Experience** - Users only see onboarding once
