import 'package:bratur/features/agenda/actions.dart';
import 'package:bratur/features/agenda/presentation.dart';
import 'package:bratur/models/event.dart';
import 'package:bratur/redux/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class AgendaContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      onInit: (store) => store.dispatch(ConnectToAgendaEventsAction()),
      builder: (context, vm) => AgendaPage(
        events: vm.events,
        starredEvents: vm.starredEvents,
        toggleStarredEvent: vm.toggleStarredEvent,
      ),
    );
  }
}

class _ViewModel {
  final List<Event> events;
  final List<String> starredEvents;
  final Function(String eventId, bool starred) toggleStarredEvent;

  _ViewModel({
    @required this.events,
    @required this.starredEvents,
    @required this.toggleStarredEvent,
  });

  static _ViewModel fromStore(Store<AppState> store) => _ViewModel(
      events: store.state.agendaState.events,
      starredEvents: store.state.agendaState.starredEvents,
      toggleStarredEvent: (eventId, starred) =>
          store.dispatch(ToggleStarredEventAction(eventId, starred)));
}
