import 'package:bratur/models/event.dart';
import 'package:faker/faker.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

@freezed
abstract class AgendaState with _$AgendaState {
  const factory AgendaState({@required List<Event> events}) = _AgendaState;

  factory AgendaState.initial() {
    return AgendaState(
      events: List.generate(
        10,
        (index) => Event(
          '${index + 10}:00',
          faker.conference.name(),
          faker.address.streetName(),
          faker.randomGenerator
              .amount((i) => faker.lorem.word(), 3)
              .cast<String>(),
        ),
      ),
    );
  }
}
