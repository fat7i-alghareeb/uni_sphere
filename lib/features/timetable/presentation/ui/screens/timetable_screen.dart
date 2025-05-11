import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:test/core/injection/injection.dart';
import 'package:test/core/result_builder/result_builder.dart';
import 'package:test/features/timetable/presentation/state/time_table/time_table_bloc.dart';
import 'package:test/shared/extensions/date_time_extension.dart';
import 'package:test/shared/extensions/string_extension.dart';
import 'package:test/shared/utils/helper/colored_print.dart';
import '../../../../../shared/imports/imports.dart';
import '../../../../../shared/widgets/dashed_line.dart';
import '../../../domain/entities/month_schedule_entity.dart';

class TimetableScreen extends StatefulWidget {
  const TimetableScreen({super.key});

  @override
  State<TimetableScreen> createState() => _TimetableScreenState();
}

class _TimetableScreenState extends State<TimetableScreen> {
  @override
  void initState() {
    super.initState();
    TimeTableBloc.selectedDateTime = DateTime.now();
    getIt<TimeTableBloc>().add(
      GetTimeTableEvent(
        month: TimeTableBloc.selectedDateTime,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<TimeTableBloc>(),
      child: BlocBuilder<TimeTableBloc, TimeTableState>(
        builder: (context, state) {
          return ResultBuilder<MonthScheduleEntity>(
            result: state.result,
            success: (data) => const TimetableBody(),
          );
        },
      ),
    );
  }
}

class TimetableBody extends StatefulWidget {
  const TimetableBody({super.key});

  @override
  State<TimetableBody> createState() => _TimetableBodyState();
}

class _TimetableBodyState extends State<TimetableBody> {
  int selectedDayIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  void _changeMonth(int offset) {
    final selectedMonth = DateTime(
      TimeTableBloc.selectedDateTime.year,
      TimeTableBloc.selectedDateTime.month + offset,
    );
    getIt<TimeTableBloc>().add(
      LoadMonthEvent(
        month: selectedMonth,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Only use the original days from the schedule entity

    return BlocConsumer<TimeTableBloc, TimeTableState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(
                      FontAwesomeIcons.chevronLeft,
                    ),
                    onPressed: () => _changeMonth(-1),
                  ),
                  Text(
                    '${TimeTableBloc.selectedDateTime.month.monthName} ${TimeTableBloc.selectedDateTime.year}',
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(
                      FontAwesomeIcons.chevronRight,
                    ),
                    onPressed: () => _changeMonth(1),
                  ),
                ],
              ),
            ),
            BlocBuilder<TimeTableBloc, TimeTableState>(
              builder: (context, state) {
                final monthSchedule =
                    getIt<TimeTableBloc>().getMonthsSchedulesByDateTime;
                final days = monthSchedule.daysTimeTables;
                if (days.isEmpty) {
                  return const Center(child: Text('No schedule available'));
                }
                final selectedDay = days[selectedDayIndex];

                return Expanded(
                  child: Column(
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
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 12),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? Colors.blue
                                      : Colors.grey[200],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${day.day}',
                                      style: TextStyle(
                                        color: isSelected
                                            ? Colors.white
                                            : Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      day.weekday.weekdayShort,
                                      style: TextStyle(
                                        color: isSelected
                                            ? Colors.white
                                            : Colors.black54,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      SizedBox(
                                        width: 60.r,
                                        child: Column(
                                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
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
                                          margin: REdgeInsets.symmetric(
                                              vertical: 5),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
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
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
