
import 'dart:async';

import '../../../../../common/constant/app_strings.dart';
import '../../../../../shared/imports/imports.dart';
import 'time_block.dart';

class DecorativeCircle extends StatelessWidget {
  final double size;
  final double top;
  final double? left;
  final double? right;
  final double bottom;

  const DecorativeCircle({
    super.key,
    required this.size,
    this.top = 0,
    this.left,
    this.right,
    this.bottom = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          color: context.primaryColor.withOpacity(0.3),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

class CountdownContainer extends StatelessWidget {
  final Widget child;

  const CountdownContainer({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      clipBehavior: Clip.hardEdge,
      borderRadius: BorderRadius.circular(22.r),
      child: Stack(
        children: [
          DecorativeCircle(
            size: 180.h,
            top: -70.h,
            left: context.isEnglish ? -40.w : null,
            right: context.isEnglish ? null : -40.w,
          ),
          DecorativeCircle(
            size: 60.h,
            bottom: -25.h,
            left: context.isEnglish ? 0 : -50.w,
            right: context.isEnglish ? -50.w : 0,
          ),
          DecorativeCircle(
            size: 60.h,
            top: 10.h,
            left: context.isEnglish ? null : 60.w,
            right: context.isEnglish ? 60.w : null,
          ),
          Container(
            padding: REdgeInsets.only(
              left: 4,
              right: 4,
              top: 10,
              bottom: 10,
            ),
            decoration: BoxDecoration(
              color: context.primaryColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: child,
          ),
        ],
      ),
    );
  }
}

class DaysToTheFinalsBody extends StatefulWidget {
  const DaysToTheFinalsBody({super.key, required this.targetDate});
  final DateTime targetDate;
  @override
  State<DaysToTheFinalsBody> createState() => _DaysToTheFinalsBodyState();
}

class _DaysToTheFinalsBodyState extends State<DaysToTheFinalsBody> {
  late DateTime targetDate;
  late Duration remaining;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    targetDate = widget.targetDate;
    _calculateRemainingTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _calculateRemainingTime();
    });
  }

  void _calculateRemainingTime() {
    final now = DateTime.now().toUtc();
    if (now.isBefore(targetDate)) {
      setState(() {
        remaining = targetDate.difference(now);
      });
    } else {
      setState(() {
        remaining = Duration.zero;
      });
      _timer.cancel();
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final days = remaining.inDays;
    final hours = remaining.inHours % 24;
    final minutes = remaining.inMinutes % 60;
    final seconds = remaining.inSeconds % 60;

    return CountdownContainer(
      child: Column(
        children: [
          Text(
            AppStrings.numberOfDaysToTheFinals,
            style: context.textTheme.bodyLarge!.copyWith(
              color: context.onBackgroundColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          20.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TimeBlock(value: days, label: AppStrings.days),
              TimeBlock(value: hours, label: AppStrings.hours),
              TimeBlock(value: minutes, label: AppStrings.minutes),
              TimeBlock(value: seconds, label: AppStrings.seconds),
            ],
          ),
        ],
      ),
    );
  }
}

class DaysToTheFinalsLoadingBody extends StatelessWidget {
  const DaysToTheFinalsLoadingBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CountdownContainer(
      child: Column(
        children: [
          Text(
            AppStrings.numberOfDaysToTheFinals,
            style: context.textTheme.bodyLarge!.copyWith(
              color: context.onBackgroundColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          20.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              LoadingTimeBlock(label: AppStrings.days),
              LoadingTimeBlock(label: AppStrings.hours),
              LoadingTimeBlock(label: AppStrings.minutes),
              LoadingTimeBlock(label: AppStrings.seconds),
            ],
          ),
        ],
      ),
    );
  }
}
