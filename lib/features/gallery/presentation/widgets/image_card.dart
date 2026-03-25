import 'package:flutter/material.dart';
import 'package:void_vault/core/theme/app_theme.dart';

class ImageCard extends StatelessWidget {
  final String imageUrl;
  final VoidCallback? onTap;

  const ImageCard({
    super.key,
    required this.imageUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.surfaceContainer,
          borderRadius: BorderRadius.circular(12),
        ),
        clipBehavior: Clip.antiAlias,
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Container(
              height: 200,
              color: AppTheme.surface,
              child: const Center(
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primary),
                  ),
                ),
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return Container(
              height: 200,
              color: AppTheme.surface,
              child: const Icon(
                Icons.error_outline,
                color: AppTheme.textSecondary,
              ),
            );
          },
        ),
      ),
    );
  }
}
