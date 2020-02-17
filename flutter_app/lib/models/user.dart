import 'package:bratur/models/location.dart';
import 'package:flutter/foundation.dart';

@immutable
class User {
  final String userId;
  final String name;
  final String photoUrl;
  final Location currentLocation;

  User(this.userId, this.name, this.photoUrl, this.currentLocation);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          userId == other.userId &&
          name == other.name &&
          photoUrl == other.photoUrl &&
          currentLocation == other.currentLocation;

  @override
  int get hashCode =>
      userId.hashCode ^
      name.hashCode ^
      photoUrl.hashCode ^
      currentLocation.hashCode;
}
