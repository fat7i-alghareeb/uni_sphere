// 📦 Package imports:

// 📦 Package imports:

// 🌎 Project imports:
import 'dart:ui';

import 'package:provider/provider.dart';
import 'package:test/shared/extensions/context_extension.dart';

import '../../../../../shared/imports/imports.dart';
import '../../state/provider/nav_bar_provider.dart';

class RootNavbar extends StatelessWidget {
  const RootNavbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<NavBarProvider>(
      builder: (context, pro, _) => Row(
        // crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                padding: REdgeInsets.symmetric(horizontal: 5, vertical: 4),
                decoration: BoxDecoration(
                  color: context.onBackgroundColor.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(30.r),
                  // border: Border.all(color: Colors.white.withOpacity(0.3)),
                ),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildGlassButton(
                      icon: Icons.home,
                      isSelected: pro.selectedIndex == 0,
                      onTap: pro.changeSelected,
                      index: 0,
                      context: context,
                    ),
                    _buildGlassButton(
                      icon: Icons.search,
                      isSelected: pro.selectedIndex == 1,
                      onTap: pro.changeSelected,
                      index: 1,
                      context: context,
                    ),
                    _buildGlassButton(
                      icon: Icons.person,
                      isSelected: pro.selectedIndex == 2,
                      onTap: pro.changeSelected,
                      index: 2,
                      context: context,
                    ),
                    _buildGlassButton(
                      icon: Icons.settings,
                      isSelected: pro.selectedIndex == 3,
                      onTap: pro.changeSelected,
                      index: 3,
                      context: context,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGlassButton({
    required IconData icon,
    required bool isSelected,
    required void Function(int index) onTap,
    required int index,
    required BuildContext context,
  }) {
    return GestureDetector(
      onTap: () => onTap(index),
      child: Padding(
        padding: REdgeInsets.symmetric(horizontal: 1.2),
        child: ClipOval(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              width: 50.h,
              height: 50.w,
              decoration: BoxDecoration(
                color: context.onBackgroundColor
                    .withOpacity(isSelected ? 1 : 0.08),
                shape: BoxShape.circle,
                // border: Border.all(color: Colors.white.withOpacity(0.3)),
              ),
              child: Icon(
                icon,
                color: isSelected
                    ? context.backgroundColor
                    : context.onBackgroundColor,
                size: 24,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavBarItem({
    required String icon,
    required String label,
    required bool isSelected,
    required BuildContext context,
  }) {
    return const SizedBox();
  }
}
