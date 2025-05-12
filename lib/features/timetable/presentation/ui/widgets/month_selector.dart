import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:test/core/injection/injection.dart';
import 'package:test/core/result_builder/result.dart';
import 'package:test/features/timetable/presentation/state/time_table/time_table_bloc.dart';
import 'package:test/shared/extensions/string_extension.dart';
import 'package:test/shared/widgets/loading_progress.dart';

class MonthSelector extends StatefulWidget {
  const MonthSelector({super.key});

  @override
  State<MonthSelector> createState() => _MonthSelectorState();
}

class _MonthSelectorState extends State<MonthSelector> {
  bool isLeftLoading = false;
  bool isRightLoading = false;

  void _changeMonth(int offset) {
    setState(() {
      if (offset < 0) {
        isLeftLoading = true;
      } else {
        isRightLoading = true;
      }
    });

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
    return BlocListener<TimeTableBloc, TimeTableState>(
      listener: (context, state) {
        if (state.loadMonthResult.isLoaded()) {
          setState(() {
            isLeftLoading = false;
            isRightLoading = false;
          });
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildMonthNavigationButton(
              isLoading: isLeftLoading,
              icon: FontAwesomeIcons.chevronLeft,
              onTap: () => _changeMonth(-1),
            ),
            Text(
              '${TimeTableBloc.selectedDateTime.month.monthName} ${TimeTableBloc.selectedDateTime.year}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            _buildMonthNavigationButton(
              isLoading: isRightLoading,
              icon: FontAwesomeIcons.chevronRight,
              onTap: () => _changeMonth(1),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMonthNavigationButton({
    required bool isLoading,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: REdgeInsets.all(8.0),
      child: isLoading
          ? const LoadingProgress(size: 25)
          : GestureDetector(
              onTap: onTap,
              child: Icon(
                icon,
                size: 25.r,
              ),
            ),
    );
  }
}
