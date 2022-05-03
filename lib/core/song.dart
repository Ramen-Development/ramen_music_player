class Song {
  final String name;
  final String album;
  final String artist;
  final String file;

  Song._(
      {required this.name,
      required this.album,
      required this.artist,
      required this.file});

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song._(
      name: json['name'],
      album: json['album'],
      artist: json['artist'],
      file: json['file'],
    );
  }
}
