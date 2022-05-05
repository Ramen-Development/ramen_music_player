class Album {
  final String name;
  final String cover;

  Album._({required this.name, required this.cover});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album._(
      name: json['name'],
      cover: json['cover'],
    );
  }
}
