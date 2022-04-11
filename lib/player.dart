import 'package:flutter/material.dart';

class Player extends StatefulWidget {
  const Player({Key? key}) : super(key: key);

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Container(
        padding: const EdgeInsets.all(8),
        height: 120,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[_songInfo(), _playerButtons(), _playerConfig()],
        ),
      ),
    );
  }

  Row _songInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 50,
          height: 50,
          color: Colors.blueAccent,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [Text("Nombre cancion"), Text("Artista")],
          ),
        ),
        const IconButton(
          onPressed: null,
          icon: Icon(Icons.heart_broken_outlined),
        ),
      ],
    );
  }

  Column _playerButtons() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            IconButton(
              onPressed: null,
              icon: Icon(
                Icons.shuffle,
              ),
            ),
            IconButton(
              onPressed: null,
              icon: Icon(
                Icons.skip_previous,
              ),
            ),
            FloatingActionButton(
              onPressed: null,
              child: Icon(Icons.play_arrow),
            ),
            IconButton(
              onPressed: null,
              icon: Icon(
                Icons.skip_next,
              ),
            ),
            IconButton(
              onPressed: null,
              icon: Icon(
                Icons.repeat,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            Text("0:00"),
            Slider(
              value: 0,
              onChanged: null,
              max: 260,
            ),
            Text("4:20"),
          ],
        ),
      ],
    );
  }

  Row _playerConfig() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        IconButton(
          onPressed: null,
          icon: Icon(Icons.volume_up),
        ),
        Slider(
          value: 100,
          max: 100,
          onChanged: null,
        ),
      ],
    );
  }
}
