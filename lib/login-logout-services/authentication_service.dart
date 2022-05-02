import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class AuthenticationService {
  final FirebaseAuth firebaseAuth;
  FirebaseAuth auth = FirebaseAuth.instance;
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

  Future<String?> signInEmail({required String email, required String password}) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return "Signed in";
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
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

  Future<String?> signUp({required String email, required String password}) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return "Signed up";
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }
}