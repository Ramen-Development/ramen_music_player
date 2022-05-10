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

String ref = "songs/";

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    context.read<AuthenticationService>().sendVerificationEmail(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ramen Music Player"),
        actions: [
          IconButton(
            onPressed: () {
              context.read<AuthenticationService>().signOut();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: [
            Image.asset(
              "assets/images/ramendev.png",
              height: 150,
            ),
            const Divider(),
            const Text("Playlists:"),
            const Divider(),
            ListTile(
              title: const Text("All my songs"),
              onTap: () => setRef("songs/"),
            ),
            ListTile(
              title: const Text("Nectar by Joji"),
              onTap: () => setRef("nectar/"),
            ),
            ListTile(
              title: const Text("BIMWBIY by Aries"),
              onTap: () => setRef("believe/"),
            ),
            ListTile(
              title: const Text("Fear Inoculum by Tool"),
              onTap: () => setRef("tool/"),
            ),
            ListTile(
              title: const Text("Lost & Found by Jorja Smith"),
              onTap: () => setRef("jorja/"),
            ),
            ListTile(
              title: const Text("CARE FOR ME by Saba"),
              onTap: () => setRef("saba/"),
            ),
            ListTile(
              title: const Text("In Utero by Nirvana"),
              onTap: () => setRef("utero/"),
            ),
            ListTile(
              title: const Text("RATM"),
              onTap: () => setRef("ratm/"),
            ),
            ListTile(
              title: const Text("Blonde by Frank Ocean"),
              onTap: () => setRef("blonde/"),
            ),
          ],
        ),
      ),
      body: Playlist(
        ref: ref,
      ),
      bottomNavigationBar: const Player(),
    );
  }

  setRef(String arg) {
    player.stop();
    setState(() {
      ref = arg;
    });
  }
}
