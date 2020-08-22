import 'package:bonCoin/modals/user.dart';
import 'package:bonCoin/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null
        ? User(
            uid: user.uid,
            email: user.email,
            name: user.displayName,
            pictureUrl: user.photoUrl)
        : null;
  }

  // auth change stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

// Sign In with email & password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Register With email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

// Sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Login with google
  Future loginWithGoogle() async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn();
      GoogleSignInAccount account = await googleSignIn.signIn();
      if (account == null) return false;
      AuthResult result = await _auth.signInWithCredential(
        GoogleAuthProvider.getCredential(
            idToken: (await account.authentication).idToken,
            accessToken: (await account.authentication).accessToken),
      );
      FirebaseUser user = result.user;
      if (result == null) return false;
      var timekey = new DateTime.now();
      // await DataBase(uid: user.uid).addData(timekey.toString(), 'TestAdd');
      // await DataBase(uid: user.uid).updateUserData(
      //     timekey.toString(),
      //     'firstTitle ',
      //     'First description',
      //     'Rufisque Dakar',
      //     'BonCoin',
      //     'firstImage',
      //     'secondImage',
      //     'thirdImage');
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Login with Facebook
  Future loginWithFacebook() async {
    // final value = await facebookLogin.logIn(['email']);
    try {
      final fb = FacebookLogin();

// Log in
      final res = await fb.logIn(permissions: [
        FacebookPermission.publicProfile,
        FacebookPermission.email,
      ]);
      print(res.status);
      // FacebookLogin facebookLogin = FacebookLogin();
      // final result = await facebookLogin.logIn(['email']);
      // print(result.status);
      // FacebookAccessToken token = result.accessToken;
      // final graphResponse = await http.get(
      //     'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name&access_token=${token}');
      // print('le token est  ${result.accessToken}');

      // if (result.status == FacebookLoginStatus.loggedIn) {
      //   final credential =
      //       FacebookAuthProvider.getCredential(accessToken: token.token);
      //   _auth.signInWithCredential(credential);
      // }

// final profile = JSON.decode(graphResponse.body);
      // FacebookLogin facebookLogin = FacebookLogin();
      // FacebookLoginResult account = await facebookLogin.logIn(['email']);
      // print(account.toString());
      // if (account == null) return false;
      // if (account.status == FacebookLoginStatus.loggedIn) {
      //   final FacebookAccessToken accessToken = account.accessToken;
      //   print(accessToken.userId);ty()
      // AuthCredential credential = FacebookAuthProvider.getCredential(
      //     accessToken: account.accessToken.token);
      // AuthResult result = await _auth.signInWithCredential(credential);
      // FirebaseUser user = result.user;
      // // AuthResult result = await _auth.signInWithCredential(
      // //   FacebookAuthProvider.getCredential(
      // //       accessToken: account.accessToken.token),
      // // );
      // // FirebaseUser user = result.user;
      // // if (result == null) return false;
      // return _userFromFirebaseUser(user);
      // }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
