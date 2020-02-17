import 'package:bratur/models/user.dart';
import 'package:flutter/foundation.dart';

@immutable
class MapState {
  final bool isSharingLocation;
  final List<User> users;
  final bool errorGettingUsers;

  MapState._(this.isSharingLocation, this.users, this.errorGettingUsers);

  factory MapState.initial() => MapState._(false, [], false);

  MapState copyWith({
    bool isSharingLocation,
    List<User> users,
    bool errorGettingUsers,
  }) {
    return MapState._(
      isSharingLocation ?? this.isSharingLocation,
      users ?? this.users,
      errorGettingUsers ?? this.errorGettingUsers,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MapState &&
          runtimeType == other.runtimeType &&
          isSharingLocation == other.isSharingLocation &&
          users == other.users &&
          errorGettingUsers == other.errorGettingUsers;

  @override
  int get hashCode =>
      isSharingLocation.hashCode ^ users.hashCode ^ errorGettingUsers.hashCode;
}
