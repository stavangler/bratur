import 'package:bratur/models/event.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

@freezed
abstract class AgendaState with _$AgendaState {
  const factory AgendaState({@required List<Event> events}) = _AgendaState;

  factory AgendaState.initial() {
    return AgendaState(
      events: [],
    );
  }
}
