import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:void_vault/core/common/loader.dart';
import 'package:void_vault/core/theme/app_theme.dart';
import 'package:void_vault/features/gallery/controller/gallery_controller.dart';
import 'package:void_vault/features/gallery/model/cloudinary_account.dart';

class AccountsScreen extends ConsumerWidget {
  const AccountsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: AppTheme.textSecondary),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              'ACCOUNTS MANAGEMENT',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: AppTheme.primary,
                    fontSize: 12,
                    letterSpacing: 2,
                  ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                "CONNECTED VOIDS",
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontSize: 32,
                    ),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 32)),
          accountsAsync.when(
            data: (accounts) {
              if (accounts.isEmpty) {
                return const SliverFillRemaining(
                  child: Center(
                    child: Text(
                      'NO_VOIDS_DETECTED',
                      style: TextStyle(color: AppTheme.textSecondary),
                    ),
                  ),
                );
              }
              return SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final acc = accounts[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: _AccountNodeCard(account: acc),
                      );
                    },
                    childCount: accounts.length,
                  ),
                ),
              );
            },
            error: (e, _) => SliverFillRemaining(
              child: Center(
                child: Text(
                  'LINK_ERROR: $e',
                  style: const TextStyle(color: Colors.redAccent),
                ),
              ),
            ),
            loading: () => const SliverFillRemaining(child: Loader()),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 80)),
        ],
      ),
    );
  }
}

class _AccountNodeCard extends StatelessWidget {
  final CloudinaryAccount account;
  const _AccountNodeCard({required this.account});

  @override
  Widget build(BuildContext context) {
    // Basic calculation for progress bar (simulated if totalStorage is missing)
    final double used = account.usedStorage.toDouble();
    // Assuming 50 items as a default max for progress visualization if not specified
    // In this app, usedStorage seems to be count of images based on gallery_controller line 93
    const double maxStorageGallons = 50.0;
    final progress = (used / maxStorageGallons).clamp(0.0, 1.0);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: AppTheme.surfaceContainer,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                account.label.toUpperCase(),
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontSize: 16,
                      letterSpacing: 1.5,
                      color: AppTheme.onSurface,
                    ),
              ),
              const Icon(
                Icons.link,
                color: AppTheme.primary,
                size: 16,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            account.cloudName,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 12,
                  letterSpacing: 0.5,
                ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "STORAGE_FLUX",
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: AppTheme.textSecondary,
                      fontSize: 10,
                      letterSpacing: 2,
                    ),
              ),
              Text(
                "${account.usedStorage} UNIT / ${maxStorageGallons.toInt()} UNIT",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.primary,
                      fontFamily: 'monospace',
                      fontSize: 12,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Stack(
            children: [
              Container(
                height: 2,
                width: double.infinity,
                color: AppTheme.outlineVariant.withOpacity(0.3),
              ),
              FractionallySizedBox(
                widthFactor: progress,
                child: Container(
                  height: 2,
                  color: AppTheme.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
