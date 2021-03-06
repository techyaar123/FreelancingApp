import 'package:employmentappproject/src/screens/home.dart';
import 'package:employmentappproject/src/screens/verify.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum AppState { initial, authenticated, authenticating, unauthenticated }

class Auth extends ChangeNotifier {
  FirebaseAuth _auth;
  User _user;

  AppState _appState = AppState.initial;

  AppState get appState => _appState;
  User get user => _user;

  Auth.instance() : _auth = FirebaseAuth.instance {
    _auth.authStateChanges().listen((firebaseUser) {
      if (firebaseUser == null) {
        _appState = AppState.unauthenticated;
      } else {
        _user = firebaseUser;
        Future.delayed(Duration(seconds: 5));
        _appState = AppState.authenticated;
      }
      notifyListeners();
    });
  }
  Future<bool> login(
      String email, String password, BuildContext context) async {
    try {
      _appState = AppState.authenticating;
      notifyListeners();

      await _auth.signInWithEmailAndPassword(email: email, password: password);
      if (_appState == AppState.authenticated) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => HomeScreen()));
      }

      return true;
    } on FirebaseAuthException catch (error) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(error.toString()),
                SizedBox(
                  height: 10,
                ),
                TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('Close'))
              ],
            ),
          );
        },
      );
      return false;
    } catch (e) {
      _appState = AppState.unauthenticated;
      notifyListeners();
      return false;
    }
  }

  Future<bool> signUp(
      String email, String password, BuildContext context) async {
    try {
      _appState = AppState.authenticating;
      notifyListeners();

      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (_appState == AppState.authenticated) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => VerifyScreen()));
      }

      return true;
    } catch (e) {
      _appState = AppState.unauthenticated;
      notifyListeners();
      return false;
    }
  }

  Future logout() async {
    await _auth.signOut();
    _appState = AppState.unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }
}
