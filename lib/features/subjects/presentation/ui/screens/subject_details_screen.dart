//!----------------------------  Imports  -------------------------------------!//
import 'package:beamer/beamer.dart';
import 'package:test/core/result_builder/result_builder.dart';
import 'package:test/features/subjects/presentation/ui/widgets/subject_details_image.dart';
import '../../../../../core/injection/injection.dart';
import '../../../../../router/router_config.dart';
import '../../../../../shared/imports/imports.dart';
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
    _hasAnimated = false;
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
    );
  }

  Widget _buildLoadingShimmer() {
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
  }
}
