//!----------------------------  Imports  -------------------------------------!//
import 'package:beamer/beamer.dart';
import 'package:test/core/result_builder/result.dart';
import 'package:test/core/result_builder/result_builder.dart';
import 'package:test/features/subjects/presentation/ui/widgets/subject_details_image.dart';
import '../../../../../common/constant/app_strings.dart';
import '../../../../../core/injection/injection.dart';
import '../../../../../router/router_config.dart';
import '../../../../../shared/imports/imports.dart';
import '../../../../../shared/widgets/custom_scaffold_body.dart';
import '../../../../../shared/widgets/failed_widget.dart';
import '../../../domain/entities/subject_details_entity.dart';
import '../../state/subject_details_bloc/subject_details_bloc.dart';
import '../widgets/subject_details_header.dart';
import '../widgets/subject_description_with_materials.dart';
import '../widgets/subject_details_grades.dart';

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
  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();
    try {
      _initializeAnimations();
      getIt<SubjectDetailsBloc>()
          .add(GetSubjectDetailsEvent(subjectId: widget.subjectId));
    } catch (e) {
      debugPrint('Error initializing SubjectDetailsScreen: $e');
    }
  }

  void _initializeAnimations() {
    try {
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

      // Add status listener to track animation state
      _controller.addStatusListener(_handleAnimationStatus);
    } catch (e) {
      debugPrint('Error initializing animations: $e');
    }
  }

  void _handleAnimationStatus(AnimationStatus status) {
    // Use Future.microtask to avoid setState during build
    Future.microtask(() {
      if (!_isDisposed) {
        if (status == AnimationStatus.forward) {
          setState(() {
            _isAnimating = true;
          });
        } else if (status == AnimationStatus.completed) {
          setState(() {
            _isAnimating = false;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _isDisposed = true;
    _hasAnimated = false;
    try {
      _controller.removeStatusListener(_handleAnimationStatus);
      _controller.dispose();
    } catch (e) {
      debugPrint('Error disposing animation controller: $e');
    }
    super.dispose();
  }

  /// Handles retry when an error occurs
  void _handleRetry() {
    try {
      getIt<SubjectDetailsBloc>()
          .add(GetSubjectDetailsEvent(subjectId: widget.subjectId));
    } catch (e) {
      debugPrint('Error in retry: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<SubjectDetailsBloc>(),
      child: BlocBuilder<SubjectDetailsBloc, SubjectDetailsState>(
        builder: (context, state) {
          // Handle error state manually
          if (state.result.isError()) {
            return _buildErrorState(state.result.getError());
          }

          return ResultBuilder<SubjectDetailsEntity>(
            result: state.result,
            loading: () {
              _hasAnimated = false;
              return _buildLoadingShimmer();
            },
            success: (subjectDetails) {
              if (!_isDisposed && !_hasAnimated) {
                try {
                  _controller.reset();
                  _controller.forward();
                  _hasAnimated = true;
                } catch (e) {
                  debugPrint('Error starting animation: $e');
                }
              }
              return _buildContent(subjectDetails);
            },
          );
        },
      ),
    );
  }

  Widget _buildContent(SubjectDetailsEntity subjectDetails) {
    try {
      return AbsorbPointer(
        absorbing: _isAnimating, // Block touch interactions during animation
        child: Scaffold(
          body: CustomScrollView(
            slivers: [
              SubjectDetailsImage(
                imageUrl: subjectDetails.imageUrl,
                title: subjectDetails.title,
              ),
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
                  child: Padding(
                    padding: REdgeInsets.symmetric(vertical: 9),
                    child: SubjectDetailsHeader(
                      subjectDetails: subjectDetails,
                    ),
                  ),
                ),
              ),
              if ((subjectDetails.midTermGrade != null ||
                  subjectDetails.finalGrade != null))
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
                    child: Padding(
                      padding: REdgeInsets.symmetric(vertical: 9.0),
                      child: SubjectDetailsGrades(
                        subjectDetails: subjectDetails,
                      ),
                    ),
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
                  child: Padding(
                    padding: REdgeInsets.symmetric(vertical: 9.0),
                    child: SubjectDescriptionWithMaterials(
                      subjectDetails: subjectDetails,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } catch (e) {
      debugPrint('Error building content: $e');
      return _buildErrorState(AppStrings.somethingWentWrong);
    }
  }

  Widget _buildErrorState(String error) {
    try {
      return Scaffold(
        body: CustomScaffoldBody(
          title: AppStrings.subjectDetails,
          child: FailedWidget(
            error: error,
            onPressed: _handleRetry,
            retryText: AppStrings.tryAgain,
          ),
        ),
      );
    } catch (e) {
      debugPrint('Error building error state: $e');
      return Scaffold(
        body: Center(
          child: Text(AppStrings.somethingWentWrong),
        ),
      );
    }
  }

  Widget _buildLoadingShimmer() {
    try {
      return Scaffold(
        body: CustomScrollView(
          slivers: [
            SubjectDetailsImage.buildImageShimmer(context),
            SliverToBoxAdapter(
              child: SubjectDetailsHeader.buildHeaderShimmer(context),
            ),
            SliverToBoxAdapter(
              child: SubjectDescriptionWithMaterials.buildBodyShimmer(context),
            ),
          ],
        ),
      );
    } catch (e) {
      debugPrint('Error building loading shimmer: $e');
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}
