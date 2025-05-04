
import '../../../../../shared/imports/imports.dart';
import '../../../../../shared/widgets/custom_shimmer.dart';
import 'flip_digit.dart';

class TimeBlock extends StatelessWidget {
  final int value;
  final String label;

  const TimeBlock({
    super.key,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FlipDigit(value: value),
        8.verticalSpace,
        Text(
          label,
          style: context.textTheme.labelLarge!
              .copyWith(color: context.onBackgroundColor),
        ),
      ],
    );
  }
}

class LoadingTimeBlock extends StatelessWidget {
  final String label;

  const LoadingTimeBlock({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomShimmerWidget(
          width: 60,
          height: 90,
          borderRadius: 12,
        ),
        8.verticalSpace,
        Text(
          label,
          style: context.textTheme.labelLarge!
              .copyWith(color: context.onBackgroundColor),
        ),
      ],
    );
  }
}
