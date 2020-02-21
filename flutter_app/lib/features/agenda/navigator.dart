import 'package:bratur/features/agenda/container.dart';
import 'package:bratur/features/event_page/presentation.dart';
import 'package:bratur/models/event.dart';
import 'package:flutter/material.dart';

class AgendaNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorState;

  const AgendaNavigator({Key key, @required this.navigatorState})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorState,
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            switch (settings.name) {
              case '/':
                return AgendaContainer();
              case '/event':
                return settings.arguments is Event
                    ? EventPage(event: settings.arguments)
                    : AgendaContainer();
            }
            return AgendaContainer();
          },
        );
      },
    );
  }
}
