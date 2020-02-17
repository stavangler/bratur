import 'package:bratur/features/map_page/actions.dart';
import 'package:bratur/features/map_page/state.dart';
import 'package:redux/redux.dart';

final mapReducer = combineReducers<MapState>([
  TypedReducer<MapState, StartSharingLocationAction>((state, action) {
    return state.copyWith(isSharingLocation: true);
  }),
  TypedReducer<MapState, StopSharingLocationAction>((state, action) {
    return state.copyWith(isSharingLocation: false);
  }),
  TypedReducer<MapState, GotUsers>((state, action) {
    return state.copyWith(users: action.users);
  }),
  (state, action) {
    if (action is ErrorGettingUsers) {
      return state.copyWith(errorGettingUsers: true);
    } else if (!(action is ErrorGettingUsers) && state.errorGettingUsers) {
      return state.copyWith(errorGettingUsers: false);
    } else {
      return state;
    }
  },
]);
