import 'package:bratur/models/location.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

@freezed
abstract class User with _$User {
  const factory User(
    String userId,
    String name,
    String photoUrl,
    @nullable Location currentLocation,
  ) = _User;
}
