import '../../../../../core/injection/injection.dart';
import '../../../../../core/result_builder/result_builder.dart';
import '../../../../../core/styles/colors.dart';
import '../../../../../shared/imports/imports.dart';
import '../../../../../shared/widgets/custom_shimmer.dart';
import '../../../domain/entities/news_entity.dart';
import '../../state/bloc/announcement_bloc.dart';
import 'my_news_card.dart';

class MyNewsWidget extends StatefulWidget {
  const MyNewsWidget({super.key});

  @override
  State<MyNewsWidget> createState() => _MyNewsWidgetState();
}

class _MyNewsWidgetState extends State<MyNewsWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late List<Animation<double>> _animations = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    getIt<AnnouncementBloc>().add(GetMyAnnouncementEvent());
  }

  void _initializeAnimations(int itemCount) {
    try {
      _controller.reset();
      _animations = List.generate(
        itemCount,
        (index) => Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Interval(
              index * (0.5 / itemCount),
              (index * (0.5 / itemCount)) + 0.5,
              curve: Curves.easeOut,
            ),
          ),
        ),
      );

      _controller.forward();
    } catch (e) {
      debugPrint('Error initializing animations: $e');
      _animations = List.generate(
        itemCount,
        (index) => const AlwaysStoppedAnimation(1.0),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnnouncementBloc, AnnouncementState>(
      builder: (context, state) => ResultBuilder<List<NewsEntity>>(
        onError: () {
          getIt<AnnouncementBloc>().add(
            GetMyAnnouncementEvent(),
          );
        },
        loading: () => _buildLoadingShimmer(),
        success: (data) {
          _initializeAnimations(data.length);
          return Stack(
            children: [
              _buildShimmerList(data.length),
              _buildAnimatedNewsList(data),
            ],
          );
        },
        result: state.myAnnouncementResult,
      ),
    );
  }

  Widget _buildLoadingShimmer() {
    return ListView.builder(
      padding: REdgeInsets.only(
        left: AppConstants.horizontalScreensPadding,
        right: AppConstants.horizontalScreensPadding,
        bottom: 100.h,
      ),
      itemBuilder: (context, index) => Container(
        margin: REdgeInsets.only(bottom: 22.h),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: context.cardColor,
          borderRadius: BorderRadius.circular(22.r),
          boxShadow: AppColors.primaryShadow(context),
        ),
        child: Padding(
          padding: REdgeInsets.all(22.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomShimmerWidget(
                height: 12.h,
                width: 100.w,
                borderRadius: 8,
              ),
              12.verticalSpace,
              CustomShimmerWidget(
                height: 25.h,
                width: double.infinity,
                borderRadius: 8,
              ),
              8.verticalSpace,
              CustomShimmerWidget(
                height: 18.h,
                width: double.infinity,
                borderRadius: 8,
              ),
              5.verticalSpace,
              CustomShimmerWidget(
                height: 18.h,
                width: double.infinity,
                borderRadius: 8,
              ),
              5.verticalSpace,
            ],
          ),
        ),
      ),
      itemCount: 10,
    );
  }

  Widget _buildShimmerList(int itemCount) {
    try {
      return ListView.builder(
        padding: REdgeInsets.only(
          left: AppConstants.horizontalScreensPadding,
          right: AppConstants.horizontalScreensPadding,
          bottom: 100.h,
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
        itemCount: itemCount,
      );
    } catch (e) {
      debugPrint('Error building shimmer list: $e');
      return const SizedBox.shrink();
    }
  }

  Widget _buildAnimatedNewsList(List<NewsEntity> data) {
    try {
      return ListView.builder(
        padding: REdgeInsets.only(
          left: AppConstants.horizontalScreensPadding,
          right: AppConstants.horizontalScreensPadding,
          bottom: 100.h,
        ),
        itemBuilder: (context, index) {
          if (index >= data.length || index >= _animations.length) {
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
            child: MyNewsCard(announcementEntity: data[index]),
          );
        },
        itemCount: data.length,
      );
    } catch (e) {
      debugPrint('Error building animated news list: $e');
      return const SizedBox.shrink();
    }
  }

  Widget _buildShimmerCard() {
    try {
      return Container(
        margin: REdgeInsets.only(bottom: 22.h),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: context.cardColor,
          borderRadius: BorderRadius.circular(22.r),
          boxShadow: AppColors.primaryShadow(context),
        ),
        child: Padding(
          padding: REdgeInsets.all(22.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomShimmerWidget(
                height: 12.h,
                width: 100.w,
                borderRadius: 8,
              ),
              12.verticalSpace,
              CustomShimmerWidget(
                height: 25.h,
                width: double.infinity,
                borderRadius: 8,
              ),
              8.verticalSpace,
              CustomShimmerWidget(
                height: 18.h,
                width: double.infinity,
                borderRadius: 8,
              ),
              5.verticalSpace,
              CustomShimmerWidget(
                height: 18.h,
                width: double.infinity,
                borderRadius: 8,
              ),
              5.verticalSpace,
            ],
          ),
        ),
      );
    } catch (e) {
      debugPrint('Error building shimmer card: $e');
      return const SizedBox.shrink();
    }
  }
}
