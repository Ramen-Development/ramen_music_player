import 'package:flutter/material.dart';
import 'package:ramen_music_player/home/home.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // check if is running on Web
  if (kIsWeb) {}
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ramen Music Player',
      theme: ThemeData.dark(),
      home: const Home(),
    );
  }
}
