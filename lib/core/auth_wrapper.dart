import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:void_vault/core/common/loader.dart';
import 'package:void_vault/features/auth/controllers/auth_controller.dart';
import 'package:void_vault/features/auth/presentation/pages/login_page.dart';
import 'package:void_vault/features/gallery/presentation/pages/gallery_screen.dart';

class AuthWrapper extends ConsumerWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

  return authState.when(
      data: (user) {
        if (user == null) {
          return const LoginPage();
        } else {
          return const GalleryScreen();
        }
      },
      error: (e, _) => const Scaffold(body: Center(child: Text('Error'))),
      loading: () => const Loader(),
    );
  }
}
