import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// State Notifier for managing onboarding completion status
class OnboardingNotifier extends StateNotifier<bool> {
  static const String _onboardingKey = 'onboarding_completed';

  OnboardingNotifier(this._prefs) : super(false) {
    _loadOnboardingStatus();
  }

  final dynamic _prefs;

  /// Load onboarding status from local storage
  Future<void> _loadOnboardingStatus() async {
    final prefs = await _getPrefs();
    final completed = prefs.getBool(_onboardingKey) ?? false;
    state = completed;
  }

  /// Get SharedPreferences instance
  Future<SharedPreferences> _getPrefs() async {
    if (_prefs is SharedPreferences) {
      return _prefs;
    }
    return await SharedPreferences.getInstance();
  }

  /// Mark onboarding as completed
  Future<void> completeOnboarding() async {
    final prefs = await _getPrefs();
    await prefs.setBool(_onboardingKey, true);
    state = true;
  }

  /// Reset onboarding status (useful for testing/reset)
  Future<void> resetOnboarding() async {
    final prefs = await _getPrefs();
    await prefs.setBool(_onboardingKey, false);
    state = false;
  }
}
