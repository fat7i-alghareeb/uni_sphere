import 'package:test/common/constant/app_strings.dart';
import 'package:test/features/subjects/domain/entities/materials_entity.dart'
    as materials;
import 'package:test/features/subjects/services/materials_service.dart';
import 'package:test/shared/imports/imports.dart';
import 'package:test/shared/widgets/custom_network_image.dart';
import 'material_type_icon.dart';
import 'material_action_button.dart';

class MaterialItemCard extends StatelessWidget {
  const MaterialItemCard({
    super.key,
    required this.material,
  });

  final materials.MaterialEntity material;

  @override
  Widget build(BuildContext context) {
    final materialsService = MaterialsService();
    return FutureBuilder<bool>(
      future: materialsService.isFileActuallyDownloaded(material.url),
      builder: (context, snapshot) {
        final isDownloaded = snapshot.data ?? false;
        return Container(
          padding: REdgeInsets.all(16),
          decoration: BoxDecoration(
            color: context.cardColor,
            borderRadius: BorderRadius.circular(12.r),
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
              MaterialTypeIcon(type: material.type),
              16.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      MaterialsService().getCommonFileName(material.url),
                      style: context.textTheme.bodyMedium!
                          .withColor(context.onBackgroundColor),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (material.type == materials.MaterialUrlType.link)
                      Text(
                        material.url,
                        style: context.textTheme.bodySmall!.copyWith(
                          color: context.greyColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    if (material.type == materials.MaterialUrlType.image) ...[
                      8.verticalSpace,
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: CustomNetworkImage(
                          imageUrl: MaterialsService().getFullUrl(material.url),
                          width: 80,
                          height: 60,
                          fit: BoxFit.cover,
                          borderRadius: 8,
                        ),
                      ),
                    ],
                    if (isDownloaded) ...[
                      4.verticalSpace,
                      Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            size: 16.r,
                            color: Colors.blue,
                          ),
                          4.horizontalSpace,
                          Text(
                            'Available Offline',
                            style: context.textTheme.bodySmall!.copyWith(
                              color: Colors.blue,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              16.horizontalSpace,
              MaterialActionButton(
                  material: material, isDownloadedOverride: isDownloaded),
            ],
          ),
        );
      },
    );
  }
}
