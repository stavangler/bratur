import 'package:bratur/features/agenda/state.dart';
import 'package:bratur/features/map_page/state.dart';
import 'package:faker/faker.dart';
import 'package:meta/meta.dart';

@immutable
class AppState {
  final int menuItem;
  final tripId = 'y0YhKJG9lMAVbgECzSaN';
  final userId = RandomGenerator().string(20, min: 20);
  final userName = Faker().person.name();
  final AgendaState agendaState;
  final MapState mapState;

  AppState({
    @required this.menuItem,
    @required this.agendaState,
    @required this.mapState,
  });

  factory AppState.initial() => AppState(
        menuItem: 0,
        agendaState: AgendaState.initial(),
        mapState: MapState.initial(),
      );

  AppState copyWith({
    int menuItem,
  }) {
    return AppState(
      menuItem: menuItem ?? this.menuItem,
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
          agendaState == other.agendaState &&
          mapState == other.mapState;

  @override
  int get hashCode =>
      menuItem.hashCode ^ agendaState.hashCode ^ mapState.hashCode;
}
