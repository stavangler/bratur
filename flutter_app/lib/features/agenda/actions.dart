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
