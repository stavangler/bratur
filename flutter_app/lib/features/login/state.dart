import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

@freezed
abstract class LoginState with _$LoginState {
  const factory LoginState(
    @nullable FirebaseUser loggedInUser,
    bool loading,
  ) = _LoginState;

  factory LoginState.initial() => LoginState(null, true);
}
