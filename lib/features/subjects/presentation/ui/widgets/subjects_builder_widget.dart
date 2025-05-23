import '../../../../../core/result_builder/result.dart';
import '../../../../../core/result_builder/result_builder.dart';
import '../../../../../shared/imports/imports.dart';
import '../../../../../shared/widgets/custom_shimmer.dart';
import '../../../domain/entities/subject_entity.dart';
import 'subject_screen_body.dart';

class SubjectsBuilderWidget extends StatelessWidget {
  const SubjectsBuilderWidget({
    super.key,
    required this.state,
    this.onRefresh,
    this.fullInfo = false,
  });
  final Result<List<SubjectEntity>> state;
  final bool fullInfo;
  final Future<void> Function()? onRefresh;
  @override
  Widget build(BuildContext context) {
    return ResultBuilder<List<SubjectEntity>>(
      result: state,
      success: (data) => SubjectsScreenBody(
        subjects: data,
        fullInfo: fullInfo,
        onRefresh: onRefresh,
      ),
      loading: () => _buildLoadingShimmer(),
    );
  }

  Widget _buildLoadingShimmer() {
    return ListView.builder(
      padding: REdgeInsets.only(
        top: 10.h,
        right: AppConstants.horizontalScreensPadding,
        left: AppConstants.horizontalScreensPadding,
        bottom: 150.h,
      ),
      itemBuilder: (context, index) => _buildShimmerCard(),
      itemCount: 10, // Show 5 shimmer cards while loading
    );
  }

  Widget _buildShimmerCard() {
    return CustomShimmerWidget(
      height: 124.h,
      width: double.infinity,
      borderRadius: 22,
      padding: REdgeInsets.symmetric(vertical: 6),
    );
  }
}
