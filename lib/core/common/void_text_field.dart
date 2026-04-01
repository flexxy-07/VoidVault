import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class VoidTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final Widget? suffixIcon;

  const VoidTextField({
    super.key,
    required this.label,
    required this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label.toUpperCase(),
              style: GoogleFonts.spaceGrotesk(
                color: AppTheme.textSecondary,
                fontSize: 10,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Container(
                height: 1,
                color: AppTheme.outlineVariant.withOpacity(0.3),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          cursorColor: AppTheme.primary,
          style: GoogleFonts.inter(
            color: AppTheme.onBackground,
            fontSize: 14,
            letterSpacing: 0.5,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppTheme.surfaceContainer,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            suffixIcon: suffixIcon,
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(
                color: AppTheme.outlineVariant,
                width: 1.0,
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(
                color: AppTheme.primary,
                width: 2.0,
              ),
            ),
            hintText: 'ENTER $label...',
            hintStyle: GoogleFonts.inter(
              color: AppTheme.textSecondary.withOpacity(0.5),
              fontSize: 12,
              letterSpacing: 1.0,
            ),
          ),
        ),
      ],
    );
  }
}
