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
            List<FileSystemEntity> songListSnap = snapshot.data!;
            List<FileSystemEntity> songList = [];
            for (FileSystemEntity s in songListSnap) {
              if (s.path.toLowerCase().endsWith(".mp3") ||
                  s.path.toLowerCase().endsWith(".wav") ||
                  s.path.toLowerCase().endsWith(".ogg")) {
                songList.add(s);
              }
            }
            initPlaylist(songList);
            List<Song> songs = [];
            for (FileSystemEntity s in songList) {
              songs.add(Song.sf(s));
            }
            Indexer.writeJson(songs);
            return ListView.builder(
                itemCount: songList.length,
                itemBuilder: (context, index) {
                  Song song = Song.sf(songList.elementAt(index));
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
}
