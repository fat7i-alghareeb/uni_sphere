import 'package:flutter/material.dart';
import 'package:test/shared/extensions/string_extension.dart';
import '../../../domain/entities/day_schedule_entity.dart';

class DaySelector extends StatefulWidget {
  final List<DayScheduleEntity> days;

  const DaySelector({
    super.key,
    required this.days,
  });

  @override
  State<DaySelector> createState() => _DaySelectorState();
}

class _DaySelectorState extends State<DaySelector> {
  int selectedDayIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.days.length,
        itemBuilder: (context, index) => _buildDayItem(context, index),
      ),
    );
  }

  Widget _buildDayItem(BuildContext context, int index) {
    final day = widget.days[index].day;
    final isSelected = index == selectedDayIndex;

    return GestureDetector(
      onTap: () => setState(() => selectedDayIndex = index),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
  }
}
