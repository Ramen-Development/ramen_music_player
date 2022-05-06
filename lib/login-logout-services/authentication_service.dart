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

  Stream<User?> get authStateChanges => firebaseAuth.authStateChanges();

  String getName(){
    final uid = auth.currentUser?.uid;
    final query = store.collection("Users").where("uid", isEqualTo: uid).get().then((snapshot) => {
      snapshot.docs[0]
    });

    return query.toString();
    
  }

  Future<void> signOut() async {
    try {
      await googleSignIn.disconnect();
    } catch (a) {
      try{
        await FacebookAuth.i.logOut();
      }catch(a){}
      
    }
    await firebaseAuth.signOut();  
    return;
    
  }

  Future<String?> signInEmail(
      {required String email,
      required String password,
      required BuildContext c}) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      sendVerificationEmail(c);
      return "Signed in";
    } on FirebaseAuthException catch (e) {
      popSnackBar(c, e.message.toString(), "OK");
      return e.message;
    }
  }

    Future<String?> forgotPassword(
      {required String email,
      required BuildContext c}) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      popSnackBar(c, "Email sended", "OK");
      return "Sended";
    } on FirebaseAuthException catch (e) {
      popSnackBar(c, e.message.toString(), "OK");
      return e.message;
    }
  }

  Future<void> signInWithGoogle() async {
    // Trigger the authentication flow
    final googleUser = await GoogleSignIn().signIn();
    _userGoogle = googleUser;

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    await firebaseAuth.signInWithCredential(credential);

    final uid = auth.currentUser?.uid;
    try{
      final doc = store.collection("Users").doc(uid).get();
    }catch(e){
      store.collection("Users").doc(uid).set(
            {
              "name": _userGoogle!.displayName,
              "email": _userGoogle!.email,
              "uid": uid,
          });
    }
  }

  Future<void> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    final userFB = await FacebookAuth.instance.getUserData();

    // Once signed in, return the UserCredential
    await firebaseAuth.signInWithCredential(facebookAuthCredential);

    final uid = auth.currentUser?.uid;
    try{
      final doc = store.collection("Users").doc(uid).get();
    }catch(e){
      store.collection("Users").doc(uid).set(
            {
              "name": userFB['name'],
              "email": userFB['email'],
              "uid": uid,
          });
    }
    
  }

  Future<void> sendVerificationEmail(BuildContext context) async {
    final isEmailVerified = firebaseAuth.currentUser!.emailVerified;
    if (!isEmailVerified) {
      try {
        await firebaseAuth.currentUser?.sendEmailVerification();
        popSnackBar(context, "Verify your email!", "OK");
      } catch (e) {
        popSnackBar(context, e.toString(), "OK");
      }
    }
  }
  

  void popSnackBar(BuildContext context, String content, String label) {
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

  Future<String?> signUp(
      {required String email,
      required String password,
      required String username,
      required BuildContext c}) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      final uid = auth.currentUser?.uid;
      store.collection("Users").doc(uid).set({
        "name": username,
        "email": email,
        "uid": uid,
      });
      return "Signed up";
    } on FirebaseAuthException catch (e) {
      popSnackBar(c, e.message.toString(), "OK");
      return e.message.toString();
    }
  }


}
