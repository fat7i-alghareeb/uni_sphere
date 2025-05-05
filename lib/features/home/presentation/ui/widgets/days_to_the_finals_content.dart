import 'dart:async';

import '../../../../../common/constant/app_strings.dart';
import '../../../../../shared/imports/imports.dart';
import 'decorated_container.dart';
import 'time_block.dart';

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

    return DecoratedContainer(
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
    return DecoratedContainer(
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
