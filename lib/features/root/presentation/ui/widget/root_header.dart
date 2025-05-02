// 🐦 Flutter imports:

// 🌎 Project imports:
import 'package:test/core/styles/app_text_theme.dart';

import '../../../../../shared/imports/imports.dart';
import '../../../../../shared/extensions/context_extension.dart';
import '../../../../../shared/utils/helper/get_colored_svg_picture.dart';

class RootHeader extends StatelessWidget {
  const RootHeader({
    super.key,
    this.userName = "Fathi Alghareeb",
    this.unreadNotifications = 10,
    required this.scaffoldKey,
  });

  final String userName;
  final int unreadNotifications;
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.only(
        left: AppConstants.horizontalScreensPadding / 2,
        right: AppConstants.horizontalScreensPadding / 2,
        top: AppConstants.headerPadding,
      ),
      child: Row(
        children: [
          // Left Side: Avatar and Name
          Expanded(
            child: Row(
              children: [
                // Avatar with modern design
                getColoredSvgPicture(
                  assetName: Assets.images.avatarBoy,
                  width: 40,
                  height: 40,
                ),

                12.horizontalSpace,
                // User Info
                Text(
                  userName,
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          // Right Side: Icons
          Row(
            children: [
              // Notification Icon
              Stack(
                clipBehavior: Clip.none,
                children: [
                  _buildIcon(
                    context: context,
                    icon: Assets.icons.notification,
                    onTap: () {},
                  ),
                  if (unreadNotifications > 0)
                    Positioned(
                      right: -4.r,
                      top: -4.r,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        constraints: BoxConstraints(
                          minWidth: 8.r,
                          minHeight: 8.r,
                          maxWidth: 15.r,
                          maxHeight: 15.r,
                        ),
                        child: Center(
                          child: FittedBox(
                            child: Text(
                              unreadNotifications.toString(),
                              style: context.textTheme.labelSmall?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              // Drawer Icon
              16.horizontalSpace,
              _buildIcon(
                context: context,
                icon: Assets.icons.drawer,
                onTap: () => scaffoldKey.currentState?.openEndDrawer(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIcon({
    required BuildContext context,
    required String icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: getColoredSvgPicture(
        assetName: icon,
        width: 22,
        height: 22,
        color: context.onBackgroundColor,
      ),
    );
  }
}
