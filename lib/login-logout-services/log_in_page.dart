// ignore_for_file: unnecessary_const

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ramen_music_player/login-logout-services/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ramen_music_player/login-logout-services/signup_page.dart';

class LogInPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LogInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0, bottom: 30.0),
              child: Center(
                child: Container(
                    width: 220,
                    height: 220,
                    /*decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(50.0)),*/
                    child: Image.asset('assets/images/ramendev.png')),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter valid email id as abc@gmail.com'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter secure password'),
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.only(top: 30, bottom: 30),
              ),
              onPressed: () {
                //TODO FORGOT PASSWORD SCREEN GOES HERE
              },
              child: const Text(
                'Forgot Password?',
                style: TextStyle(color: Colors.blue, fontSize: 15),
              ),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: () {
                  context.read<AuthenticationService>().signInEmail(
                      email: emailController.text.trim(),
                      password: passwordController.text.trim(),
                      c: context);
                },
                child: const Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 15, bottom: 15),
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                  onPressed: () {
                    context.read<AuthenticationService>().signInWithFacebook();
                  },
                  child: const Text.rich(
                    TextSpan(
                      children: <InlineSpan>[
                        WidgetSpan(
                            child: Icon(
                          Icons.facebook,
                          color: Colors.blue,
                          size: 28,
                        )),
                        TextSpan(text: 'Login with Facebook'),
                      ],
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  )),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                  onPressed: () {
                    context.read<AuthenticationService>().signInWithGoogle();
                  },
                  child: const Text.rich(
                    TextSpan(
                      children: <InlineSpan>[
                        WidgetSpan(
                            child: Icon(
                          FontAwesomeIcons.google,
                          color: Colors.red,
                          size: 22,
                        )),
                        TextSpan(text: ' Login with Google'),
                      ],
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  )),
            ),
            const SizedBox(
              height: 30,
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignUpPage()));
              },
              child: const Text(
                'New Ramen user? Create account!',
                style: TextStyle(
                    color: Color.fromARGB(143, 225, 172, 38), fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
