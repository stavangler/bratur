import 'package:background_location/background_location.dart';
import 'package:bratur/features/map_page/actions.dart';
import 'package:bratur/redux/state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:redux/redux.dart';

void startSharingLocationMiddleware(
    Store<AppState> store, action, NextDispatcher next) {
  if (action is StartSharingLocationAction) {
    final document = Firestore.instance
        .collection('trips')
        .document(store.state.tripId)
        .collection('people')
        .document(store.state.userId);
    document.setData({'name': store.state.userName});

    BackgroundLocation.getLocationUpdates((location) {
      document.updateData(
        {
          'currentLocation': {
            'latitude': location.latitude,
            'longitude': location.longitude,
          }
        },
      );
    });
    BackgroundLocation.startLocationService();
  }

  next(action);
}
