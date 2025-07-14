class MaterialEntity {
  final String url;
  final MaterialUrlType type;

  MaterialEntity({
    required this.url,
    required this.type,
  });
}

enum MaterialUrlType {
  pdf,
  image,
  document,
  excel,
  word,
  powerpoint,
  link,
  other,
}
