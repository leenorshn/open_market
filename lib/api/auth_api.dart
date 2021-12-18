import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthApi {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Stream<User?> onAuthChanged() {
    User? user;
    firebaseAuth.userChanges().listen((event) {
      print(event!.uid);
    });

    return firebaseAuth.userChanges();
  }

  void login(String email, String pass) async {
    await firebaseAuth.signInWithEmailAndPassword(email: email, password: pass);
  }

  void withGoogle() async {
    GoogleSignInAccount? account = await GoogleSignIn().signIn();
    GoogleSignInAuthentication? authentication = await account!.authentication;

    var credential = GoogleAuthProvider.credential(
      accessToken: authentication.accessToken,
      idToken: authentication.idToken,
    );
    await firebaseAuth.signInWithCredential(credential);
  }

  void register(String email, String pass) async {
    await firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: pass);
  }

  void logout() async {
    await firebaseAuth.signOut();
  }
}
