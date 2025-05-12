import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test/shared/extensions/date_time_extension.dart';
import 'package:test/shared/imports/imports.dart';
import 'package:test/shared/widgets/dashed_line.dart';

import '../../../domain/entities/timetable_entity.dart';

class TimetableItem extends StatelessWidget {
  final TimetableEntity timetable;

  const TimetableItem({
    super.key,
    required this.timetable,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 80.r,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTimeColumn(context),
              10.horizontalSpace,
              _buildSubjectInfo(context),
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
  }

  Widget _buildTimeColumn(BuildContext context) {
    return SizedBox(
      width: 60.r,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            timetable.startTime.formatTime,
            textAlign: TextAlign.end,
          ),
          Expanded(
            child: DashedLine(
              isVertical: true,
              dashHeight: 3,
              gapHeight: 3,
              dashColor: context.greyColor,
            ),
          ),
          Text(
            timetable.endTime.formatTime,
            textAlign: TextAlign.end,
          ),
        ],
      ),
    );
  }

  Widget _buildSubjectInfo(BuildContext context) {
    return Expanded(
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
          ],
        ),
      ),
    );
  }
}
