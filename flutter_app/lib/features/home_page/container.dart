import 'package:bratur/features/home_page/actions.dart';
import 'package:bratur/features/home_page/presentation.dart';
import 'package:bratur/features/login/actions.dart';
import 'package:bratur/redux/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class HomePageContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) => !vm.loadingUser && vm.loggedIn
          ? HomePage(
              menuIndex: vm.menuItem,
              onMenuItemTapped: vm.onMenuItemTapped,
            )
          : Scaffold(body: Center(child: CircularProgressIndicator())),
      onInit: (store) {
        store.dispatch(getUserAction);
      },
      onWillChange: (previousViewModel, newViewModel) {
        if (!newViewModel.loadingUser && !newViewModel.loggedIn) {
          Navigator.pushReplacementNamed(context, '/login');
        }
      },
    );
  }
}

class _ViewModel {
  final bool loadingUser;
  final bool loggedIn;
  final int menuItem;
  final Function(int) onMenuItemTapped;

  _ViewModel({
    @required this.loadingUser,
    @required this.loggedIn,
    @required this.menuItem,
    @required this.onMenuItemTapped,
  });

  static _ViewModel fromStore(Store<AppState> store) => _ViewModel(
        loadingUser: store.state.loginState.loading,
        loggedIn: store.state.loginState.loggedInUser != null,
        menuItem: store.state.menuItem,
        onMenuItemTapped: (menuIndex) {
          store.dispatch(SelectMenuItemAction(menuIndex));
        },
      );
}
