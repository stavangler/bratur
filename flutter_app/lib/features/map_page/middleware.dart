import 'package:background_location/background_location.dart';
import 'package:bratur/features/map_page/actions.dart';
import 'package:bratur/redux/state.dart';
import 'package:bratur/repository.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createMapMiddleware(
  FirestoreRepository firestoreRepository,
) {
  return [
    TypedMiddleware<AppState, StartSharingLocationAction>(
      _startSharingLocation(firestoreRepository),
    ),
    TypedMiddleware<AppState, StopSharingLocationAction>(
      _stopSharingLocation(firestoreRepository),
    ),
    TypedMiddleware<AppState, ConnectToUsersInMapAction>(
      _connectToUsersInMap(firestoreRepository),
    ),
  ];
}

void Function(
  Store<AppState> store,
  StartSharingLocationAction action,
  NextDispatcher next,
) _startSharingLocation(FirestoreRepository firestoreRepository) {
  return (store, action, next) {
    next(action);

    BackgroundLocation.getPermissions(onGranted: () {
      BackgroundLocation.getLocationUpdates((location) {
        firestoreRepository.saveCurrentLocation(
          store.state.tripId,
          store.state.loginState.loggedInUser.uid,
          store.state.loginState.loggedInUser.displayName,
          store.state.loginState.loggedInUser.photoUrl,
          location.latitude,
          location.longitude,
        );
      });
      BackgroundLocation.startLocationService();
    });
  };
}

void Function(
  Store<AppState> store,
  StopSharingLocationAction action,
  NextDispatcher next,
) _stopSharingLocation(FirestoreRepository firestoreRepository) {
  return (store, action, next) {
    next(action);

    BackgroundLocation.stopLocationService();
    firestoreRepository.deleteCurrentLocation(
      store.state.tripId,
      store.state.loginState.loggedInUser.uid,
    );
  };
}

void Function(
  Store<AppState> store,
  ConnectToUsersInMapAction action,
  NextDispatcher next,
) _connectToUsersInMap(FirestoreRepository firestoreRepository) {
  return (store, action, next) {
    next(action);

    firestoreRepository.connectToUsersInMap(store.state.tripId).handleError(() {
      store.dispatch(ErrorGettingUsers());
    }).listen((users) {
      store.dispatch(GotUsers(users));
    });
  };
}
