import 'package:bratur/models/user.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'actions.freezed.dart';

class StartSharingLocationAction {
  @override
  String toString() {
    return 'StartSharingLocationAction{}';
  }
}

class StopSharingLocationAction {
  @override
  String toString() {
    return 'StopSharingLocationAction{}';
  }
}

class ConnectToUsersInMapAction {
  @override
  String toString() {
    return 'ConnectToUsersInMapAction{}';
  }
}

@freezed
abstract class GotUsers with _$GotUsers {
  const factory GotUsers(List<User> users) = _GotUsers;
}

class ErrorGettingUsers {
  @override
  String toString() {
    return 'ErrorGettingUsers{}';
  }
}
