import 'package:bonCoin/home.dart';
import 'package:bonCoin/modals/user.dart';
import 'package:bonCoin/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // final _phoneController = TextEditingController();
  // final _passController = TextEditingController();
  final _codeController = TextEditingController();
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null
        ? User(
            uid: user.uid,
            email: user.email,
            name: user.displayName,
            pictureUrl: user.photoUrl,
            phone: user.phoneNumber)
        : null;
  }

  // auth change stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
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
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Login with phone number
  Future loginWithPhoneNumber(String mobile, BuildContext context) async {
    _auth.verifyPhoneNumber(
      phoneNumber: mobile,
      timeout: Duration(seconds: 60),
      verificationCompleted: (AuthCredential credential) {
        _auth.signInWithCredential(credential).then((AuthResult result) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Home(user: result.user),
            ),
          );
        }).catchError((e) {
          print(e);
        });
      },
      verificationFailed: (AuthException authExeption) {
        print(authExeption.message);
      },
      codeSent: (String verificationId, [int forceResendingToken]) {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
                  title: Text("Enter SMS Code"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextField(
                        controller: _codeController,
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("Done"),
                      textColor: Colors.white,
                      color: Colors.redAccent,
                      onPressed: () {
                        FirebaseAuth auth = FirebaseAuth.instance;

                        String smsCode = _codeController.text.trim();

                        AuthCredential _credential =
                            PhoneAuthProvider.getCredential(
                                verificationId: verificationId,
                                smsCode: smsCode);
                        auth
                            .signInWithCredential(_credential)
                            .then((AuthResult result) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Home(user: result.user)));
                        }).catchError((e) {
                          print(e);
                        });
                      },
                    )
                  ],
                ));
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        verificationId = verificationId;
        print(verificationId);
        print("Timout");
      },
    );
  }

  // Login with Facebook
//   Future loginWithFacebook() async {
//     // final value = await facebookLogin.logIn(['email']);
//     try {
//       final fb = FacebookLogin();

// // Log in
//       final res = await fb.logIn(permissions: [
//         FacebookPermission.publicProfile,
//         FacebookPermission.email,
//       ]);
//       print(res.status);
//       // FacebookLogin facebookLogin = FacebookLogin();
//       // final result = await facebookLogin.logIn(['email']);
//       // print(result.status);
//       // FacebookAccessToken token = result.accessToken;
//       // final graphResponse = await http.get(
//       //     'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name&access_token=${token}');
//       // print('le token est  ${result.accessToken}');

//       // if (result.status == FacebookLoginStatus.loggedIn) {
//       //   final credential =
//       //       FacebookAuthProvider.getCredential(accessToken: token.token);
//       //   _auth.signInWithCredential(credential);
//       // }

// // final profile = JSON.decode(graphResponse.body);
//       // FacebookLogin facebookLogin = FacebookLogin();
//       // FacebookLoginResult account = await facebookLogin.logIn(['email']);
//       // print(account.toString());
//       // if (account == null) return false;
//       // if (account.status == FacebookLoginStatus.loggedIn) {
//       //   final FacebookAccessToken accessToken = account.accessToken;
//       //   print(accessToken.userId);ty()
//       // AuthCredential credential = FacebookAuthProvider.getCredential(
//       //     accessToken: account.accessToken.token);
//       // AuthResult result = await _auth.signInWithCredential(credential);
//       // FirebaseUser user = result.user;
//       // // AuthResult result = await _auth.signInWithCredential(
//       // //   FacebookAuthProvider.getCredential(
//       // //       accessToken: account.accessToken.token),
//       // // );
//       // // FirebaseUser user = result.user;
//       // // if (result == null) return false;
//       // return _userFromFirebaseUser(user);
//       // }
//     } catch (e) {
//       print(e.toString());
//       return null;
//     }
//   }
}
