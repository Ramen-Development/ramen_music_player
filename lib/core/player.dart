import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class Player extends StatefulWidget {
  const Player({Key? key}) : super(key: key);

  @override
  State<Player> createState() => _PlayerState();
}

final player = AudioPlayer();

class _PlayerState extends State<Player> {
  @override
  void initState() {
    super.initState();
    player
        .setAudioSource(ConcatenatingAudioSource(children: [
      AudioSource.uri(Uri.parse(
          "https://firebasestorage.googleapis.com/v0/b/ramen-music-player.appspot.com/o/songs%2FKevin%20MacLeod%20-%20Impact%20Prelude.mp3?alt=media&token=36f60e83-350a-46eb-a650-3ffa6fc0c597")),
      AudioSource.uri(Uri.parse(
          "https://firebasestorage.googleapis.com/v0/b/ramen-music-player.appspot.com/o/songs%2FKevin%20MacLeod%20-%20Impact%20Andante.mp3?alt=media&token=5f87219e-7459-4ea9-9007-70a3ea84d5f4")),
    ]))
        .catchError((error) {
      // catch load errors: 404, invalid url ...
      throw ("An error occured $error");
    });
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

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
          children: [
            StreamBuilder<bool>(
              stream: player.shuffleModeEnabledStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return _shuffleButton(context, snapshot.data ?? false);
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
            StreamBuilder<SequenceState?>(
              stream: player.sequenceStateStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return _previousButton();
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
            StreamBuilder<PlayerState>(
                stream: player.playerStateStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return _playerButton(snapshot.data!);
                  } else {
                    return const CircularProgressIndicator();
                  }
                }),
            StreamBuilder<SequenceState?>(
              stream: player.sequenceStateStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return _nextButton();
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
            StreamBuilder<LoopMode>(
              stream: player.loopModeStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return _repeatButton(context, snapshot.data ?? LoopMode.off);
                } else {
                  return const CircularProgressIndicator();
                }
              },
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

  Widget _playerButton(PlayerState playerState) {
    // 1
    final processingState = playerState.processingState;
    if (processingState == ProcessingState.loading ||
        processingState == ProcessingState.buffering) {
      return const CircularProgressIndicator();
    } else {
      if (player.playing != true) {
        // 3
        return FloatingActionButton(
          child: const Icon(Icons.play_arrow),
          onPressed: player.play,
        );
      } else {
        // 4
        return FloatingActionButton(
          child: const Icon(Icons.pause),
          onPressed: player.pause,
        );
      }
    }
  }

  Widget _shuffleButton(BuildContext context, bool isEnabled) {
    return IconButton(
      icon: isEnabled
          ? Icon(Icons.shuffle, color: Theme.of(context).colorScheme.secondary)
          : const Icon(Icons.shuffle),
      onPressed: () async {
        final enable = !isEnabled;
        if (enable) {
          await player.shuffle();
        }
        await player.setShuffleModeEnabled(enable);
      },
    );
  }

  Widget _previousButton() {
    return IconButton(
      icon: const Icon(Icons.skip_previous),
      onPressed: player.hasPrevious ? player.seekToPrevious : null,
    );
  }

  Widget _nextButton() {
    return IconButton(
      icon: const Icon(Icons.skip_next),
      onPressed: player.hasNext ? player.seekToNext : null,
    );
  }

  Widget _repeatButton(BuildContext context, LoopMode loopMode) {
    final icons = [
      const Icon(Icons.repeat),
      Icon(Icons.repeat, color: Theme.of(context).colorScheme.secondary),
      Icon(Icons.repeat_one, color: Theme.of(context).colorScheme.secondary),
    ];
    const cycleModes = [
      LoopMode.off,
      LoopMode.all,
      LoopMode.one,
    ];
    final index = cycleModes.indexOf(loopMode);
    return IconButton(
      icon: icons[index],
      onPressed: () {
        player.setLoopMode(
            cycleModes[(cycleModes.indexOf(loopMode) + 1) % cycleModes.length]);
      },
    );
  }
}

setSong(uri) async {
  await player.setAudioSource(ProgressiveAudioSource(Uri.parse(uri)));
}
