import 'package:bratur/features/home_page/actions.dart';
import 'package:bratur/features/home_page/presentation.dart';
import 'package:bratur/redux/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class HomePageContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) => HomePage(
        menuIndex: vm.menuItem,
        onMenuItemTapped: vm.onMenuItemTapped,
      ),
    );
  }
}

class _ViewModel {
  final int menuItem;
  final Function(int) onMenuItemTapped;

  _ViewModel({@required this.menuItem, @required this.onMenuItemTapped});

  static _ViewModel fromStore(Store<AppState> store) => _ViewModel(
        menuItem: store.state.menuItem,
        onMenuItemTapped: (menuIndex) {
          store.dispatch(SelectMenuItemAction(menuIndex));
        },
      );
}
