import 'package:bratur/models/user.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event.freezed.dart';

@freezed
abstract class Event with _$Event {
  const factory Event(
    String id,
    String title,
    String description,
    DateTime startTime,
    int duration,
    String location,
    String track,
    List<String> topics,
    List<Future<User>> speakers, {
    @Default(false) bool starred,
  }) = _Event;
}
