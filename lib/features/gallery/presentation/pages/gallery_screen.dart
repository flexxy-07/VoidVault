import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:void_vault/core/common/loader.dart';
import 'package:void_vault/core/common/void_dialog.dart';
import 'package:void_vault/core/theme/app_theme.dart';
import 'package:void_vault/features/auth/controllers/auth_controller.dart';
import 'package:void_vault/features/gallery/controller/gallery_controller.dart';
import 'package:void_vault/features/gallery/presentation/pages/accounts_screen.dart';
import 'package:void_vault/features/gallery/presentation/widgets/image_card.dart';
import 'package:void_vault/features/gallery/presentation/widgets/upload_section.dart';

class GalleryScreen extends ConsumerWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imagesAsync = ref.watch(galleryStreamProvider);
    final accountsAsync = ref.watch(accountStreamProvider);

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppTheme.background,
            floating: true,
            pinned: true,
            elevation: 0,
            centerTitle: false,
            title: Text(
              "VOID VAULT",
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: AppTheme.primary,
                fontSize: 14,
                letterSpacing: 4,
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.power_settings_new,
                  color: AppTheme.textSecondary,
                  size: 20,
                ),
                onPressed: () {
                  VoidDialog.show(
                    context,
                    title: "TERMINATE_SESSION",
                    message: "Are you sure you want to disconnect from the vault?",
                    confirmLabel: "LOGOUT",
                    onConfirm: () {
                      ref.read(authControllerProvider).logOut();
                    },
                  );
                },
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AccountsScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.storage),
              ),
            ],
          ),
          imagesAsync.when(
            data: (snapshot) {
              final docs = snapshot.docs;
              return SliverToBoxAdapter(
                child: UploadSection(
                  imageCount: docs.length,
                  onUpload: accountsAsync.hasValue
                      ? () {
                          ref
                              .read(galleryControllerProvider.notifier)
                              .pickAndUploadImage(accountsAsync.value!);
                        }
                      : null,
                ),
              );
            },
            loading: () => const SliverToBoxAdapter(child: SizedBox.shrink()),
            error: (error, _) =>
                const SliverToBoxAdapter(child: SizedBox.shrink()),
          ),
          imagesAsync.when(
            data: (snapshot) {
              final docs = snapshot.docs;
              if (docs.isEmpty) {
                return const SliverFillRemaining(
                  child: Center(
                    child: Text(
                      "NO_DATA_FOUND",
                      style: TextStyle(color: AppTheme.textSecondary),
                    ),
                  ),
                );
              }

              return SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                sliver: SliverMasonryGrid.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  itemBuilder: (context, index) {
                    final data = docs[index].data() as Map<String, dynamic>;
                    print(data['accountId']); // Debug log
                    return ImageCard(
                      imageUrl: data['imageUrl'] ?? '',
                      metadata: data,
                    );
                  },
                  childCount: docs.length,
                ),
              );
            },
            loading: () => const SliverFillRemaining(child: Loader()),
            error: (err, stack) => SliverFillRemaining(
              child: Center(
                child: Text(
                  "ERROR: $err",
                  style: const TextStyle(color: Colors.redAccent),
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
    );
  }
}
