import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:void_vault/core/auth_wrapper.dart';
import 'package:void_vault/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:void_vault/features/onboarding/controllers/onboarding_controller.dart';

/// Provider for onboarding state
final onboardingStateProvider =
    NotifierProvider<OnboardingNotifier, bool>(OnboardingNotifier.new);

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
        onCompleted: () {
          // Mark onboarding as completed
          onboardingNotifier.completeOnboarding();
        },
      );
    }

    // Show auth wrapper (login or gallery) if onboarding is completed
    return const AuthWrapper();
  }
}
