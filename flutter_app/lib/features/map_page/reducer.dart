import 'package:bratur/features/map_page/actions.dart';
import 'package:bratur/features/map_page/state.dart';
import 'package:redux/redux.dart';

final mapReducer = combineReducers<MapState>([
  TypedReducer<MapState, StartSharingLocationAction>((state, action) {
    return state.copyWith(isSharingLocation: true);
  })
]);
