import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/common/void_text_field.dart';
import '../../controllers/auth_controller.dart';

class SignupView extends ConsumerWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final verifyPassController = TextEditingController();

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.onBackground),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'INITIALIZE_ACCOUNT',
                style: AppTheme.darkTheme.textTheme.displayLarge?.copyWith(
                  fontSize: 28,
                  letterSpacing: -1.0,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                'REGISTER NEW SYSTEM CREDENTIALS',
                style: GoogleFonts.inter(
                  color: AppTheme.textSecondary,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              
              // Email Field
              VoidTextField(
                label: 'EMAIL',
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 24),
              
              // Password Field
              VoidTextField(
                label: 'PASSWORD',
                controller: passwordController,
                obscureText: true,
              ),
              const SizedBox(height: 24),
              
              // Confirm Password Field
              VoidTextField(
                label: 'CONFIRM PASSWORD',
                controller: verifyPassController,
                obscureText: true,
              ),
              const SizedBox(height: 48),
              
              // Signup Button
              ElevatedButton(
                onPressed: () {
                  ref.read(authControllerProvider).signUp(
                    emailController.text.trim(),
                    passwordController.text.trim(),
                  );
                },
                child: const Text('GENERATE ACCESS'),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
