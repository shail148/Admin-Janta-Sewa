class MediaItem {
  final String id;
  final String title;
  final String? description;
  final String imageUrl;
  final DateTime date;

  MediaItem({
    required this.id,
    required this.title,
    this.description,
    required this.imageUrl,
    required this.date,
  });
}
