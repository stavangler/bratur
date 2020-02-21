import 'package:bratur/features/agenda/actions.dart';
import 'package:bratur/redux/state.dart';
import 'package:bratur/repository.dart';
import 'package:redux/redux.dart';

Middleware<AppState> createAgendaMiddleware(
  FirestoreRepository firestoreRepository,
) {
  return TypedMiddleware<AppState, ConnectToAgendaEventsAction>(
    _connectToAgendaEvents(firestoreRepository),
  );
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
  };
}
