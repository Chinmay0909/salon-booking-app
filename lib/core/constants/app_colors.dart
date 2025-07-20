import 'package:flutter/material.dart';

class AppColors {
  // Primary color palette from provided image
  static const Color primaryBlue = Color(0xFF4FC3D7);      // Top blue
  static const Color primaryTeal = Color(0xFF80D8C3);      // Middle teal
  static const Color primaryYellow = Color(0xFFF4D03F);    // Bottom yellow

  // Supporting colors
  static const Color background = Color(0xFFF8F9FA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color error = Color(0xFFE74C3C);
  static const Color success = Color(0xFF27AE60);

  // Text colors
  static const Color textPrimary = Color(0xFF2C3E50);
  static const Color textSecondary = Color(0xFF7F8C8D);
  static const Color textLight = Color(0xFFBDC3C7);

  // Gradient combinations
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [primaryBlue, primaryTeal, primaryYellow],
  );

  static const LinearGradient blueToTeal = LinearGradient(
    colors: [primaryBlue, primaryTeal],
  );

  static const LinearGradient tealToYellow = LinearGradient(
    colors: [primaryTeal, primaryYellow],
  );
}