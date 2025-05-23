  class MaterialEntity {
    final String title;
    final String fileUrl;
    final MaterialType type;
    MaterialEntity({
      required this.title,
      required this.fileUrl,
      required this.type,
    });
  }


enum MaterialType {
  pdf,
  video,
  image,
  audio,
}
