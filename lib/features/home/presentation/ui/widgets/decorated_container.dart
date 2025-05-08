import 'package:flutter/services.dart';
import 'dart:math' as math;

import '../../../../../shared/imports/imports.dart';

class DecoratedContainer extends StatefulWidget {
  final Widget child;
  final double circleSize;
  final AlignmentGeometry alignment;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  final bool animate;

  const DecoratedContainer({
    super.key,
    required this.child,
    this.circleSize = 180,
    this.alignment = Alignment.center,
    this.onTap,
    this.padding = EdgeInsets.zero,
    this.animate = false,
  });

  @override
  State<DecoratedContainer> createState() => _DecoratedContainerState();
}

class _DecoratedContainerState extends State<DecoratedContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutSine,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: GestureDetector(
        onTap: () {
          HapticFeedback.heavyImpact();
          widget.onTap?.call();
        },
        child: ClipRRect(
          clipBehavior: Clip.hardEdge,
          borderRadius: BorderRadius.circular(22.r),
          child: Stack(
            children: [
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  final offset = widget.animate
                      ? math.sin(_animation.value * math.pi * 2) * 20
                      : 0;
                  return DecorativeCircle(
                    size: widget.circleSize.r,
                    top: -(widget.circleSize.r / 1.75).h + offset,
                    left: context.isEnglish ? -(widget.circleSize / 4).w : null,
                    right:
                        context.isEnglish ? null : -(widget.circleSize / 4).w,
                  );
                },
              ),
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  final offset = widget.animate
                      ? math.cos(_animation.value * math.pi * 2) * 20
                      : 0;
                  return DecorativeCircle(
                    size: widget.circleSize.r,
                    bottom: -(widget.circleSize / 1.25).h + offset,
                    left: context.isEnglish ? 0 : (50).w,
                    right: context.isEnglish ? (50).w : 0,
                  );
                },
              ),
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  final offset = widget.animate
                      ? math.sin(_animation.value * math.pi * 2) * 10
                      : 0;
                  return DecorativeCircle(
                    size: widget.circleSize / 3,
                    top: (widget.circleSize / 18).h + offset,
                    left: context.isEnglish ? null : (widget.circleSize / 4).w,
                    right: context.isEnglish ? (widget.circleSize / 4).w : null,
                  );
                },
              ),
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
                child: Align(
                  alignment: widget.alignment,
                  child: widget.child,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DecorativeCircle extends StatelessWidget {
  final double size;
  final double? top;
  final double? left;
  final double? right;
  final double? bottom;

  const DecorativeCircle({
    super.key,
    required this.size,
    this.top,
    this.left,
    this.right,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          color: context.primaryColor.withOpacity(0.25),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
