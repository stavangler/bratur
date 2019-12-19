import 'package:bratur/features/agenda/container.dart';
import 'package:bratur/features/info_page/presentation.dart';
import 'package:bratur/features/map_page/container.dart';
import 'package:bratur/knowit_colors.dart';
import 'package:flutter/material.dart';

class Destination {
  const Destination(
    this.index,
    this.title,
    this.icon,
    this.color,
    this.child, {
    this.navigatorKey,
  });

  final int index;
  final String title;
  final IconData icon;
  final Color color;
  final Widget child;
  final GlobalKey<NavigatorState> navigatorKey;
}

final GlobalKey<NavigatorState> _agendaNavigatorKey = GlobalKey();

final List<Destination> allDestinations = <Destination>[
  Destination(
    0,
    'Agenda',
    Icons.view_agenda,
    KnowitColors.pear,
    AgendaContainer(navigatorState: _agendaNavigatorKey),
    navigatorKey: _agendaNavigatorKey,
  ),
  Destination(1, 'Map', Icons.map, KnowitColors.flamingo, MapContainer()),
  Destination(2, 'Info', Icons.info, KnowitColors.mint, InfoPage()),
];
