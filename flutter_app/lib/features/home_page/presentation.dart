import 'dart:io';

import 'package:bratur/knowit_colors.dart';
import 'package:bratur/navigation/destination.dart';
import 'package:bratur/navigation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  HomePage({
    Key key,
    @required this.menuIndex,
    @required this.onMenuItemTapped,
  }) : super(key: key);

  final int menuIndex;
  final Function(int) onMenuItemTapped;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with TickerProviderStateMixin<HomePage>, WidgetsBindingObserver {
  List<AnimationController> _faders;
  List<Key> _destinationKeys;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    _faders = allDestinations.map((destination) {
      return AnimationController(
          vsync: this, duration: Duration(milliseconds: 200));
    }).toList();
    _faders[widget.menuIndex].value = 1;
    _destinationKeys =
        List.generate(allDestinations.length, (_) => GlobalKey());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    for (var controller in _faders) {
      controller.dispose();
    }

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    } else if (state == AppLifecycleState.paused) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle());
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: systemUiOverlayStyle,
      child: Container(
        padding: Platform.isAndroid
            ? EdgeInsets.only(
                bottom: MediaQuery.of(context).padding.bottom +
                    MediaQuery.of(context).viewInsets.bottom)
            : null,
        child: WillPopScope(
          onWillPop: () async {
            if (allDestinations[widget.menuIndex].navigatorKey != null) {
              return !await allDestinations[widget.menuIndex]
                  .navigatorKey
                  .currentState
                  .maybePop();
            }
            return true;
          },
          child: Scaffold(
            body: Stack(
              children: allDestinations.map((destination) {
                final Widget view = FadeTransition(
                  opacity: _faders[destination.index]
                      .drive(CurveTween(curve: Curves.fastOutSlowIn)),
                  child: KeyedSubtree(
                    key: _destinationKeys[destination.index],
                    child: DestinationView(destination: destination),
                  ),
                );
                if (destination.index == widget.menuIndex) {
                  _faders[destination.index].forward();
                  return view;
                } else {
                  _faders[destination.index].reverse();
                  if (_faders[destination.index].isAnimating) {
                    return IgnorePointer(child: view);
                  }
                  return Offstage(child: view);
                }
              }).toList(),
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: allDestinations.map((destination) {
                return BottomNavigationBarItem(
                  icon: Icon(destination.icon),
                  title: Text(destination.title),
                  backgroundColor: destination.color,
                );
              }).toList(),
              currentIndex: widget.menuIndex,
              onTap: widget.onMenuItemTapped,
              type: BottomNavigationBarType.shifting,
              unselectedItemColor: KnowitColors.black,
              selectedItemColor: KnowitColors.black,
            ),
          ),
        ),
      ),
    );
  }

  SystemUiOverlayStyle get systemUiOverlayStyle {
    return SystemUiOverlayStyle(
      systemNavigationBarColor: allDestinations[widget.menuIndex].color,
      systemNavigationBarIconBrightness: Brightness.dark,
    );
  }
}
