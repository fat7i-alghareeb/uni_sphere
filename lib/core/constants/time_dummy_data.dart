import 'package:intl/intl.dart';

import '../../features/timetable/domain/entities/day_schedule_entity.dart';
import '../../features/timetable/domain/entities/month_schedule_entity.dart';
import '../../features/timetable/domain/entities/timetable_entity.dart';

// Helper function to create DateTime at specific hour/minute
DateTime _time(int month, int day, int hour, int minute) {
  return DateTime(2023, month, day, hour, minute);
}

// Create a list of MonthScheduleEntity objects
List<MonthScheduleEntity> get generateDummyData { 
  // This will be our repeating weekly schedule (same for each week)
  final weeklyTimetable = [
  
    // Monday
    DayScheduleEntity(
      day: DateTime(2023, 1, 2), // The date doesn't matter as we'll override it
      timetables: [
        TimetableEntity(
          subjectName: "Data Structures",
          lecturerName: "Dr. Ahmad Al-Masri",
          startTime: _time(1, 2, 8, 0),
          endTime: _time(1, 2, 10, 0),
        ),
        TimetableEntity(
          subjectName: "Computer Architecture",
          lecturerName: "Dr. Fatima Khalil",
          startTime: _time(1, 2, 10, 30),
          endTime: _time(1, 2, 12, 30),
        ),
      ],
    ),
    // Tuesday
    DayScheduleEntity(
      day: DateTime(2023, 1, 3),
      timetables: [
        TimetableEntity(
          subjectName: "Operating Systems",
          lecturerName: "Dr. Omar Al-Hassan",
          startTime: _time(1, 3, 9, 0),
          endTime: _time(1, 3, 11, 0),
        ),
        TimetableEntity(
          subjectName: "Database Systems",
          lecturerName: "Dr. Leila Ibrahim",
          startTime: _time(1, 3, 12, 0),
          endTime: _time(1, 3, 14, 0),
        ),
      ],
    ),
    // Wednesday
    DayScheduleEntity(
      day: DateTime(2023, 1, 4),
      timetables: [
        TimetableEntity(
          subjectName: "Computer Networks",
          lecturerName: "Dr. Youssef Hamoud",
          startTime: _time(1, 4, 8, 0),
          endTime: _time(1, 4, 10, 0),
        ),
        TimetableEntity(
          subjectName: "Lab: Data Structures",
          lecturerName: "Eng. Ali Darwish",
          startTime: _time(1, 4, 11, 0),
          endTime: _time(1, 4, 13, 0),
        ),
      ],
    ),
    // Thursday
    DayScheduleEntity(
      day: DateTime(2023, 1, 5),
      timetables: [
        TimetableEntity(
          subjectName: "Software Engineering",
          lecturerName: "Dr. Rana Saeed",
          startTime: _time(1, 5, 9, 0),
          endTime: _time(1, 5, 11, 0),
        ),
      ],
    ),
      // Sunday (Aleppo University typically has classes Sunday-Thursday)
    DayScheduleEntity(
      day: DateTime(2023, 1, 1),
      timetables: [
        TimetableEntity(
          subjectName: "Mathematics for CS",
          lecturerName: "Dr. Samer Al-Khatib",
          startTime: _time(1, 1, 10, 0),
          endTime: _time(1, 1, 12, 0),
        ),
        TimetableEntity(
          subjectName: "Elective: AI Fundamentals",
          lecturerName: "Dr. Hala Zaidan",
          startTime: _time(1, 1, 13, 0),
          endTime: _time(1, 1, 15, 0),
        ),
      ],
    ),
  ];

  // Generate 3 months of data (January, February, March)
  final months = [1, 2, 3];
  final monthSchedules = <MonthScheduleEntity>[];

  for (final month in months) {
    final daysInMonth = DateUtils.getDaysInMonth(2023, month);
    final monthDays = <DayScheduleEntity>[];

    // For each day in the month that matches our weekly schedule (Sun-Thu)
    for (int day = 1; day <= daysInMonth; day++) {
      final date = DateTime(2023, month, day);
      final weekday = date.weekday;

      // In Syria, workweek is Sun-Thu (weekday 7,1,2,3,4 in DateTime)
      if (weekday >= DateTime.sunday && weekday <= DateTime.thursday) {
        // Find the corresponding day in our weekly template
        final templateDay = weeklyTimetable.firstWhere(
          (d) => d.day.weekday == date.weekday,
        );

        // Create new timetable entries with the correct dates but same times
        final updatedTimetables = templateDay.timetables.map((tt) {
          return TimetableEntity(
            subjectName: tt.subjectName,
            lecturerName: tt.lecturerName,
            startTime: DateTime(
                2023, month, day, tt.startTime.hour, tt.startTime.minute),
            endTime:
                DateTime(2023, month, day, tt.endTime.hour, tt.endTime.minute),
          );
        }).toList();

        monthDays.add(DayScheduleEntity(
          day: date,
          timetables: updatedTimetables,
        ));
      }
    }

    monthSchedules.add(MonthScheduleEntity(
      month: DateTime(2023, month, 1),
      daysTimeTables: monthDays,
    ));
  }

  return monthSchedules;
}

// Helper class for date utilities
class DateUtils {
  static int getDaysInMonth(int year, int month) {
    if (month == DateTime.february) {
      final isLeapYear =
          (year % 4 == 0) && (year % 100 != 0) || (year % 400 == 0);
      return isLeapYear ? 29 : 28;
    }
    const daysInMonth = <int>[31, -1, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    return daysInMonth[month - 1];
  }
}
