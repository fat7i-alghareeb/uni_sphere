import '../../../../../common/constant/app_strings.dart';
import '../../../../../shared/imports/imports.dart';

class NoSchedulesWidget extends StatelessWidget {
  const NoSchedulesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.calendar_month_outlined,
              size: 80.r,
              color: theme.primaryColor.withValues(alpha: 0.5),
            ),
            16.verticalSpace,
            Text(
              AppStrings.noSchedulesForThisMonth,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
