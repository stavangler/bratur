import 'package:bratur/features/agenda/actions.dart';
import 'package:bratur/redux/state.dart';
import 'package:bratur/repository.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createAgendaMiddleware(
  FirestoreRepository firestoreRepository,
) {
  return [
    TypedMiddleware<AppState, ConnectToAgendaEventsAction>(
      _connectToAgendaEvents(firestoreRepository),
    ),
    TypedMiddleware<AppState, ToggleStarredEventAction>(
      _toggleStarredEvent(firestoreRepository),
    ),
  ];
}

void Function(
  Store<AppState> store,
  ConnectToAgendaEventsAction action,
  NextDispatcher next,
) _connectToAgendaEvents(FirestoreRepository firestoreRepository) {
  return (store, action, next) {
    next(action);

    firestoreRepository.agendaEvents(store.state.tripId).handleError(() {
      store.dispatch(ErrorConnectingToAgendaEventsAction());
    }).listen((event) {
      store.dispatch(GotAgendaEventsAction(event));
    });

    firestoreRepository
        .starredEvents(
      store.state.tripId,
      store.state.loginState.loggedInUser.email,
    )
        .handleError(() {
      store.dispatch(ErrorConnectingToAgendaEventsAction());
    }).listen((event) {
      store.dispatch(GotStarredEvents(event));
    });
  };
}

void Function(
  Store<AppState> store,
  ToggleStarredEventAction action,
  NextDispatcher next,
) _toggleStarredEvent(FirestoreRepository firestoreRepository) {
  return (store, action, next) {
    next(action);

    firestoreRepository.toggleStarredEvent(
      store.state.tripId,
      store.state.loginState.loggedInUser.email,
      action.eventId,
      action.starred,
    );
  };
}
