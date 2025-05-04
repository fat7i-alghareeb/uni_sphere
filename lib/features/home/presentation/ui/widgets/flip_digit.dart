
import '../../../../../core/styles/colors.dart';
import '../../../../../shared/imports/imports.dart';

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