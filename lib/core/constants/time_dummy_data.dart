import 'package:intl/intl.dart';
import '../../features/timetable/domain/entities/day_schedule_entity.dart';
import '../../features/timetable/domain/entities/month_schedule_entity.dart';
import '../../features/timetable/domain/entities/timetable_entity.dart';

DateTime _time(DateTime base, int hour, int minute) {
  return DateTime(base.year, base.month, base.day, hour, minute);
}

List<MonthScheduleEntity> get generateMonthScheduleDummyData {
  final now = DateTime.now();

  // Create weekday templates
  final weekdayTemplates = {
    DateTime.sunday: [
      TimetableEntity(
        subjectName: "Mathematics for CS",
        lecturerName: "Dr. Samer Al-Khatib",
        startTime: _time(DateTime(0), 10, 0),
        endTime: _time(DateTime(0), 12, 0),
      ),
      TimetableEntity(
        subjectName: "Elective: AI Fundamentals",
        lecturerName: "Dr. Hala Zaidan",
        startTime: _time(DateTime(0), 13, 0),
        endTime: _time(DateTime(0), 15, 0),
      ),
    ],
    DateTime.monday: [
      TimetableEntity(
        subjectName: "Data Structures",
        lecturerName: "Dr. Ahmad Al-Masri",
        startTime: _time(DateTime(0), 8, 0),
        endTime: _time(DateTime(0), 10, 0),
      ),
      TimetableEntity(
        subjectName: "Computer Architecture",
        lecturerName: "Dr. Fatima Khalil",
        startTime: _time(DateTime(0), 10, 30),
        endTime: _time(DateTime(0), 12, 30),
      ),
    ],
    DateTime.tuesday: [
      TimetableEntity(
        subjectName: "Operating Systems",
        lecturerName: "Dr. Omar Al-Hassan",
        startTime: _time(DateTime(0), 9, 0),
        endTime: _time(DateTime(0), 11, 0),
      ),
      TimetableEntity(
        subjectName: "Database Systems",
        lecturerName: "Dr. Leila Ibrahim",
        startTime: _time(DateTime(0), 12, 0),
        endTime: _time(DateTime(0), 14, 0),
      ),
    ],
    DateTime.wednesday: [
      TimetableEntity(
        subjectName: "Computer Networks",
        lecturerName: "Dr. Youssef Hamoud",
        startTime: _time(DateTime(0), 8, 0),
        endTime: _time(DateTime(0), 10, 0),
      ),
      TimetableEntity(
        subjectName: "Lab: Data Structures",
        lecturerName: "Eng. Ali Darwish",
        startTime: _time(DateTime(0), 11, 0),
        endTime: _time(DateTime(0), 13, 0),
      ),
    ],
    DateTime.thursday: [
      TimetableEntity(
        subjectName: "Software Engineering",
        lecturerName: "Dr. Rana Saeed",
        startTime: _time(DateTime(0), 9, 0),
        endTime: _time(DateTime(0), 11, 0),
      ),
    ],
  };

  final monthSchedules = <MonthScheduleEntity>[];

  for (int offset = -4; offset <= 4; offset++) {
    final targetMonthDate = _addMonths(now, offset);
    final year = targetMonthDate.year;
    final month = targetMonthDate.month;
    final daysInMonth = DateUtils.getDaysInMonth(year, month);
    final monthDays = <DayScheduleEntity>[];

    for (int day = 1; day <= daysInMonth; day++) {
      final date = DateTime(year, month, day);
      final weekday = date.weekday;

      if (weekdayTemplates.containsKey(weekday)) {
        final templates = weekdayTemplates[weekday]!;

        final updatedTimetables = templates.map((tt) {
          return TimetableEntity(
            subjectName: tt.subjectName,
            lecturerName: tt.lecturerName,
            startTime: DateTime(
                year, month, day, tt.startTime.hour, tt.startTime.minute),
            endTime:
                DateTime(year, month, day, tt.endTime.hour, tt.endTime.minute),
          );
        }).toList();

        monthDays.add(DayScheduleEntity(
          day: date,
          timetables: updatedTimetables,
        ));
      }
    }

    monthSchedules.add(MonthScheduleEntity(
      month: DateTime(year, month),
      daysTimeTables: monthDays,
    ));
  }

  return monthSchedules;
}

/// Helper for month arithmetic with overflow
DateTime _addMonths(DateTime date, int offset) {
  int newYear = date.year + ((date.month + offset - 1) ~/ 12);
  int newMonth = (date.month + offset - 1) % 12 + 1;
  if (newMonth <= 0) {
    newMonth += 12;
    newYear--;
  }
  return DateTime(newYear, newMonth);
}

class DateUtils {
  static int getDaysInMonth(int year, int month) {
    if (month == DateTime.february) {
      final isLeapYear =
          (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
      return isLeapYear ? 29 : 28;
    }
    const daysInMonth = <int>[31, -1, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    return daysInMonth[month - 1];
  }
}
