import 'package:flutter/material.dart';

class AdsConstants {
  static const double carouselHeight = 180;
  static const double carouselAspectRatio = 16 / 9;
  static const double viewportFraction = 0.9;
  static const double horizontalMargin = 8;
  static const double borderRadius = 16;
  static const double contentPadding = 16;
  static const double enlargeFactor = 0.3;

  static const Duration autoPlayInterval = Duration(seconds: 3);
  static const Duration autoPlayAnimationDuration = Duration(milliseconds: 800);

  static const List<BoxShadow> cardShadow = [
    BoxShadow(
      color: Colors.black26,
      blurRadius: 16,
      offset: Offset(0, 4),
    ),
  ];

  static const LinearGradient overlayGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Colors.transparent,
      Colors.black87,
    ],
  );
}
