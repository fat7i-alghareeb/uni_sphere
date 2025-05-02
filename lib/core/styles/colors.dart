// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:test/shared/extensions/context_extension.dart';

import '../../shared/extensions/string_extension.dart';

/// A comprehensive color system for the application.
/// Follows a systematic approach to color organization and naming.
class AppColors {
  AppColors._();

  // Base Colors
  static const Color transparent = Colors.transparent;
  static const Color white = Colors.white;
  static const Color black = Colors.black;

  // Primary Colors
  static const Color lightPrimary = Color(0xFF4A487B);
  static const Color darkPrimary = Color(0xff4A487B);
  static const Color onPrimaryLight = Color(0xFF25293C);
  static const Color onPrimaryDark = Color(0xFFF6F6FD);

  // Semantic Colors
  static const Color danger = Color(0xFFF44336);
  static const Color success = Color(0xff28C76F);
  static const Color warning = Color(0xFFF6CE2C);
  static const Color info = Color(0xFF6A9B72);

  // Background Colors
  static const Color lightBackground = Color(0xFFF6F6FD);
  static const Color darkBackground = Color.fromARGB(255, 31, 30, 33);
  static const Color sugar = Color(0xFFF8F7F7);
  static const Color lightShimmerColor = Color.fromARGB(255, 152, 152, 152);
  static const Color darkShimmerColor = Color.fromARGB(255, 111, 111, 111);
  // Text Colors
  static const Color textPrimary = Color(0xFF4B465C);
  static const Color textSecondary = Color(0xFF8B8B8B);

  // Status Colors
  static const Color red = Color(0xFFF44336);
  static const Color blue = Color(0xff0055F9);
  static const Color grey = Color(0xFF4B465C);
  static const Color green = Color(0xff28C76F);

  // Gradients
  static final LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      lightPrimary,
      "#B1E5D3".toColor(),
    ],
  );

  static final LinearGradient secondaryGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      warning.withOpacity(0.5),
      warning,
    ],
  );

  static const LinearGradient dangerGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFFF08182),
      danger,
    ],
  );

  static const LinearGradient successGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xff48DA89),
      success,
    ],
  );

  static final LinearGradient neutralGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      "#CBC6C6".toColor(),
      "#8B8B8B".toColor(),
    ],
  );

  // Shadows
  static List<BoxShadow> primaryShadow(BuildContext context) => [
        BoxShadow(
          offset: const Offset(0, 4),
          blurRadius: 16,
          spreadRadius: 0,
          color:
              "#331105".toColor().withOpacity(context.isDarkMode ? .45 : .15),
        ),
      ];

  static const List<BoxShadow> greyShadow = [
    BoxShadow(
      offset: Offset(0, 2),
      blurRadius: 4,
      spreadRadius: 0,
      color: Color(0x4DA5A3AE),
    ),
  ];

  static const List<BoxShadow> blueShadow = [
    BoxShadow(
      offset: Offset(0, 4),
      blurRadius: 16,
      spreadRadius: 0,
      color: Color(0x73273C5B),
    ),
  ];

  static const List<BoxShadow> brownShadow = [
    BoxShadow(
      offset: Offset(0, 2),
      blurRadius: 3,
      spreadRadius: 0,
      color: Color(0x4DCE6E17),
    ),
  ];

  static const List<BoxShadow> bottomSheetCardShadow = [
    BoxShadow(
      offset: Offset(0, 4),
      blurRadius: 18,
      spreadRadius: 0,
      color: Color(0x334B465C),
    ),
  ];
  static List<BoxShadow> coloredShadow(Color color) {
    return [
      BoxShadow(
        offset: const Offset(0, 4),
        blurRadius: 16,
        spreadRadius: 0,
        color: color,
      )
    ];
  }
}
