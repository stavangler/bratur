import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event.freezed.dart';

@freezed
abstract class Event with _$Event {
  const factory Event(
    String time,
    String title,
    String location,
    List<String> categories,
  ) = _Event;
}
