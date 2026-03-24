import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:void_vault/features/auth/controllers/auth_controller.dart';


class GalleryScreen extends ConsumerWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Void Gallery"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              ref.read(authConrollerProvider).logOut();
            },
          )
        ],
      ),
      body: const Center(child: Text("Gallery Coming Soon")),
    );
  }
}