import 'package:test/features/timetable/data/models/day_schedule_model.dart'
    show DayScheduleModel;
import 'package:test/features/timetable/data/models/item_model.dart'
    show ItemModel;
import 'package:test/features/timetable/data/models/moth_schedule_model.dart'
    show MothScheduleModel;
import 'package:test/features/timetable/domain/entities/day_schedule_entity.dart'
    show DayScheduleEntity;
import 'package:test/features/timetable/domain/entities/timetable_entity.dart'
    show TimetableEntity;
import 'package:test/shared/extensions/date_time_extension.dart';

import '../../domain/entities/month_schedule_entity.dart'
    show MonthScheduleEntity;

extension MothScheduleMapper on MothScheduleModel {
  MonthScheduleEntity toEntity() {
    // Filter out days with empty schedules
    final daysWithSchedules = days
        .map((day) => day.toEntity())
        .where((day) => day.timetables.isNotEmpty)
        .toList();

    return MonthScheduleEntity(
      month: month.toDate() ?? DateTime.now(),
      daysTimeTables: daysWithSchedules,
    );
  }
}

extension DayScheduleMapper on DayScheduleModel {
  DayScheduleEntity toEntity() {
    return DayScheduleEntity(
      day: day.toDate() ?? DateTime.now(),
      timetables: items.map((item) => item.toEntity()).toList(),
    );
  }
}

extension ItemMapper on ItemModel {
  TimetableEntity toEntity() {
    return TimetableEntity(
      subjectName: subjectName,
      lecturerName: lectureName,
      lectureHall: lectureHall,
      startTime: startTime.toTime() ?? DateTime.now(),
      endTime: endTime.toTime() ?? DateTime.now(),
    );
  }
}
