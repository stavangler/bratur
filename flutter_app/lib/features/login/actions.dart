import 'package:bratur/redux/state.dart';
import 'package:bratur/repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:redux/redux.dart';

part 'actions.freezed.dart';

final _googleSignIn = GoogleSignIn();
final _auth = FirebaseAuth.instance;
final _firestoreRepository = FirestoreRepository();

void getUserAction(Store<AppState> store) async {
  final user = await _auth.currentUser();
  _firestoreRepository.saveUser(
    store.state.tripId,
    user.email,
    user.displayName,
    user.photoUrl,
  );
  store.dispatch(LoggedIn(user));
}

void doLogin(Store<AppState> store) async {
  store.dispatch(LoginStarted());

  return new Future.sync(() async {
    final googleUser = await _googleSignIn.signIn();
    if (googleUser == null) {
      store.dispatch(LoginFailed());
      return;
    }

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.getCredential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );

    final user = (await _auth.signInWithCredential(credential)).user;

    await _firestoreRepository.saveUser(
      store.state.tripId,
      user.email,
      user.displayName,
      user.photoUrl,
    );

    store.dispatch(LoggedIn(user));
  }).catchError((error) {
    debugPrint('Failed logging in ${error.toString()}');
    store.dispatch(LoginFailed());
  });
}

class LoginStarted {
  @override
  String toString() {
    return 'LoginStarted{}';
  }
}

class LoginFailed {
  @override
  String toString() {
    return 'LoginFailed{}';
  }
}

@freezed
abstract class LoggedIn with _$LoggedIn {
  const factory LoggedIn(FirebaseUser user) = _LoggedIn;
}
