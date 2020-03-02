import 'package:background_location/background_location.dart';
import 'package:bratur/features/map_page/actions.dart';
import 'package:bratur/redux/state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:redux/redux.dart';

void startSharingLocationMiddleware(
    Store<AppState> store, action, NextDispatcher next) {
  final document = Firestore.instance
      .collection('trips')
      .document(store.state.tripId)
      .collection('people')
      .document(store.state.userId);

  if (action is StartSharingLocationAction) {
    BackgroundLocation.getPermissions(onGranted: () {
      BackgroundLocation.getLocationUpdates((location) {
        document.setData(
          {
            'name': store.state.userName,
            'currentLocation': {
              'latitude': location.latitude,
              'longitude': location.longitude,
              'latestUpdate': Timestamp.now(),
            }
          },
          merge: true,
        );
      });
      BackgroundLocation.startLocationService();
    });
  } else if (action is StopSharingLocationAction) {
    BackgroundLocation.stopLocationService();

    document.setData({'currentLocation': FieldValue.delete()}, merge: true);
  }

  next(action);
}