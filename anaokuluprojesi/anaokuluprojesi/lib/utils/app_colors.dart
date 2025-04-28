import 'package:flutter/material.dart';

// Application color constants
class AppColors {
  // Prevent instantiation
  AppColors._();

  // --- Main Palette ---
  static const Color primaryBlue = Color(0xFF15B2F7);
  static const Color accentPurple = Color(0xFFC64FE0);
  static const Color darkPurple = Color(0xFF832A92);
  static const Color green = Color(0xFFA1E23D);
  static const Color orange = Color(0xFFF0782C);
  static const Color red = Color(0xFFE8202A);

  // --- Semantic Colors (derived or standard) ---
  static const Color success = green; // Use palette green for success
  static const Color error = red; // Use palette red for error/negative
  static const Color warning = orange; // Use palette orange for warning/neutral
  static const Color info = primaryBlue; // Use primary blue for info

  // --- Greys & Backgrounds ---
  static const Color background = Color(0xFFF8F9FA); // Light grey background
  static const Color cardBackground = Colors.white;
  static const Color divider = Color(0xFFE0E0E0);
  static const Color textPrimary = Color(0xFF212529); // Dark text
  static const Color textSecondary = Color(0xFF6C757D); // Grey text
}
