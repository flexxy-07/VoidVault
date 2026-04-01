import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/common/void_text_field.dart';
import '../../controllers/auth_controller.dart';
import 'signup_view.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'SYSTEM_LOGIN',
                style: AppTheme.darkTheme.textTheme.displayLarge?.copyWith(
                  fontSize: 28,
                  letterSpacing: -1.0,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                'AUTHENTICATION REQUIRED TO ACCESS VAULT',
                style: GoogleFonts.inter(
                  color: AppTheme.textSecondary,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 64),

              // Email Field
              VoidTextField(
                label: 'EMAIL',
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 32),

              // Password Field
              VoidTextField(
                label: 'PASSWORD',
                controller: passwordController,
                obscureText: true,
              ),
              const SizedBox(height: 48),

              // Login Button
              ElevatedButton(
                onPressed: () {
                  ref
                      .read(authControllerProvider)
                      .logIn(
                        emailController.text.trim(),
                        passwordController.text.trim(),
                      );
                },
                child: const Text('LOGIN'),
              ),
              const SizedBox(height: 32),

              // Signup Link
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignupView()),
                  );
                },
                child: Column(
                  children: [
                    Container(
                      height: 1,
                      width: 40,
                      color: AppTheme.outlineVariant,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'CREATE NEW CREDENTIALS',
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        color: AppTheme.textSecondary,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
