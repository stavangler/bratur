import 'package:bratur/features/map_page/actions.dart';
import 'package:bratur/features/map_page/presentation.dart';
import 'package:bratur/redux/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class MapContainer extends StatelessWidget {
  MapContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) => MapPage(
        isSharingLocation: vm.isSharingLocation,
        onShareLocationTapped: vm.onShareLocationTapped,
        tripId: vm.tripId,
      ),
    );
  }
}

class _ViewModel {
  final bool isSharingLocation;
  final Function onShareLocationTapped;
  final String tripId;

  _ViewModel({
    @required this.isSharingLocation,
    @required this.onShareLocationTapped,
    @required this.tripId,
  });

  static _ViewModel fromStore(Store<AppState> store) => _ViewModel(
        isSharingLocation: store.state.mapState.isSharingLocation,
        onShareLocationTapped: () =>
            store.dispatch(StartSharingLocationAction()),
        tripId: store.state.tripId,
      );
}
