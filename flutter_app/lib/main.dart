import 'package:bratur/features/home_page/container.dart';
import 'package:bratur/features/login/container.dart';
import 'package:bratur/features/map_page/middleware.dart';
import 'package:bratur/knowit_colors.dart';
import 'package:bratur/redux/reducer.dart';
import 'package:bratur/redux/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:redux_thunk/redux_thunk.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final store = Store<AppState>(
    appReducer,
    initialState: AppState.initial(),
    middleware: [
      thunkMiddleware,
      startSharingLocationMiddleware,
      new LoggingMiddleware.printer(),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        title: 'Bratur',
        theme: ThemeData(
          primaryColor: KnowitColors.white,
          primaryColorBrightness: Brightness.light,
          backgroundColor: KnowitColors.white,
          scaffoldBackgroundColor: KnowitColors.white,
          canvasColor: KnowitColors.white,
          accentColor: KnowitColors.lollipop,
          textTheme: Theme.of(context).textTheme.apply(
                bodyColor: KnowitColors.black,
                displayColor: KnowitColors.black,
              ),
          buttonColor: KnowitColors.flamingo,
          fontFamily: 'Arial',
          pageTransitionsTheme: PageTransitionsTheme(
            builders: {
              ...Theme.of(context).pageTransitionsTheme.builders,
              TargetPlatform.android: ZoomPageTransitionsBuilder(),
            },
          ),
          snackBarTheme: SnackBarThemeData(behavior: SnackBarBehavior.floating),
        ),
        routes: {
          '/login': (context) => LoginContainer(),
        },
        home: HomePageContainer(),
      ),
    );
  }
}
