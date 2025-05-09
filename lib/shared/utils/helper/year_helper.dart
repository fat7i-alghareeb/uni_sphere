import 'package:test/shared/imports/imports.dart';

import '../../../common/constant/app_strings.dart';

class YearHelper {
  static String getYearString(int yearNumber) {
    switch (yearNumber) {
      case 1:
        return AppStrings.firstYear;
      case 2:
        return AppStrings.secondYear;
      case 3:
        return AppStrings.thirdYear;
      case 4:
        return AppStrings.fourthYear;
      case 5:
        return AppStrings.fifthYear;
      case 6:
        return AppStrings.sixthYear;
      case 7:
        return AppStrings.seventhYear;
      case 8:
        return AppStrings.eighthYear;
      case 9:
        return AppStrings.ninthYear;
      case 10:
        return AppStrings.tenthYear;
      case 11:
        return AppStrings.eleventhYear;
      case 12:
        return AppStrings.twelfthYear;
      case 13:
        return AppStrings.thirteenthYear;
      default:
        return '';
    }
  }

  static String getOrdinalString(int number) {
    switch (number) {
      case 1:
        return AppStrings.first;
      case 2:
        return AppStrings.second;
      case 3:
        return AppStrings.third;
      case 4:
        return AppStrings.fourth;
      case 5:
        return AppStrings.fifth;
      case 6:
        return AppStrings.sixth;
      case 7:
        return AppStrings.seventh;
      case 8:
        return AppStrings.eighth;
      case 9:
        return AppStrings.ninth;
      case 10:
        return AppStrings.tenth;
      case 11:
        return AppStrings.eleventh;
      case 12:
        return AppStrings.twelfth;
      case 13:
        return AppStrings.thirteenth;
      default:
        return '';
    }
  }

  static String getYearSubjectsName(int year, BuildContext context) {
    final yearString = getYearString(year);
    final subjectsString = AppStrings.subjects;
    final yearSubjectsName = context.isEnglish
        ? "$yearString $subjectsString"
        : "$yearString $subjectsString";
    return yearSubjectsName;
  }
}
