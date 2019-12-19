import 'package:flutter/foundation.dart';

@immutable
class Event {
  final String time;
  final String title;
  final String location;
  final List<String> categories;

  Event(this.time, this.title, this.location, this.categories);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Event &&
          runtimeType == other.runtimeType &&
          time == other.time &&
          title == other.title &&
          location == other.location &&
          categories == other.categories;

  @override
  int get hashCode =>
      time.hashCode ^ title.hashCode ^ location.hashCode ^ categories.hashCode;
}
