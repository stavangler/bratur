import 'package:bratur/features/agenda/reducer.dart';
import 'package:bratur/features/home_page/reducer.dart';
import 'package:bratur/features/map_page/reducer.dart';
import 'package:bratur/redux/state.dart';

AppState appReducer(AppState state, action) {
  return AppState(
    menuItem: selectedMenuItemReducer(state.menuItem, action),
    agendaState: agendaReducer(state.agendaState, action),
    mapState: mapReducer(state.mapState, action),
  );
}
