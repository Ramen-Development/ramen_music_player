import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ramen_music_player/core/screens/player.dart';
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
    askPermissions();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ramen Music Player"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.question_mark_rounded),
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

  void askPermissions() async {
    PermissionStatus storageStatus = await Permission.storage.request();
    if (storageStatus.isGranted) {
      // Permiso otorgado, puedes leer y escribir en el almacenamiento.
    } else if (storageStatus.isDenied) {
      // Permiso denegado por el usuario, puedes mostrar un mensaje.
    } else if (storageStatus.isPermanentlyDenied) {
      // Permiso denegado permanentemente, guía al usuario a la configuración de la app.
    }
  }
}
