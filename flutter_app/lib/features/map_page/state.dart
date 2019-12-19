import 'package:flutter/foundation.dart';

@immutable
class MapState {
  final bool isSharingLocation;

  MapState._(this.isSharingLocation);

  factory MapState.initial() => MapState._(false);

  MapState copyWith({bool isSharingLocation}) {
    return MapState._(isSharingLocation ?? this.isSharingLocation);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MapState &&
          runtimeType == other.runtimeType &&
          isSharingLocation == other.isSharingLocation;

  @override
  int get hashCode => isSharingLocation.hashCode;
}
