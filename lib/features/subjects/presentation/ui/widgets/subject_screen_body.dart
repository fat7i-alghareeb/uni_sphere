import '../../../../../core/injection/injection.dart';
import '../../../../../shared/imports/imports.dart';
import '../../../../../shared/widgets/custom_shimmer.dart';
import '../../../domain/entities/subject_entity.dart';
import '../../state/subject_details_bloc/subject_details_bloc.dart';
import 'subject_item_card.dart';

/// The body of the subjects screen that displays the list of subjects.
class SubjectsScreenBody extends StatefulWidget {
  const SubjectsScreenBody({
    super.key,
    required this.subjects,
    this.fullInfo = false,
    this.onRefresh,
  });

  final List<SubjectEntity> subjects;
  final bool fullInfo;
  final Future<void> Function()? onRefresh;
  @override
  State<SubjectsScreenBody> createState() => _SubjectsScreenBodyState();
}

class _SubjectsScreenBodyState extends State<SubjectsScreenBody>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final List<Animation<double>> _animations;
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    try {
      _controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 800),
      );

      _animations = List.generate(
        widget.subjects.length,
        (index) => Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Interval(
              index * (0.5 / widget.subjects.length),
              (index * (0.5 / widget.subjects.length)) + 0.5,
              curve: Curves.easeOut,
            ),
          ),
        ),
      );

      // Add status listener to handle animation completion
      _controller.addStatusListener(_handleAnimationStatus);

      // Start animation with a small delay to ensure proper initialization
      Future.delayed(const Duration(milliseconds: 50), () {
        if (!_isDisposed) {
          _controller.forward();
        }
      });
    } catch (e) {
      debugPrint('Error initializing animations: $e');
      // Fallback to immediate display without animation
      _animations = List.generate(
        widget.subjects.length,
        (index) => const AlwaysStoppedAnimation(1.0),
      );
    }
  }

  void _handleAnimationStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      // Clean up any resources if needed after animation completes
      debugPrint('Animation completed successfully');
    } else if (status == AnimationStatus.dismissed) {
      debugPrint('Animation was dismissed');
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    try {
      _controller.removeStatusListener(_handleAnimationStatus);
      _controller.dispose();
    } catch (e) {
      debugPrint('Error disposing animation controller: $e');
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    try {
      return Stack(
        children: [
          _buildShimmerList(),
          _buildAnimatedSubjectsList(),
        ],
      );
    } catch (e) {
      debugPrint('Error building subjects screen: $e');
      // Fallback to simple list without animation
      return ListView.builder(
        padding: REdgeInsets.only(
          top: 10.h,
          right: AppConstants.horizontalScreensPadding,
          left: AppConstants.horizontalScreensPadding,
          bottom: 150.h,
        ),
        itemBuilder: (context, index) => SubjectItemCard(subject: widget.subjects[index]),
        itemCount: widget.subjects.length,
      );
    }
  }

  Widget _buildShimmerList() {
    try {
      return ListView.builder(
        padding: REdgeInsets.only(
          top: 10.h,
          right: AppConstants.horizontalScreensPadding,
          left: AppConstants.horizontalScreensPadding,
          bottom: 150.h,
        ),
        itemBuilder: (context, index) {
          if (index >= _animations.length) {
            return const SizedBox.shrink();
          }
          return AnimatedBuilder(
            animation: _animations[index],
            builder: (context, child) {
              return Opacity(
                opacity: 1 - _animations[index].value,
                child: child,
              );
            },
            child: _buildShimmerCard(),
          );
        },
        itemCount: widget.subjects.length,
      );
    } catch (e) {
      debugPrint('Error building shimmer list: $e');
      return const SizedBox.shrink();
    }
  }

  Widget _buildAnimatedSubjectsList() {
    try {
      return RefreshIndicator(
        onRefresh: widget.onRefresh ?? () async {},
        child: ListView.builder(
          padding: REdgeInsets.only(
            top: 10.h,
            right: AppConstants.horizontalScreensPadding,
            left: AppConstants.horizontalScreensPadding,
            bottom: 150.h,
          ),
          itemBuilder: (context, index) {
            if (index >= widget.subjects.length ||
                index >= _animations.length) {
              return const SizedBox.shrink();
            }
            return AnimatedBuilder(
              animation: _animations[index],
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, -20 * (1 - _animations[index].value)),
                  child: Opacity(
                    opacity: _animations[index].value,
                    child: child,
                  ),
                );
              },
              child: SubjectItemCard(
                subject: widget.subjects[index],
                haveFullInfo: widget.fullInfo,
              ),
            );
          },
          itemCount: widget.subjects.length,
        ),
      );
    } catch (e) {
      debugPrint('Error building animated subjects list: $e');
      return const SizedBox.shrink();
    }
  }

  Widget _buildShimmerCard() {
    try {
      return CustomShimmerWidget(
        height: 124.h,
        width: double.infinity,
        borderRadius: 22,
        padding: REdgeInsets.symmetric(vertical: 6),
      );
    } catch (e) {
      debugPrint('Error building shimmer card: $e');
      return const SizedBox.shrink();
    }
  }
}
