import 'package:flutter/material.dart';

class ColorTheme {
  // Primary colors
  static const Color primaryColor = Color(0xFF6366F1); // Indigo
  static const Color secondaryColor = Color(0xFFF59E0B); // Amber
  static const Color accentColor = Color(0xFF10B981); // Emerald
  
  // Background colors
  static const Color backgroundColor = Color(0xFFF8FAFC); // Slate 50
  static const Color surfaceColor = Color(0xFFFFFFFF); // White
  static const Color cardColor = Color(0xFFFFFFFF); // White
  
  // Text colors
  static const Color primaryTextColor = Color(0xFF1E293B); // Slate 800
  static const Color secondaryTextColor = Color(0xFF64748B); // Slate 500
  static const Color lightTextColor = Color(0xFFFFFFFF); // White
  
  // Status colors
  static const Color successColor = Color(0xFF10B981); // Emerald
  static const Color errorColor = Color(0xFFEF4444); // Red
  static const Color warningColor = Color(0xFFF59E0B); // Amber
  static const Color infoColor = Color(0xFF3B82F6); // Blue
  
  // Gradient colors
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF6366F1), // Indigo
      Color(0xFF8B5CF6), // Violet
    ],
  );
  
  static const LinearGradient secondaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFF59E0B), // Amber
      Color(0xFFF97316), // Orange
    ],
  );
} 