// 🎯 Dart imports:
import 'dart:ui';

import '../../common/constant/app_strings.dart';

extension HexColor on String {
  Color toColor() {
    String hex = replaceAll("#", "");
    if (hex.length == 6) {
      hex = "FF$hex";
    }
    return Color(int.parse(hex, radix: 16));
  }
}

extension WeekdayShort on int {
  String get weekdayShort {
    List<String> days = [
      AppStrings.sun,
      AppStrings.mon,
      AppStrings.tue,
      AppStrings.wed,
      AppStrings.thu,
      AppStrings.fri,
      AppStrings.sat
    ];
    return days[this % 7];
  }

  String get monthName {
    final monthNames = [
      AppStrings.january,
      AppStrings.february,
      AppStrings.march,
      AppStrings.april,
      AppStrings.may,
      AppStrings.june,
      AppStrings.july,
      AppStrings.august,
      AppStrings.september,
      AppStrings.october,
      AppStrings.november,
      AppStrings.december
    ];
    return monthNames[this - 1];
  }
}
