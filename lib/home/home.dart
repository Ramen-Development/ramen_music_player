import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ramen_music_player/core/player.dart';
import 'package:ramen_music_player/login-logout-services/authentication_service.dart';
import '../core/playlist.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    context.read<AuthenticationService>().sendVerificationEmail(context);
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('assets/images/ramendev.png'),
        title: const Text("Ramen Music Player"),
        actions: [
          IconButton(
            onPressed: () {
              context.read<AuthenticationService>().signOut();
            },
            icon: const Icon(Icons.logout),
          ),
          const IconButton(onPressed: null, icon: Icon(Icons.question_mark))
        ],
      ),
      body: const Playlist(),
      bottomNavigationBar: const Player(),
    );
  }
}
