import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'onboarding_controller.g.dart';

@riverpod
class OnboardingController extends _$OnboardingController {
  @override
  void build() {
    return;
  }

  void completeOnboarding() {
    // Handle onboarding completion logic here (e.g., updating local storage)
    // Then navigate to login
  }
}
