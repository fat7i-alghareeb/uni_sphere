//!----------------------------  Imports  -------------------------------------!//
import 'package:beamer/beamer.dart';
import 'package:test/core/result_builder/result_builder.dart';
import '../../../../../core/injection/injection.dart';
import '../../../../../router/router_config.dart';
import '../../../../../shared/imports/imports.dart';
import '../../../../../shared/widgets/custom_shimmer.dart';
import '../../../domain/entities/subject_details_entity.dart';
import '../../state/subject_details_bloc/subject_details_bloc.dart';
import '../widgets/subject_details_header.dart';
import '../widgets/subject_details_body.dart';
import '../../../../../common/constant/app_strings.dart';

//!---------------------------- The Widget -------------------------------------!//
class SubjectDetailsScreen extends StatefulWidget {
  const SubjectDetailsScreen({super.key, required this.subjectId});
  final String subjectId;
  static const String pagePath = 'subject_details';

  static BeamerBuilder pageBuilder = (context, state, data) {
    final subjectId = data as String? ?? '';
    return BeamPage(
      key: ValueKey('subject_details_$subjectId'),
      child: SubjectDetailsScreen(subjectId: subjectId),
      type: BeamPageType.fadeTransition,
    );
  };

  @override
  State<SubjectDetailsScreen> createState() => _SubjectDetailsScreenState();
}

class _SubjectDetailsScreenState extends State<SubjectDetailsScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final List<Animation<double>> _animations;
  bool _isDisposed = false;
  bool _hasAnimated = false;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    getIt<SubjectDetailsBloc>()
        .add(GetSubjectDetailsEvent(subjectId: widget.subjectId));
  }

  void _initializeAnimations() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _animations = List.generate(
      3, // Header, Grades (if available), and Body
      (index) => Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            index * (0.5 / 3),
            (index * (0.5 / 3)) + 0.5,
            curve: Curves.easeOut,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _isDisposed = true;
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<SubjectDetailsBloc>(),
      child: BlocBuilder<SubjectDetailsBloc, SubjectDetailsState>(
        builder: (context, state) {
          return ResultBuilder<SubjectDetailsEntity>(
            result: state.result,
            loading: () {
              _hasAnimated = false;
              return _buildLoadingShimmer();
            },
            success: (subjectDetails) {
              if (!_isDisposed && !_hasAnimated) {
                _controller.reset();
                _controller.forward();
                _hasAnimated = true;
              }
              return _buildContent(subjectDetails);
            },
          );
        },
      ),
    );
  }

  Widget _buildContent(SubjectDetailsEntity subjectDetails) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: AnimatedBuilder(
                animation: _animations[0],
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, -20 * (1 - _animations[0].value)),
                    child: Opacity(
                      opacity: _animations[0].value,
                      child: child,
                    ),
                  );
                },
                child: SubjectDetailsHeader(
                  subjectDetails: subjectDetails,
                ),
              ),
            ),
            if (subjectDetails.midTermGrade != null ||
                subjectDetails.finalGrade != null)
              SliverToBoxAdapter(
                child: AnimatedBuilder(
                  animation: _animations[1],
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, -20 * (1 - _animations[1].value)),
                      child: Opacity(
                        opacity: _animations[1].value,
                        child: child,
                      ),
                    );
                  },
                  child: _buildGradesSection(subjectDetails),
                ),
              ),
            SliverToBoxAdapter(
              child: AnimatedBuilder(
                animation: _animations.last,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, -20 * (1 - _animations.last.value)),
                    child: Opacity(
                      opacity: _animations.last.value,
                      child: child,
                    ),
                  );
                },
                child: SubjectDetailsBody(
                  subjectDetails: subjectDetails,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGradesSection(SubjectDetailsEntity subjectDetails) {
    final totalGrade =
        (subjectDetails.midTermGrade ?? 0) + (subjectDetails.finalGrade ?? 0);
    return Container(
      margin: REdgeInsets.all(AppConstants.horizontalScreensPadding),
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
            AppStrings.theGrade,
            style: context.textTheme.titleLarge?.copyWith(
              color: context.onBackgroundColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          16.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (subjectDetails.midTermGrade != null) ...[
                _buildGradeItem(
                  context,
                  AppStrings.midTermGrade,
                  subjectDetails.midTermGrade.toString(),
                ),
              ],
              if (subjectDetails.finalGrade != null) ...[
                _buildGradeItem(
                  context,
                  AppStrings.finalGrade,
                  subjectDetails.finalGrade.toString(),
                ),
              ],
              _buildGradeItem(
                context,
                AppStrings.theGrade,
                totalGrade.toString(),
              ),
            ],
          ),
          16.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatusItem(
                context,
                AppStrings.isPassed,
                subjectDetails.isPassed,
              ),
              _buildStatusItem(
                context,
                AppStrings.canEnroll,
                subjectDetails.canEnroll,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingShimmer() {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: _buildHeaderShimmer(),
            ),
            SliverToBoxAdapter(
              child: _buildBodyShimmer(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderShimmer() {
    return Container(
      padding: REdgeInsets.all(AppConstants.horizontalScreensPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image shimmer
          Center(
            child: Container(
              height: 200.h,
              width: 200.w,
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
              child: CustomShimmerWidget(
                height: 200.h,
                width: 200.w,
                borderRadius: 22,
              ),
            ),
          ),
          16.verticalSpace,
          // Title shimmer
          Center(
            child: Container(
              height: 32.h,
              width: 200.w,
              decoration: BoxDecoration(
                color: context.cardColor,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: CustomShimmerWidget(
                height: 32.h,
                width: 200.w,
                borderRadius: 8,
              ),
            ),
          ),
          16.verticalSpace,
          // Professor info shimmer
          Container(
            height: 24.h,
            width: 100.w,
            decoration: BoxDecoration(
              color: context.cardColor,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: CustomShimmerWidget(
              height: 24.h,
              width: 100.w,
              borderRadius: 8,
            ),
          ),
          8.verticalSpace,
          Container(
            height: 20.h,
            width: 150.w,
            decoration: BoxDecoration(
              color: context.cardColor,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: CustomShimmerWidget(
              height: 20.h,
              width: 150.w,
              borderRadius: 8,
            ),
          ),
          8.verticalSpace,
          Container(
            height: 16.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: context.cardColor,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: CustomShimmerWidget(
              height: 16.h,
              width: double.infinity,
              borderRadius: 8,
            ),
          ),
          16.verticalSpace,
          // Subject info card shimmer
          Container(
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
                Container(
                  height: 24.h,
                  width: 150.w,
                  decoration: BoxDecoration(
                    color: context.cardColor,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: CustomShimmerWidget(
                    height: 24.h,
                    width: 150.w,
                    borderRadius: 8,
                  ),
                ),
                16.verticalSpace,
                ...List.generate(
                    5,
                    (index) => Padding(
                          padding: REdgeInsets.only(bottom: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 16.h,
                                width: 100.w,
                                decoration: BoxDecoration(
                                  color: context.cardColor,
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: CustomShimmerWidget(
                                  height: 16.h,
                                  width: 100.w,
                                  borderRadius: 8,
                                ),
                              ),
                              Container(
                                height: 16.h,
                                width: 80.w,
                                decoration: BoxDecoration(
                                  color: context.cardColor,
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: CustomShimmerWidget(
                                  height: 16.h,
                                  width: 80.w,
                                  borderRadius: 8,
                                ),
                              ),
                            ],
                          ),
                        )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBodyShimmer() {
    return Container(
      padding: REdgeInsets.all(AppConstants.horizontalScreensPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Description card shimmer
          Container(
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
                Container(
                  height: 24.h,
                  width: 120.w,
                  decoration: BoxDecoration(
                    color: context.cardColor,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: CustomShimmerWidget(
                    height: 24.h,
                    width: 120.w,
                    borderRadius: 8,
                  ),
                ),
                16.verticalSpace,
                ...List.generate(
                    4,
                    (index) => Padding(
                          padding: REdgeInsets.only(bottom: 8),
                          child: Container(
                            height: 16.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: context.cardColor,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: CustomShimmerWidget(
                              height: 16.h,
                              width: double.infinity,
                              borderRadius: 8,
                            ),
                          ),
                        )),
              ],
            ),
          ),
          16.verticalSpace,
          // Materials section shimmer
          Container(
            height: 24.h,
            width: 100.w,
            decoration: BoxDecoration(
              color: context.cardColor,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: CustomShimmerWidget(
              height: 24.h,
              width: 100.w,
              borderRadius: 8,
            ),
          ),
          16.verticalSpace,
          ...List.generate(
              3,
              (index) => Padding(
                    padding: REdgeInsets.only(bottom: 8),
                    child: Container(
                      padding: REdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: context.cardColor,
                        borderRadius: BorderRadius.circular(12.r),
                        boxShadow: [
                          BoxShadow(
                            color: context.primaryColor.withValues(alpha: 0.1),
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 40.h,
                            width: 40.w,
                            decoration: BoxDecoration(
                              color: context.cardColor,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: CustomShimmerWidget(
                              height: 40.h,
                              width: 40.w,
                              borderRadius: 8,
                            ),
                          ),
                          16.horizontalSpace,
                          Expanded(
                            child: Container(
                              height: 20.h,
                              decoration: BoxDecoration(
                                color: context.cardColor,
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: CustomShimmerWidget(
                                height: 20.h,
                                width: double.infinity,
                                borderRadius: 8,
                              ),
                            ),
                          ),
                          16.horizontalSpace,
                          Container(
                            height: 24.h,
                            width: 24.w,
                            decoration: BoxDecoration(
                              color: context.cardColor,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: CustomShimmerWidget(
                              height: 24.h,
                              width: 24.w,
                              borderRadius: 8,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
        ],
      ),
    );
  }

  Widget _buildGradeItem(BuildContext context, String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: context.textTheme.labelMedium?.copyWith(
            color: context.greyColor,
          ),
        ),
        8.verticalSpace,
        Text(
          value,
          style: context.textTheme.titleLarge?.copyWith(
            color: context.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildStatusItem(BuildContext context, String label, bool value) {
    return Row(
      children: [
        Container(
          width: 12.w,
          height: 12.w,
          decoration: BoxDecoration(
            color: value ? Colors.green : Colors.red,
            shape: BoxShape.circle,
          ),
        ),
        8.horizontalSpace,
        Text(
          label,
          style: context.textTheme.labelMedium?.copyWith(
            color: context.greyColor,
          ),
        ),
      ],
    );
  }
}
