import 'dart:async';

import 'package:test/common/constant/app_strings.dart';
import 'package:test/core/result_builder/result_builder.dart';
import 'package:test/features/home/domain/entities/home_entity.dart';
import 'package:test/shared/widgets/custom_shimmer.dart';

import '../../../../../core/styles/colors.dart';
import '../../../../../shared/imports/imports.dart';
import '../../state/bloc/home_bloc.dart';

class FlipDigit extends StatefulWidget {
  final int value;
  const FlipDigit({required this.value, super.key});

  @override
  State<FlipDigit> createState() => _FlipDigitState();
}

class _FlipDigitState extends State<FlipDigit> with TickerProviderStateMixin {
  late int _oldValue;
  late AnimationController _controller;
  late AnimationController _fadeController;
  late Animation<double> _animation;
  late Animation<double> _fadeAnimation;
  bool _isFlipping = false;

  @override
  void initState() {
    super.initState();
    _oldValue = widget.value;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _fadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _fadeController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void didUpdateWidget(covariant FlipDigit oldWidget) {
    if (oldWidget.value != widget.value) {
      _oldValue = oldWidget.value;
      _isFlipping = true;
      _controller.forward(from: 0);
      _fadeController.forward(from: 0).then((_) {
        _fadeController.reverse();
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  Widget _buildHalf(
      {required bool isTop, required int value, double angle = 0}) {
    return Transform(
      alignment: isTop ? Alignment.bottomCenter : Alignment.topCenter,
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateX(angle),
      child: ClipRect(
        child: Align(
          alignment: isTop ? Alignment.topCenter : Alignment.bottomCenter,
          heightFactor: 0.5,
          child: Container(
            width: 60.w,
            height: 90.h,
            decoration: BoxDecoration(
              color: context.primaryColor,
              borderRadius: BorderRadius.vertical(
                top: isTop ? Radius.circular(12.r) : Radius.zero,
                bottom: !isTop ? Radius.circular(12.r) : Radius.zero,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final flipAnim = _animation.value;
        final isFlipping = _controller.isAnimating || _isFlipping;

        Widget topHalf;
        if (isFlipping && flipAnim < 0.5) {
          topHalf = _buildHalf(
            isTop: true,
            value: _oldValue,
            angle: -flipAnim * 3.1416,
          );
        } else {
          topHalf = _buildHalf(
            isTop: true,
            value: widget.value,
            angle: 0,
          );
        }

        Widget bottomHalf;
        if (isFlipping && flipAnim >= 0.5) {
          bottomHalf = _buildHalf(
            isTop: false,
            value: widget.value,
            angle: (1 - flipAnim) * 3.1416,
          );
        } else {
          bottomHalf = _buildHalf(
            isTop: false,
            value: _oldValue,
            angle: 0,
          );
        }

        if (_isFlipping && !_controller.isAnimating) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            setState(() {
              _isFlipping = false;
            });
          });
        }

        return SizedBox(
          width: 60.w,
          height: 90.h,
          child: Stack(
            children: [
              Column(
                children: [
                  Flexible(child: SizedBox(height: 44.h, child: topHalf)),
                  Container(height: 1.h, color: Colors.transparent),
                  Flexible(child: SizedBox(height: 44.h, child: bottomHalf)),
                ],
              ),
              Center(
                child: AnimatedBuilder(
                  animation: _fadeAnimation,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _isFlipping ? _fadeAnimation.value : 1.0,
                      child: Text(
                        widget.value.toString().padLeft(2, '0'),
                        style: context.textTheme.displayMedium!
                            .copyWith(color: AppColors.lightBackground),
                      ),
                    );
                  },
                ),
              ),
              Positioned(
                top: 44.h,
                left: 0,
                right: 0,
                child: Container(height: 1.h, color: context.backgroundColor),
              )
            ],
          ),
        );
      },
    );
  }
}

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
    // Parse the target date
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

  Widget buildTimeBlock(int value, String label) {
    return Column(
      children: [
        FlipDigit(value: value),
        8.verticalSpace,
        Text(label,
            style: context.textTheme.labelLarge!
                .copyWith(color: context.onBackgroundColor)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final days = remaining.inDays;
    final hours = remaining.inHours % 24;
    final minutes = remaining.inMinutes % 60;
    final seconds = remaining.inSeconds % 60;

    return ClipRRect(
      clipBehavior: Clip.hardEdge,
      borderRadius: BorderRadius.circular(22.r),
      child: Stack(
        children: [
          Positioned(
            top: -70.h,
            left: context.isEnglish ? -40.w : null,
            right: context.isEnglish ? null : -40.w,
            child: Container(
              height: 180.h,
              width: 180.w,
              decoration: BoxDecoration(
                color: context.primaryColor.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: -25.h,
            left: context.isEnglish ? 0 : -50.w,
            right: context.isEnglish ? -50.w : 0,
            child: Container(
              height: 60.h,
              width: 60.w,
              decoration: BoxDecoration(
                color: context.primaryColor.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: 10.h,
            left: context.isEnglish ? null : 60.w,
            right: context.isEnglish ? 60.w : null,
            child: Container(
              height: 60.h,
              width: 60.w,
              decoration: BoxDecoration(
                color: context.primaryColor.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Stack(
            children: [
              Container(
                padding: REdgeInsets.only(
                  left: 4,
                  right: 4,
                  top: 10,
                  bottom: 10,
                ),
                decoration: BoxDecoration(
                  color: context.primaryColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(16.r),
                ),
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
                        buildTimeBlock(days, AppStrings.days),
                        buildTimeBlock(hours, AppStrings.hours),
                        buildTimeBlock(minutes, AppStrings.minutes),
                        buildTimeBlock(seconds, AppStrings.seconds),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DaysToTheFinalsWidget extends StatelessWidget {
  const DaysToTheFinalsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(
        horizontal: AppConstants.horizontalScreensPadding,
      ),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return ResultBuilder<HomeEntity>(
            loading: () => ClipRRect(
              clipBehavior: Clip.hardEdge,
              borderRadius: BorderRadius.circular(22.r),
              child: Stack(
                children: [
                  Positioned(
                    top: -70.h,
                    left: context.isEnglish ? -40.w : null,
                    right: context.isEnglish ? null : -40.w,
                    child: Container(
                      height: 180.h,
                      width: 180.w,
                      decoration: BoxDecoration(
                        color: context.primaryColor.withOpacity(0.3),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -25.h,
                    left: context.isEnglish ? 0 : -50.w,
                    right: context.isEnglish ? -50.w : 0,
                    child: Container(
                      height: 60.h,
                      width: 60.w,
                      decoration: BoxDecoration(
                        color: context.primaryColor.withOpacity(0.3),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10.h,
                    left: context.isEnglish ? null : 60.w,
                    right: context.isEnglish ? 60.w : null,
                    child: Container(
                      height: 60.h,
                      width: 60.w,
                      decoration: BoxDecoration(
                        color: context.primaryColor.withOpacity(0.3),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Stack(
                    children: [
                      Container(
                        padding: REdgeInsets.only(
                          left: 4,
                          right: 4,
                          top: 10,
                          bottom: 10,
                        ),
                        decoration: BoxDecoration(
                          color: context.primaryColor.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(16.r),
                        ),
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
                                Column(
                                  children: [
                                    const CustomShimmerWidget(
                                      width: 60,
                                      height: 90,
                                      borderRadius: 12,
                                    ),
                                    8.verticalSpace,
                                    Text(
                                      AppStrings.days,
                                      style: context.textTheme.labelLarge!
                                          .copyWith(
                                              color: context.onBackgroundColor),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    const CustomShimmerWidget(
                                      width: 60,
                                      height: 90,
                                      borderRadius: 12,
                                    ),
                                    8.verticalSpace,
                                    Text(
                                      AppStrings.hours,
                                      style: context.textTheme.labelLarge!
                                          .copyWith(
                                              color: context.onBackgroundColor),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    const CustomShimmerWidget(
                                      width: 60,
                                      height: 90,
                                      borderRadius: 12,
                                    ),
                                    8.verticalSpace,
                                    Text(
                                      AppStrings.minutes,
                                      style: context.textTheme.labelLarge!
                                          .copyWith(
                                              color: context.onBackgroundColor),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    const CustomShimmerWidget(
                                      width: 60,
                                      height: 90,
                                      borderRadius: 12,
                                    ),
                                    8.verticalSpace,
                                    Text(
                                      AppStrings.seconds,
                                      style: context.textTheme.labelLarge!
                                          .copyWith(
                                              color: context.onBackgroundColor),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            success: (data) {
              return DaysToTheFinalsBody(
                targetDate: DateTime.parse(data.daysToTheFinals.remainingTime),
              );
            },
            result: state.result,
          );
        },
      ),
    );
  }
}
