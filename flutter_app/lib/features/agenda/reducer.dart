import 'package:bratur/features/agenda/actions.dart';
import 'package:bratur/features/agenda/state.dart';
import 'package:redux/redux.dart';

final agendaReducer = combineReducers<AgendaState>([
  TypedReducer<AgendaState, GotAgendaEventsAction>((state, action) {
    return state.copyWith(events: action.events);
  }),
  TypedReducer<AgendaState, GotStarredEvents>((state, action) {
    return state.copyWith(starredEvents: action.starredEvents);
  }),
]);
