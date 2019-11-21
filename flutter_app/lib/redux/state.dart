import 'package:bratur/features/agenda/state.dart';
import 'package:meta/meta.dart';

@immutable
class AppState {
  final int menuItem;
  final AgendaState agendaState;

  AppState({
    @required this.menuItem,
    @required this.agendaState,
  });

  factory AppState.initial() => AppState(
        menuItem: 0,
        agendaState: AgendaState.initial(),
      );

  AppState copyWith({
    int menuItem,
  }) {
    return AppState(
      menuItem: menuItem ?? this.menuItem,
      agendaState: this.agendaState,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          menuItem == other.menuItem;

  @override
  int get hashCode => menuItem.hashCode;
}
