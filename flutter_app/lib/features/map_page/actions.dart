import 'package:bratur/models/user.dart';

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

class GotUsers {
  final List<User> users;

  GotUsers(this.users);

  @override
  String toString() {
    return 'GotUsers{users: $users}';
  }
}

class ErrorGettingUsers {
  @override
  String toString() {
    return 'ErrorGettingUsers{}';
  }
}
