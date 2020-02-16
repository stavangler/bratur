import 'package:bratur/features/login/actions.dart';
import 'package:bratur/features/login/presentation.dart';
import 'package:bratur/redux/state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class LoginContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) => LoginPage(
        onLogin: vm.onLogin,
        loading: vm.loggingIn,
      ),
      onWillChange: (previousViewModel, newViewModel) {
        if (previousViewModel.user == null && newViewModel.user != null) {
          Navigator.pushReplacementNamed(context, "/");
        }
      },
    );
  }
}

class _ViewModel {
  final Function onLogin;
  final bool loggingIn;
  final FirebaseUser user;

  _ViewModel._(this.onLogin, this.loggingIn, this.user);

  static _ViewModel fromStore(Store<AppState> store) => _ViewModel._(
        () => store.dispatch(doLogin),
        store.state.loginState.loading,
        store.state.loginState.loggedInUser,
      );
}
