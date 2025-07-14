import '../../domain/entities/materials_entity.dart';

class MaterialsModel {
  final String url;
  final MaterialUrlType type;

  MaterialsModel({
    required this.url,
    required this.type,
  });

  factory MaterialsModel.fromMap(Map<String, dynamic> map) {
    return MaterialsModel(
      url: map['url'] as String,
      type: MaterialUrlType.values.firstWhere(
        (e) => e.name.toLowerCase() == (map['type'] as String).toLowerCase(),
        orElse: () => MaterialUrlType.other,
      ),
    );
  }
}
