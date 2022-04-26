import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Playlist extends StatefulWidget {
  const Playlist({Key? key}) : super(key: key);

  @override
  State<Playlist> createState() => _PlaylistState();
}

class _PlaylistState extends State<Playlist> {
  final songsRef = FirebaseStorage.instance
      .refFromURL("gs://ramen-music-player.appspot.com/songs");
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ListResult>(
        future: songsRef.listAll(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            ListResult? songList = snapshot.data;
            return ListView.builder(
                itemCount: songList?.items.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        leading: const Icon(
                          Icons.music_note,
                        ),
                        title: Text(songList!.items[index].name),
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
