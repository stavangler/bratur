import 'package:bratur/features/home_page/container.dart';
import 'package:bratur/knowit_colors.dart';
import 'package:bratur/redux/reducer.dart';
import 'package:bratur/redux/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final store = Store<AppState>(appReducer, initialState: AppState.initial());

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        title: 'Bratur',
        theme: ThemeData(
          primaryColor: KnowitColors.white,
          backgroundColor: KnowitColors.white,
          scaffoldBackgroundColor: KnowitColors.white,
          canvasColor: KnowitColors.white,
          accentColor: KnowitColors.lollipop,
          fontFamily: 'Arial',
          pageTransitionsTheme: PageTransitionsTheme(
            builders: {
              ...Theme.of(context).pageTransitionsTheme.builders,
              TargetPlatform.android: ZoomPageTransitionsBuilder(),
            },
          ),
          snackBarTheme: SnackBarThemeData(behavior: SnackBarBehavior.floating),
        ),
        home: HomePageContainer(),
      ),
    );
  }
}
