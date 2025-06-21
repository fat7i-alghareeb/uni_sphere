import '../../../../../core/injection/injection.dart';
import '../../../../../core/result_builder/result.dart';
import '../../state/time_table/time_table_bloc.dart';
import '../../../../../shared/imports/imports.dart';
import '../widgets/day_selector.dart';
import '../widgets/month_selector.dart';
import '../widgets/timetable_item.dart';
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
          // Show TimetableBody for both initial load and month navigation
          // This allows proper error handling in both cases
          return const TimetableBody();
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
        if (state.loadMonthResult.isLoaded() || state.result.isLoaded()) {
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
              previous.loadMonthResult.getDataWhenSuccess()?.month.month ||
          current.loadMonthResult.isError() !=
              previous.loadMonthResult.isError() ||
          current.result.getDataWhenSuccess()?.month.month !=
              previous.result.getDataWhenSuccess()?.month.month ||
          current.result.isError() != previous.result.isError(),
      builder: (context, state) {
        // Check for error state in both result and loadMonthResult
        if (state.loadMonthResult.isError()) {
          return NoSchedulesWidget(
            isError: true,
            errorMessage: state.loadMonthResult.getError(),
            onRetry: () => _retryCurrentMonth(),
          );
        }

        if (state.result.isError()) {
          return NoSchedulesWidget(
            isError: true,
            errorMessage: state.result.getError(),
            onRetry: () => _retryCurrentMonth(),
          );
        }

        // Check if we have data from either result or loadMonthResult
        final monthData = state.loadMonthResult.getDataWhenSuccess() ??
            state.result.getDataWhenSuccess();

        if (monthData == null) {
          return NoSchedulesWidget(
            isError: false,
            onRetry: () => _retryCurrentMonth(),
          );
        }

        final days = monthData.daysTimeTables;

        // Filter out days with empty schedules
        final daysWithSchedules =
            days.where((day) => day.timetables.isNotEmpty).toList();

        if (daysWithSchedules.isEmpty) {
          return NoSchedulesWidget(
            isError: false,
            onRetry: () => _retryCurrentMonth(),
          );
        }

        // Ensure selectedDayIndex is within bounds
        if (selectedDayIndex >= daysWithSchedules.length) {
          selectedDayIndex = 0;
        }

        final selectedDay = daysWithSchedules[selectedDayIndex];

        return Expanded(
          child: Column(
            children: [
              DaySelector(
                days: daysWithSchedules,
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

  void _retryCurrentMonth() {
    // Check which state has an error and retry accordingly
    final bloc = getIt<TimeTableBloc>();
    final currentState = bloc.state;

    if (currentState.result.isError()) {
      // Retry initial load
      bloc.add(
        GetTimeTableEvent(
          month: TimeTableBloc.selectedDateTime,
        ),
      );
    } else {
      // Retry month navigation
      bloc.add(
        LoadMonthEvent(
          month: TimeTableBloc.selectedDateTime,
        ),
      );
    }
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
