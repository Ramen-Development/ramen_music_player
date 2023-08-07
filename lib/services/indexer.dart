import 'package:path_provider/path_provider.dart';
import 'package:ramen_music_player/core/song.dart';
import 'dart:io';
import 'dart:convert';

class Indexer {
  static Future<void> writeJson(List<Song> songs) async {
    String jsonString = '[';
    for (Song song in songs) {
      jsonString = jsonString + '\n' + jsonEncode(song.toJson());
    }
    jsonString = jsonString + '\n]';

    Directory? docDirectory;
    if (Platform.isAndroid) {
      docDirectory = await getExternalStorageDirectory();
    } 

    docDirectory ??= await getApplicationSupportDirectory();

    String docDirectoryFilePath = '${docDirectory.path}/json/songs.json';
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
}
