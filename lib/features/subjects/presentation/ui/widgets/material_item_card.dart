import 'package:test/shared/imports/imports.dart';
import '../../../domain/entities/materials_entity.dart' as materials;

class MaterialItemCard extends StatelessWidget {
  const MaterialItemCard({
    super.key,
    required this.material,
  });

  final materials.MaterialEntity material;

  static const double _borderRadius = 12;
  static const double _iconSize = 24;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: BorderRadius.circular(_borderRadius.r),
        boxShadow: [
          BoxShadow(
            color: context.primaryColor.withValues(alpha: 0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          _buildIcon(context),
          16.horizontalSpace,
          Expanded(
            child: Text(
              material.title,
              style: context.textTheme.bodyMedium!
                  .withColor(context.onBackgroundColor),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          16.horizontalSpace,
          Icon(
            Icons.download_rounded,
            color: context.primaryColor,
            size: _iconSize.r,
          ),
        ],
      ),
    );
  }

  Widget _buildIcon(BuildContext context) {
    IconData iconData;
    Color iconColor;

    switch (material.type) {
      case materials.MaterialType.pdf:
        iconData = Icons.picture_as_pdf_rounded;
        iconColor = Colors.red;
        break;
      case materials.MaterialType.video:
        iconData = Icons.video_library_rounded;
        iconColor = Colors.blue;
        break;
      case materials.MaterialType.image:
        iconData = Icons.image_rounded;
        iconColor = Colors.green;
        break;
      case materials.MaterialType.audio:
        iconData = Icons.audio_file_rounded;
        iconColor = Colors.orange;
        break;
    }

    return Container(
      padding: REdgeInsets.all(8),
      decoration: BoxDecoration(
        color: iconColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Icon(
        iconData,
        color: iconColor,
        size: _iconSize.r,
      ),
    );
  }
}
