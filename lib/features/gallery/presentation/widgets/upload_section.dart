import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:void_vault/core/theme/app_theme.dart';
import 'package:void_vault/features/gallery/controller/gallery_controller.dart';

class UploadSection extends ConsumerWidget {
  final int imageCount;
  final VoidCallback? onUpload;
  const UploadSection({super.key, required this.imageCount, this.onUpload});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uploadState = ref.watch(galleryControllerProvider);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      color: AppTheme.background,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "VAULT_COLLECTION",
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: AppTheme.textSecondary,
                        fontSize: 10,
                        letterSpacing: 2.0,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "$imageCount ITEMS",
                      style: Theme.of(
                        context,
                      ).textTheme.displayLarge?.copyWith(fontSize: 32),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: onUpload,
                child: Container(
                  width: 56,
                  height: 56,
                  color: AppTheme.primary,
                  child: uploadState.isLoading
                      ? const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: CircularProgressIndicator(
                            color: AppTheme.background,
                            strokeWidth: 2,
                          ),
                        )
                      : const Icon(
                          Icons.add,
                          color: AppTheme.background,
                          size: 32,
                        ),
                ),
              ),
            ],
          ),
          uploadState.when(
            data: (_) => const SizedBox.shrink(),
            loading: () => const SizedBox.shrink(),
            error: (error, _) => Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text(
                "UPLOAD ERROR: $error",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.redAccent,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
