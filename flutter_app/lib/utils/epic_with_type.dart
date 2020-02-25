import 'package:redux_epics/redux_epics.dart';

typedef EpicWithActionType<State, Actions> = Stream<dynamic> Function(
  Stream<Actions> actions,
  EpicStore<State> store,
);
