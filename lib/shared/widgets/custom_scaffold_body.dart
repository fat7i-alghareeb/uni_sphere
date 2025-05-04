import 'package:flutter/material.dart';
import '../extensions/context_extension.dart';

import '../../gen/assets.gen.dart';

class CustomScaffoldBody extends StatelessWidget {
  const CustomScaffoldBody({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Assets.images.patternNew.keyName),
          repeat: ImageRepeat.repeat,
          colorFilter: ColorFilter.mode(
            context.onBackgroundColor.withOpacity(0.05),
            BlendMode.srcIn,
          ),
        ),
      ),
      child: child,
    );
  }
}
