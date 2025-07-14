import 'package:test/features/subjects/domain/entities/materials_entity.dart'
    as materials;
import 'package:test/features/subjects/services/materials_service.dart';
import 'package:test/shared/imports/imports.dart';

class MaterialTypeIcon extends StatelessWidget {
  const MaterialTypeIcon({
    super.key,
    required this.type,
  });

  final materials.MaterialUrlType type;

  @override
  Widget build(BuildContext context) {
    final materialsService = MaterialsService();
    final iconData = materialsService.getMaterialIcon(type);
    final iconColor = materialsService.getMaterialIconColor(type);

    return Container(
      padding: REdgeInsets.all(8),
      decoration: BoxDecoration(
        color: iconColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Icon(
        iconData,
        color: iconColor,
        size: 24.r,
      ),
    );
  }
}
