import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_notifier/state_notifier.dart';

class OnboardingNotifier extends Notifier<bool> {
  @override
  bool build() {
    return false;
  }

  void completeOnboarding() {
    state = true;
  }

  void resetOnboarding() {
    state = false;
  }
}
