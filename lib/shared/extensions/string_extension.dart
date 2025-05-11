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
    const monthNames = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return monthNames[this - 1];
  }
}
