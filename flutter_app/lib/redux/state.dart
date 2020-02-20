import 'package:bratur/features/agenda/state.dart';
import 'package:bratur/features/login/state.dart';
import 'package:bratur/features/map_page/state.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

@freezed
abstract class AppState with _$AppState {
  @late
  String get tripId => 'y0YhKJG9lMAVbgECzSaN';

  factory AppState({
    @required int menuItem,
    @required LoginState loginState,
    @required AgendaState agendaState,
    @required MapState mapState,
  }) = _AppState;

  factory AppState.initial() => AppState(
        menuItem: 0,
        loginState: LoginState.initial(),
        agendaState: AgendaState.initial(),
        mapState: MapState.initial(),
      );
}
