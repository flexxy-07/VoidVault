import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Core Colors
  static const Color background = Color(0xFF131313);
  static const Color surface = Color(0xFF1C1B1B);
  static const Color surfaceContainer = Color(0xFF201F1F);
  static const Color primary = Color(0xFFC9BEFF);
  static const Color onBackground = Color(0xFFE5E2E1);
  static const Color onSurface = Color(0xFFE5E2E1);
  static const Color textSecondary = Color(0xFF938F9D);
  static const Color outlineVariant = Color(0xFF484552);

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: background,
      colorScheme: const ColorScheme.dark(
        background: background,
        surface: surface,
        primary: primary,
        onPrimary: background,
        onSurface: onSurface,
        outlineVariant: outlineVariant,
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.spaceGrotesk(
          color: onBackground,
          fontWeight: FontWeight.bold,
          letterSpacing: -2.0, // Strict -0.03em or similar dense look
          height: 1.1,
        ),
        headlineMedium: GoogleFonts.spaceGrotesk(
          color: onBackground,
          fontWeight: FontWeight.w500,
          letterSpacing: -1.0,
        ),
        bodyLarge: GoogleFonts.inter(
          color: onBackground,
          fontWeight: FontWeight.w400,
          height: 1.6,
        ),
        bodyMedium: GoogleFonts.inter(
          color: textSecondary,
          fontWeight: FontWeight.w400,
        ),
        labelLarge: GoogleFonts.inter(
          color: background,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: onBackground,
          foregroundColor: background,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero, // Non-negotiable 0px
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
          ),
        ),
      ),
    );
  }
}
