import 'dart:io';

class Song {
  late String name;
  late String album;
  late String artist;
  late String file;

  Song(
      {required this.name,
      required this.album,
      required this.artist,
      required this.file});

  Song.fromSystemFile(FileSystemEntity sf) {
    name = sf.toString().split("/").last;
    album = "";
    artist = "";
    file = sf.path;
  }

  FileSystemEntity toSystemFile() {
    return File(file);
  }

  Song.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        album = json['album'],
        artist = json['artist'],
        file = json['file'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'album': album,
        'artist': artist,
        'file': file,
      };
}
