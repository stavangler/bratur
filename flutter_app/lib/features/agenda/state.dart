import 'package:bratur/models/event.dart';
import 'package:faker/faker.dart';
import 'package:flutter/foundation.dart';

@immutable
class AgendaState {
  final List<Event> events;

  AgendaState._({this.events});

  factory AgendaState.initial() {
    const faker = Faker();
    return AgendaState._(
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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AgendaState &&
          runtimeType == other.runtimeType &&
          events == other.events;

  @override
  int get hashCode => events.hashCode;
}
