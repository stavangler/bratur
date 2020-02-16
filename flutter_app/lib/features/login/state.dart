import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

@immutable
class LoginState {
  final FirebaseUser loggedInUser;
  final bool loading;

  LoginState._({this.loggedInUser, this.loading});

  factory LoginState.initial() {
    return LoginState._(loggedInUser: null, loading: true);
  }

  LoginState copyWith({FirebaseUser loggedInUser, bool loading}) {
    return LoginState._(
      loggedInUser: loggedInUser ?? this.loggedInUser,
      loading: loading ?? this.loading,
    );
  }
}
