import 'package:bratur/features/agenda/state.dart';
import 'package:bratur/features/login/state.dart';
import 'package:bratur/features/map_page/state.dart';
import 'package:meta/meta.dart';

@immutable
class AppState {
  final int menuItem;
  final tripId = 'y0YhKJG9lMAVbgECzSaN';
  final LoginState loginState;
  final AgendaState agendaState;
  final MapState mapState;

  AppState({
    @required this.menuItem,
    @required this.loginState,
    @required this.agendaState,
    @required this.mapState,
  });

  factory AppState.initial() => AppState(
        menuItem: 0,
        loginState: LoginState.initial(),
        agendaState: AgendaState.initial(),
        mapState: MapState.initial(),
      );

  AppState copyWith({
    int menuItem,
  }) {
    return AppState(
      menuItem: menuItem ?? this.menuItem,
      loginState: this.loginState,
      agendaState: this.agendaState,
      mapState: this.mapState,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          menuItem == other.menuItem &&
          loginState == other.loginState &&
          agendaState == other.agendaState &&
          mapState == other.mapState;

  @override
  int get hashCode =>
      menuItem.hashCode ^
      loginState.hashCode ^
      agendaState.hashCode ^
      mapState.hashCode;
}
