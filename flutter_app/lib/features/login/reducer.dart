import 'package:bratur/features/login/actions.dart';
import 'package:bratur/features/login/state.dart';
import 'package:redux/redux.dart';

final loginReducer = combineReducers<LoginState>([
  TypedReducer<LoginState, InitialUserAction>((state, action) {
    return state.copyWith(loggedInUser: action.user, loading: false);
  }),
  TypedReducer<LoginState, LoginStarted>((state, action) {
    return state.copyWith(loggedInUser: null, loading: true);
  }),
  TypedReducer<LoginState, LoginFailed>((state, action) {
    return state.copyWith(loggedInUser: null, loading: false);
  }),
  TypedReducer<LoginState, LoggedIn>((state, action) {
    return state.copyWith(loggedInUser: action.user);
  })
]);
