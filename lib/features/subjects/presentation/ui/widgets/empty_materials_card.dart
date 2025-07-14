import 'package:test/common/constant/app_strings.dart';
import 'package:test/shared/imports/imports.dart';

class EmptyMaterialsCard extends StatelessWidget {
  const EmptyMaterialsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: BorderRadius.circular(22.r),
        boxShadow: [
          BoxShadow(
            color: context.primaryColor.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.Materials,
            style:
                context.textTheme.titleMedium!.withColor(context.primaryColor),
          ),
          16.verticalSpace,
          Center(
            child: Column(
              children: [
                Icon(
                  Icons.folder_open,
                  size: 48.r,
                  color: context.greyColor.withValues(alpha: 0.5),
                ),
                8.verticalSpace,
                Text(
                  'No materials available',
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: context.greyColor.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
