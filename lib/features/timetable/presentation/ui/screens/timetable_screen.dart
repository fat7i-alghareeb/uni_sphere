import 'package:test/core/injection/injection.dart';
import 'package:test/core/result_builder/result.dart';
import 'package:test/core/result_builder/result_builder.dart';
import 'package:test/features/timetable/presentation/state/time_table/time_table_bloc.dart';
import '../../../../../shared/imports/imports.dart';
import 'package:test/features/timetable/presentation/ui/widgets/day_selector.dart';
import 'package:test/features/timetable/presentation/ui/widgets/month_selector.dart';
import 'package:test/features/timetable/presentation/ui/widgets/timetable_item.dart';

import '../../../domain/entities/month_schedule_entity.dart';
import '../widgets/no_schedule_widgets.dart';

class TimetableScreen extends StatefulWidget {
  const TimetableScreen({super.key});

  @override
  State<TimetableScreen> createState() => _TimetableScreenState();
}

class _TimetableScreenState extends State<TimetableScreen> {
  @override
  void initState() {
    super.initState();
    _initializeTimetable();
  }

  void _initializeTimetable() {
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
  Widget build(BuildContext context) {
    return BlocConsumer<TimeTableBloc, TimeTableState>(
      listener: (context, state) {
        if (state.loadMonthResult.isLoaded()) {
          setState(() {
            selectedDayIndex = 0; // Reset to first day when month changes
          });
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            const MonthSelector(),
            _buildTimetableContent(context, state),
          ],
        );
      },
    );
  }

  Widget _buildTimetableContent(BuildContext context, TimeTableState state) {
    return BlocBuilder<TimeTableBloc, TimeTableState>(
      buildWhen: (previous, current) =>
          current.loadMonthResult.getDataWhenSuccess()?.month.month !=
          previous.loadMonthResult.getDataWhenSuccess()?.month.month,
      builder: (context, state) {
        final monthSchedule =
            getIt<TimeTableBloc>().getMonthsSchedulesByDateTime;
        final days = monthSchedule.daysTimeTables;

        if (days.isEmpty) {
          return const NoSchedulesWidget();
        }

        final selectedDay = days[selectedDayIndex];

        return Expanded(
          child: Column(
            children: [
              DaySelector(
                days: days,
                selectedDayIndex: selectedDayIndex,
                onDaySelected: (index) =>
                    setState(() => selectedDayIndex = index),
              ),
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0.0, 0.1),
                          end: Offset.zero,
                        ).animate(CurvedAnimation(
                          parent: animation,
                          curve: Curves.easeOut,
                        )),
                        child: child,
                      ),
                    );
                  },
                  child: ListView.builder(
                    key: ValueKey<int>(selectedDayIndex),
                    padding: REdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: AppConstants.horizontalScreensPadding,
                    ),
                    itemCount: selectedDay.timetables.length,
                    itemBuilder: (context, index) {
                      return AnimatedListItem(
                        index: index,
                        child: TimetableItem(
                          timetable: selectedDay.timetables[index],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class AnimatedListItem extends StatefulWidget {
  final Widget child;
  final int index;

  const AnimatedListItem({
    super.key,
    required this.child,
    required this.index,
  });

  @override
  State<AnimatedListItem> createState() => _AnimatedListItemState();
}

class _AnimatedListItemState extends State<AnimatedListItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );
    Future.delayed(Duration(milliseconds: widget.index * 50), () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0.0, 0.1),
          end: Offset.zero,
        ).animate(_animation),
        child: widget.child,
      ),
    );
  }
}
