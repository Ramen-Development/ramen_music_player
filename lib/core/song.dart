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

  Song.sf(FileSystemEntity sf) {
    this.name = sf.toString().split("/").last;
    this.album = "";
    this.artist = "";
    this.file = sf.path;
  }
}
