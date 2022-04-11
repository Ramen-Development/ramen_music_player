import 'package:flutter/material.dart';
import 'package:ramen_music_player/player.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      bottomNavigationBar: Player(),
    );
  }
}
