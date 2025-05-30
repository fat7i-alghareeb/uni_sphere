import 'package:beamer/beamer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'
    show FontAwesomeIcons;

import '../../../../../shared/imports/imports.dart';
import '../../../../../shared/widgets/custom_icon.dart';
import '../../../../../shared/widgets/custom_network_image.dart';
import '../../../../../shared/widgets/custom_shimmer.dart';

class SubjectDetailsImage extends StatelessWidget {
  const SubjectDetailsImage({
    super.key,
    required this.imageUrl,
    required this.title,
  });
  final String imageUrl;
  final String title;

  static Widget buildImageShimmer(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      leadingWidth: AppConstants.horizontalScreensPadding + 60.r,
      collapsedHeight: 70.r,
      leading: SizedBox(
        child: Row(
          children: [
            AppConstants.horizontalScreensPadding.horizontalSpace,
            CustomIcon(
              iconPath: !context.isEnglish
                  ? FontAwesomeIcons.chevronRight
                  : FontAwesomeIcons.chevronLeft,
              onTap: () {
                context.beamBack();
              },
            ),
          ],
        ),
      ),
      expandedHeight: context.screenHeight * 0.35,
      pinned: true,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: Container(
          height: 22.h,
          decoration: BoxDecoration(
            color: context.backgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(22.r),
              topRight: Radius.circular(22.r),
            ),
          ),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            CustomShimmerWidget(
              height: double.infinity,
              width: double.infinity,
              borderRadius: 0,
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.5),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: REdgeInsets.only(left: 24, bottom: 40, right: 24),
                child: CustomShimmerWidget(
                  height: 32.h,
                  width: 200.w,
                  borderRadius: 8,
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: context.primaryColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,

      leadingWidth: AppConstants.horizontalScreensPadding + 60.r,
      // toolbarHeight: 80.r,
      collapsedHeight: 70.r,
      leading: SizedBox(
        child: Row(
          children: [
            AppConstants.horizontalScreensPadding.horizontalSpace,
            CustomIcon(
              iconPath: !context.isEnglish
                  ? FontAwesomeIcons.chevronRight
                  : FontAwesomeIcons.chevronLeft,
              onTap: () {
                context.beamBack();
              },
            ),
          ],
        ),
      ),
      expandedHeight: context.screenHeight * 0.35,
      pinned: true,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: Container(
          height: 22.h,
          decoration: BoxDecoration(
            color: context.backgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(22.r),
              topRight: Radius.circular(22.r),
            ),
          ),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            CustomNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.5),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: REdgeInsets.only(left: 24, bottom: 40, right: 24),
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: context.primaryColor,
    );
  }
}
