import 'package:bratur/features/map_page/actions.dart';
import 'package:bratur/redux/state.dart';
import 'package:bratur/repository.dart';
import 'package:bratur/utils/epic_with_type.dart';
import 'package:geolocation/geolocation.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

Epic<AppState> createMapEpics(FirestoreRepository firestoreRepository) {
  return combineEpics<AppState>([
    _startSharingLocation(firestoreRepository),
    TypedEpic<AppState, ConnectToUsersInMapAction>(
      _connectToUsersInMap(firestoreRepository),
    ),
  ]);
}

Epic<AppState> _startSharingLocation(FirestoreRepository firestoreRepository) {
  return (actions, store) {
    return actions.whereType<StartSharingLocationAction>().switchMap(
          (action) => Geolocation.locationUpdates(
            accuracy: LocationAccuracy.block,
            displacementFilter: 50,
            inBackground: true,
            permission: LocationPermission(
              android: LocationPermissionAndroid.fine,
              ios: LocationPermissionIOS.always,
            ),
          )
              .asyncMap(
                  (locationSnapshot) => firestoreRepository.saveCurrentLocation(
                        store.state.tripId,
                        store.state.loginState.loggedInUser.email,
                        locationSnapshot.location.latitude,
                        locationSnapshot.location.longitude,
                      ))
              .takeUntil(actions.whereType<StopSharingLocationAction>())
              .doOnCancel(() => firestoreRepository.deleteCurrentLocation(
                    store.state.tripId,
                    store.state.loginState.loggedInUser.email,
                  )),
        );
  };
}

EpicWithActionType<AppState, ConnectToUsersInMapAction> _connectToUsersInMap(
  FirestoreRepository firestoreRepository,
) {
  return (actions, store) {
    return actions
        .switchMap(
      (action) => firestoreRepository
          .connectToUsersInMap(store.state.tripId)
          .map<dynamic>((users) => GotUsers(users)),
    )
        .doOnError((error, stackTrace) {
      print(error);
      print(stackTrace);
    }).onErrorReturn(ErrorGettingUsers());
  };
}
