import 'package:flutter/services.dart';

import '../../../../../shared/imports/imports.dart';

class DecoratedContainer extends StatelessWidget {
  final Widget child;

  const DecoratedContainer({
    super.key,
    required this.child,
    this.circleSize = 180,
    this.alignment = Alignment.center,
    this.onTap,
    this.padding = EdgeInsets.zero,
  });

  final double circleSize;
  final AlignmentGeometry alignment;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: GestureDetector(
        onTap: () {
          HapticFeedback.heavyImpact();
          onTap?.call();
        },
        child: ClipRRect(
          clipBehavior: Clip.hardEdge,
          borderRadius: BorderRadius.circular(22.r),
          child: Stack(
            children: [
              DecorativeCircle(
                size: circleSize.r,
                top: -(circleSize.r / 1.75).h,
                left: context.isEnglish ? -(circleSize / 4).w : null,
                right: context.isEnglish ? null : -(circleSize / 4).w,
              ),
              DecorativeCircle(
                size: circleSize.r,
                bottom: -(circleSize / 1.25).h,
                left: context.isEnglish ? 0 : (50).w,
                right: context.isEnglish ? (50).w : 0,
              ),
              DecorativeCircle(
                size: circleSize / 3,
                top: (circleSize / 18).h,
                left: context.isEnglish ? null : (circleSize / 4).w,
                right: context.isEnglish ? (circleSize / 4).w : null,
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
                  alignment: alignment,
                  child: child,
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
