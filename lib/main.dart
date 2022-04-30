import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ramen_music_player/login-logout-services/authentication_service.dart';
import 'package:ramen_music_player/home/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ramen_music_player/login-logout-services/sign_in_page.dart';
import 'firebase_options.dart';
import 'package:flutter/foundation.dart' show kIsWeb; 
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart'; 

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final aux = AuthenticationService(FirebaseAuth.instance);
  aux.signOut();
  // check if is running on Web
  if (kIsWeb) {
    // initialiaze the facebook javascript SDK
   FacebookAuth.i.webInitialize(
      appId: "528508542013087",
      cookie: true,
      xfbml: true,
      version: "v13.0",
    );
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<AuthenticationService>(
            create: (_) => AuthenticationService(FirebaseAuth.instance),
          ),
          StreamProvider(
            create: (context) =>
                context.read<AuthenticationService>().authStateChanges,
            initialData: null,
          )
        
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData.dark(),
          home: const AuthenticationWrapper(),
        ));
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    if (firebaseUser != null) {
      return const Home();
    }
    return SignInPage();
  }
}
