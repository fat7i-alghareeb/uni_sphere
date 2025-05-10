import 'package:test/shared/extensions/date_time_extension.dart';
import 'package:test/shared/extensions/string_extension.dart';
import '../../../../../shared/imports/imports.dart';
import '../../../../../shared/widgets/dashed_line.dart';
import '../../../domain/entities/month_schedule_entity.dart';

class TimetableScreen extends StatefulWidget {
  final MonthScheduleEntity monthSchedule;

  const TimetableScreen({super.key, required this.monthSchedule});

  @override
  State<TimetableScreen> createState() => _TimetableScreenState();
}

class _TimetableScreenState extends State<TimetableScreen> {
  int selectedDayIndex = 0;

  @override
  Widget build(BuildContext context) {
    final days = widget.monthSchedule.daysTimeTables;

    if (days.isEmpty) {
      return const Center(child: Text('No schedule available'));
    }

    final selectedDay = days[selectedDayIndex];

    return Column(
      children: [
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: days.length,
            itemBuilder: (context, index) {
              final day = days[index].day;
              final isSelected = index == selectedDayIndex;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedDayIndex = index;
                  });
                },
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.blue : Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${day.day}',
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        day.weekday.weekdayShort,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: REdgeInsets.symmetric(
              vertical: 16,
              horizontal: AppConstants.horizontalScreensPadding,
            ),
            itemCount: selectedDay.timetables.length,
            itemBuilder: (context, index) {
              final timetable = selectedDay.timetables[index];
              return Column(
                children: [
                  SizedBox(
                    height: 80.r,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          width: 60.r,
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                timetable.startTime.formatTime,
                                textAlign: TextAlign.end,
                              ),
                              Expanded(
                                child: DashedLine(
                                  // height: 40.h,
                                  isVertical: true,
                                  dashHeight: 3,
                                  gapHeight: 3,
                                  // gapColor: "#F1E6FC".toColor(),
                                  dashColor: context.greyColor,
                                ),
                              ),
                              Text(
                                timetable.endTime.formatTime,
                                // _formatTime(timetable.endTime),
                                textAlign: TextAlign.end,
                              ),
                            ],
                          ),
                        ),
                        10.horizontalSpace,
                        Expanded(
                          child: Container(
                            padding: REdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 16,
                            ),
                            margin: REdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(timetable.subjectName),
                                Text(timetable.lecturerName),
                                // Text(_formatTime(timetable.startTime)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  20.verticalSpace,
                  DashedLine(
                    width: double.infinity,
                    dashWidth: 3,
                    gapWidth: 3,
                    dashColor: context.greyColor,
                  ),
                  20.verticalSpace,
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
