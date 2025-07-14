import 'package:test/common/constant/app_strings.dart';
import 'package:test/features/subjects/domain/entities/materials_entity.dart'
    as materials_entity;
import 'package:test/shared/imports/imports.dart';
import 'empty_materials_card.dart';
import 'material_item_card.dart';

class MaterialsListCard extends StatelessWidget {
  const MaterialsListCard({
    super.key,
    required this.materials,
  });

  final List<materials_entity.MaterialEntity> materials;

  @override
  Widget build(BuildContext context) {
    if (materials.isEmpty) {
      return const EmptyMaterialsCard();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.Materials,
          style: context.textTheme.titleMedium!.withColor(context.primaryColor),
        ),
        16.verticalSpace,
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: materials.length,
          separatorBuilder: (context, index) => 8.verticalSpace,
          itemBuilder: (context, index) {
            final material = materials[index];
            return MaterialItemCard(material: material);
          },
        ),
      ],
    );
  }
}
