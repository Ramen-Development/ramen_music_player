import 'package:path_provider/path_provider.dart';
import 'package:ramen_music_player/core/song.dart';
import 'dart:io';
import 'dart:convert';

class Indexer {
  static void writeJson(List<Song> songs) async {
    String jsonString = '';
    for (Song song in songs) {
      jsonString = jsonString + jsonEncode(song.toJson()) + '\n';
    }

    Directory? docDirectory;
    Platform.isAndroid ?
      docDirectory = await getExternalStorageDirectory():
      docDirectory = await getApplicationSupportDirectory();


    String docDirectoryFilePath = '${docDirectory!.path}/json/songs.json';
    // Create the directory if it doesn't exist
    if (!await Directory(docDirectory.path + '/json').exists()) {
      await Directory(docDirectory.path + '/json').create(recursive: true);
    }

    File songsFile = File(docDirectoryFilePath);
    if (!await songsFile.exists()) {
      await songsFile.create();
    }
    await songsFile.writeAsString(jsonString);
  }

  static Future<List<Song>> readJson() async {
    Directory? docDirectory;
    Platform.isAndroid ?
      docDirectory = await getExternalStorageDirectory():
      docDirectory = await getApplicationSupportDirectory();

    String docDirectoryFilePath = '${docDirectory!.path}/json/songs.json';
    // Create the directory if it doesn't exist
    if (!await Directory(docDirectory.path + '/json').exists()) {
      await Directory(docDirectory.path + '/json').create(recursive: true);
    }

    File songsFile = File(docDirectoryFilePath);
    if (!await songsFile.exists()) {
      await songsFile.create();
      //Load songs from device
      //Save it into JSON
    }

    String jsonString = await songsFile.readAsString();
    List<String> stringList = jsonString.split('\n');

    List<dynamic> jsonList = [];
    for (String s in stringList) {
      if (s.isNotEmpty) {
        jsonList.add(jsonDecode(s));
      }
    }
    
    List<Song> songs = [];
    for (dynamic json in jsonList) {
      songs.add(Song.fromJson(json));
    }
    return songs;
  }

}