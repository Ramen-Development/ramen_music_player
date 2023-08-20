import 'package:flutter/material.dart';
import 'package:ramen_music_player/core/screens/player.dart';
import 'package:ramen_music_player/core/song.dart';
import 'dart:io';

import '../services/indexer.dart';

class Playlist extends StatefulWidget {
  final String ref;
  const Playlist({Key? key, required this.ref}) : super(key: key);

  @override
  State<Playlist> createState() => _PlaylistState();
}

class _PlaylistState extends State<Playlist> {
  @override
  Widget build(BuildContext context) {
    Directory dir =
        Directory("/storage/emulated/0/Download/AvengedSevenfoldNightmareFLAC");

    return FutureBuilder<List<FileSystemEntity>>(
        future: dir.list(recursive: true, followLinks: false).toList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {

            List<Song> songList = loadSongsFromJson();

            //Init playlist with system files
            List<FileSystemEntity> songListSF = [] ;
            for (Song s in songList) {
              songListSF.add(s.toSystemFile());
            }
            initPlaylist(songListSF);

            return ListView.builder(
                itemCount: songList.length,
                itemBuilder: (context, index) {
                  Song song = songList.elementAt(index);
                  return Column(
                    children: [
                      ListTile(
                        onTap: () async => {setSong(index)},
                        leading: const Icon(
                          Icons.music_note,
                        ),
                        title: Text(song.name),
                        subtitle: Text(song.artist),
                      ),
                      const Divider(),
                    ],
                  );
                });
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else {
            return const CircularProgressIndicator();
          }
        });
  }

  void loadSongsFromDevice(){
    Directory dir =
        Directory("/storage/emulated/0/Download/AvengedSevenfoldNightmareFLAC");
    List<FileSystemEntity> songListSnap = dir.listSync(recursive: true, followLinks: false);
    List<FileSystemEntity> songList = [] ;
    for (FileSystemEntity s in songListSnap) {
      if (s.path.toLowerCase().endsWith(".mp3") ||
          s.path.toLowerCase().endsWith(".wav") ||
          s.path.toLowerCase().endsWith(".ogg")) {
        songList.add(s);
      }
    }
    saveSongsToJson(songList);
  }

  void saveSongsToJson(List<FileSystemEntity> songList) {
    List<Song> songs = [];
    for (FileSystemEntity s in songList) {
      songs.add(Song.fromSystemFile(s));
    }
    Indexer.writeJson(songs);
  }

  List<Song> loadSongsFromJson() {
    return Indexer.readJson();
    
  }
}
  