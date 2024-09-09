class MovieDBVideo {
  final String id;
  final String name;
  final String key;
  final String site;
  final String type;
  final bool official;
  final int size;

  MovieDBVideo({
    required this.id,
    required this.name,
    required this.key,
    required this.site,
    required this.type,
    required this.official,
    required this.size,
  });

  factory MovieDBVideo.fromJson(Map<String, dynamic> json) => MovieDBVideo(
        id: json['id'],
        name: json['name'],
        key: json['key'],
        site: json['site'],
        type: json['type'],
        official: json['official'] ?? false,
        size: json['size'] ?? 0,
      );
}
