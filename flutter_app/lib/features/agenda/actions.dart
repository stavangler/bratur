import 'package:bratur/models/event.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'actions.freezed.dart';

class ConnectToAgendaEventsAction {
  @override
  String toString() {
    return 'ConnectToAgendaEventsAction{}';
  }
}

@freezed
abstract class GotAgendaEventsAction with _$GotAgendaEventsAction {
  const factory GotAgendaEventsAction(List<Event> events) =
      _GotAgendaEventsAction;
}

class ErrorConnectingToAgendaEventsAction {
  @override
  String toString() {
    return 'ErrorConnectingToAgendaEventsAction{}';
  }
}

@freezed
abstract class ToggleStarredEventAction with _$ToggleStarredEventAction {
  const factory ToggleStarredEventAction(String eventId, bool starred) =
      _ToggleStarredEventAction;
}

@freezed
abstract class GotStarredEvents with _$GotStarredEvents {
  const factory GotStarredEvents(List<String> starredEvents) =
      _GotStarredEvents;
}
