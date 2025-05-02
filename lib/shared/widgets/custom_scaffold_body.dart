import 'package:flutter/material.dart';
import 'package:test/shared/extensions/context_extension.dart';

import '../../gen/assets.gen.dart';

class CustomScaffoldBody extends StatelessWidget {
  const CustomScaffoldBody({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Assets.images.pattern2.keyName),
          repeat: ImageRepeat.repeat,
          colorFilter: ColorFilter.mode(
            context.primaryColor.withOpacity(0.3),
            BlendMode.srcIn,
          ),
        ),
      ),
      child: child,
    );
  }
}
