import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_notifier/state_notifier.dart';
/// Simple state notifier for onboarding completion
class OnboardingNotifier extends Notifier<bool> {
  @override
  bool build(){
    return false;
  }

  /// Mark onboarding as completed
  void completeOnboarding() {
    state = true;
  }

  /// Reset onboarding status
  void resetOnboarding() {
    state = false;
  }
}
