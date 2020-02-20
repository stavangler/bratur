import 'package:bratur/features/map_page/actions.dart';
import 'package:bratur/features/map_page/presentation.dart';
import 'package:bratur/models/user.dart';
import 'package:bratur/redux/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class MapContainer extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  MapContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      onInit: (store) {
        store.dispatch(ConnectToUsersInMapAction());
      },
      onWillChange: (previousViewModel, newViewModel) {
        if (newViewModel.errorGettingUsers &&
            !previousViewModel.errorGettingUsers) {
          _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text('Failed to find any people 🦗️'),
          ));
        }
      },
      converter: _ViewModel.fromStore,
      builder: (context, vm) => MapPage(
        isSharingLocation: vm.isSharingLocation,
        onShareLocationTapped: vm.onShareLocationTapped,
        tripId: vm.tripId,
        users: vm.users,
        scaffoldKey: _scaffoldKey,
      ),
    );
  }
}

class _ViewModel {
  final bool isSharingLocation;
  final Function onShareLocationTapped;
  final String tripId;
  final List<User> users;
  final bool errorGettingUsers;

  _ViewModel({
    @required this.isSharingLocation,
    @required this.onShareLocationTapped,
    @required this.tripId,
    @required this.users,
    @required this.errorGettingUsers,
  });

  static _ViewModel fromStore(Store<AppState> store) => _ViewModel(
        isSharingLocation: store.state.mapState.isSharingLocation,
        onShareLocationTapped: () => store.dispatch(
            store.state.mapState.isSharingLocation
                ? StopSharingLocationAction()
                : StartSharingLocationAction()),
        users: store.state.mapState.users,
        errorGettingUsers: store.state.mapState.errorGettingUsers,
        tripId: store.state.tripId,
      );
}
