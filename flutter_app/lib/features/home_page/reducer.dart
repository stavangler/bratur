import 'package:bratur/features/home_page/actions.dart';
import 'package:redux/redux.dart';

final selectedMenuItemReducer = combineReducers<int>([
  TypedReducer<int, SelectMenuItemAction>(
      (_, action) => action.selectedMenuItem),
]);
