import 'package:ramen_music_player/login-logout-services/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            controller: emailController,
            decoration: const InputDecoration(
              labelText: "Email",
            ),
          ),
          TextField(
            controller: passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: "Password",
            ),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<AuthenticationService>().signInEmail(
                    email: emailController.text.trim(),
                    password: passwordController.text.trim(),
                  );
            },
            child: const Text("Sign in"),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<AuthenticationService>().signInWithGoogle();
            },
            child: const Text("Sign in with Google"),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<AuthenticationService>().signInWithFacebook();
            },
            child: const Text("Sign in with Facebook"),
          )
        ],
      ),
    );
  }
}
