import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final FirebaseAuth firebaseAuth;
  
  FirebaseAuth auth = FirebaseAuth.instance;

  
  AuthenticationService(this.firebaseAuth);
  Stream<User?> get authStateChanges => firebaseAuth.idTokenChanges();


  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  Future<String?> signIn({required String email, required String password}) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return "Signed in";
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
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