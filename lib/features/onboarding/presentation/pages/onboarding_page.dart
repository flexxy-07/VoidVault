import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_theme.dart';

class OnboardingPage extends ConsumerWidget {
  final VoidCallback? onCompleted;

  const OnboardingPage({super.key, this.onCompleted});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Access controller if needed
    // final controller = ref.watch(onboardingControllerProvider.notifier);
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Stack(
        children: [
          // Monolithic Typography
          Positioned(
            top: 100,
            left: -20,
            child: Text(
              'VAULT',
              style: GoogleFonts.spaceGrotesk(
                fontSize: 180,
                fontWeight: FontWeight.bold,
                color: AppTheme.onBackground.withOpacity(0.05),
                letterSpacing: -10.0,
              ),
            ),
          ),
          
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  Text(
                    'VOID',
                    style: AppTheme.darkTheme.textTheme.displayLarge?.copyWith(
                      fontSize: 84,
                      height: 0.9,
                    ),
                  ),
                  Text(
                    'VAULT',
                    style: AppTheme.darkTheme.textTheme.displayLarge?.copyWith(
                      fontSize: 84,
                      height: 0.9,
                      color: AppTheme.primary,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'THE PRECISE VOID.\nYOUR VISUAL ARCHIVE, REDEFINED.',
                    style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                      letterSpacing: 2.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Call the completion callback
                        onCompleted?.call();
                      },
                      child: const Text('ENTER THE VOID'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
