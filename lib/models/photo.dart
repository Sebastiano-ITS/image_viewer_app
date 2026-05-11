class Photo {
  final int id;
  final String name;
  final String path;
  final int size;
  final String mimeType;
  final DateTime createdAt;

  Photo({
    required this.id,
    required this.name,
    required this.path,
    required this.size,
    required this.mimeType,
    required this.createdAt,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'],
      name: json['name'],
      path: json['path'],
      size: json['size'],
      mimeType: json['mime_type'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
