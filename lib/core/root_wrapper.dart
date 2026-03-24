import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:void_vault/core/auth_wrapper.dart';
import 'package:void_vault/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:void_vault/features/onboarding/controllers/onboarding_controller.dart';

/// Provider for SharedPreferences instance
final sharedPreferencesProvider = FutureProvider<SharedPreferences>((ref) async {
  return await SharedPreferences.getInstance();
});

/// Provider for onboarding state
final onboardingStateProvider =
    StateNotifierProvider<OnboardingNotifier, bool>((ref) {
  final prefsAsync = ref.watch(sharedPreferencesProvider);

  return prefsAsync.when(
    data: (prefs) => OnboardingNotifier(prefs),
    loading: () => OnboardingNotifier(SharedPreferences.getInstance() as dynamic),
    error: (error, stack) => OnboardingNotifier(SharedPreferences.getInstance() as dynamic),
  );
});

/// Root wrapper that handles both onboarding and auth flow
class RootWrapper extends ConsumerWidget {
  const RootWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the onboarding state
    final onboardingCompleted = ref.watch(onboardingStateProvider);
    final onboardingNotifier = ref.read(onboardingStateProvider.notifier);

    // Check if onboarding is completed
    if (!onboardingCompleted) {
      // Show onboarding screen if not completed
      return OnboardingPage(
        onCompleted: () async {
          // Mark onboarding as completed
          await onboardingNotifier.completeOnboarding();
        },
      );
    }

    // Show auth wrapper (login or gallery) if onboarding is completed
    return const AuthWrapper();
  }
}
