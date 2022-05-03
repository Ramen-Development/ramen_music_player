import 'package:ramen_music_player/login-logout-services/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordCopyController = TextEditingController();

  SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
             Padding(
              padding: const EdgeInsets.only(top: 15.0,right: 15.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: IconButton(onPressed: () {
                  Navigator.pop(context);
                },
                 icon: const Icon(Icons.keyboard_return_outlined))
                ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0, bottom: 30.0),
              child: Center(
                child: Container(
                  width: 420,
                  height: 120,
                  /*decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(50.0)),*/
                  child: const Text.rich(
                    TextSpan(
                      children: <InlineSpan>[
                        WidgetSpan(
                            child: Icon(
                          Icons.library_music_outlined,
                          color: Colors.grey,
                          size: 60,
                        )),
                        TextSpan(text: ' Sign Up in Ramen Music Player'),
                        WidgetSpan(
                            child: Icon(
                          Icons.library_music_outlined,
                          color: Colors.grey,
                          size: 60,
                        )),
                      ],
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 40, color: Colors.grey),
                  ),
                ),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextFormField(
                controller: usernameController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name',
                    hintText: 'Enter your username'),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
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
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: passwordCopyController,
                obscureText: true,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Confirm password',
                    hintText: 'Your password again'),
              ),
            ),
            Container(
              margin:
                  const EdgeInsets.only(left: 0, right: 0, top: 40, bottom: 0),
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: () {
                  SnackBar snackBar;
                  if (passwordController.text.trim() ==
                      passwordCopyController.text.trim()) {
                    context.read<AuthenticationService>().signUp(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                        username: usernameController.text.trim(),
                        c: context);
                    snackBar = SnackBar(
                      content: const Text("New account created"),
                      action: SnackBarAction(
                        label: "OK",
                        onPressed: () {
                          // Some code to undo the change.
                        },
                      ),
                    );
                    Navigator.pop(context);
                  } else {
                    snackBar = SnackBar(
                      content: const Text("Passwords do match"),
                      action: SnackBarAction(
                        label: "OK",
                        onPressed: () {
                          // Some code to undo the change.
                        },
                      ),
                    );
                  }
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                child: const Text.rich(
                  TextSpan(
                    children: <InlineSpan>[
                      WidgetSpan(
                          child: Icon(
                        Icons.headphones,
                        color: Colors.white,
                        size: 32,
                      )),
                      TextSpan(text: ' Sign Up'),
                    ],
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
