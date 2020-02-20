import 'package:bratur/models/user.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

@freezed
abstract class MapState with _$MapState {
  const factory MapState(
    bool isSharingLocation,
    List<User> users,
    bool errorGettingUsers,
  ) = _MapState;

  factory MapState.initial() => MapState(false, [], false);
}
