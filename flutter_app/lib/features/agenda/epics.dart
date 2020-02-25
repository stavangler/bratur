import 'package:bratur/features/agenda/actions.dart';
import 'package:bratur/models/event.dart';
import 'package:bratur/redux/state.dart';
import 'package:bratur/repository.dart';
import 'package:bratur/utils/epic_with_type.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

Epic<AppState> createAgendaEpics(FirestoreRepository firestoreRepository) {
  return combineEpics([
    TypedEpic<AppState, ConnectToAgendaEventsAction>(
      _connectToAgendaEvents(firestoreRepository),
    ),
    TypedEpic<AppState, ToggleStarredEventAction>(
      _toggleStarredEvent(firestoreRepository),
    ),
  ]);
}

EpicWithActionType<AppState, ConnectToAgendaEventsAction>
    _connectToAgendaEvents(
  FirestoreRepository firestoreRepository,
) {
  return (actions, store) {
    return actions.switchMap(
      (action) => Rx.combineLatest2(
        firestoreRepository.agendaEvents(store.state.tripId),
        firestoreRepository.starredEvents(
          store.state.tripId,
          store.state.loginState.loggedInUser.email,
        ),
        (List<Event> events, List<String> starred) {
          return events
              .map(
                (event) => starred.contains(event.id)
                    ? event.copyWith(starred: true)
                    : event,
              )
              .toList();
        },
      )
          .map<dynamic>((events) => GotAgendaEventsAction(events))
          .doOnError((error, stackTrace) {
        print(error);
        print(stackTrace);
      }).onErrorReturn(ErrorConnectingToAgendaEventsAction()),
    );
  };
}

EpicWithActionType<AppState, ToggleStarredEventAction> _toggleStarredEvent(
  FirestoreRepository firestoreRepository,
) {
  return (actions, store) {
    return actions.asyncMap(
      (action) => firestoreRepository.toggleStarredEvent(
        store.state.tripId,
        store.state.loginState.loggedInUser.email,
        action.eventId,
        action.starred,
      ),
    );
  };
}
