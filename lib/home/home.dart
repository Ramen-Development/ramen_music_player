import 'package:flutter/material.dart';
import 'package:ramen_music_player/core/player.dart';

import '../core/playlist.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('assets/images/ramendev.png'),
        title: const Text("Ramen Music Player"),
        actions: const [
          IconButton(
            onPressed: null,
            icon: Icon(Icons.logout),
          ),
          IconButton(onPressed: null, icon: Icon(Icons.question_mark))
        ],
      ),
      body: const Playlist(),
      bottomNavigationBar: const Player(),
    );
  }
}
