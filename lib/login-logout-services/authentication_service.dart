import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AuthenticationService {
  final FirebaseAuth firebaseAuth;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore store = FirebaseFirestore.instance;
  AuthenticationService(this.firebaseAuth);

  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _userGoogle;
  GoogleSignInAccount get userGoogle => _userGoogle!;

  Stream<User?> get authStateChanges => firebaseAuth.idTokenChanges();


  Future<void> signOut() async {
    await googleSignIn.disconnect();
    await FacebookAuth.i.logOut();
    await firebaseAuth.signOut();
  }

  Future<String?> signInEmail({required String email, required String password,required BuildContext c}) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      sendVerificationEmail(c);
      return "Signed in";
    } on FirebaseAuthException catch (e) {
      popSnackBar(c, e.message.toString(), "OK");
      return e.message;
    }
    
  }

  

Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final googleUser = await GoogleSignIn().signIn();
  _userGoogle=googleUser;

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  return await firebaseAuth.signInWithCredential(credential);
}

Future<UserCredential> signInWithFacebook() async {
  // Trigger the sign-in flow
  final LoginResult loginResult = await FacebookAuth.instance.login();

  // Create a credential from the access token
  final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);

  // Once signed in, return the UserCredential
  return firebaseAuth.signInWithCredential(facebookAuthCredential);
}

  Future<void> sendVerificationEmail(BuildContext context) async{
    final isEmailVerified = firebaseAuth.currentUser!.emailVerified;
    if(!isEmailVerified)
    {
      try{
        await firebaseAuth.currentUser?.sendEmailVerification();
        popSnackBar(context, "Verify your email!", "OK");
      }catch(e){
        popSnackBar(context, e.toString(), "OK");
      }
    }
  }

  void popSnackBar(BuildContext context,String content,String label)
  {
    final snackBar = SnackBar(
      content: Text(content),
      action: SnackBarAction(
        label: label,
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<String?> signUp({required String email, required String password,required String username,required BuildContext c}) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      final uid = auth.currentUser?.uid;
      store.collection("Users").add(
        {
          "name" : username,
          "email" : email,
          "uid" : uid,
        }
      );
      return "Signed up";
    } on FirebaseAuthException catch (e) {
      popSnackBar(c, e.message.toString(), "OK");
      return e.message.toString();
      
    }
  }
}