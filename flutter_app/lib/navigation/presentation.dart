import 'package:bratur/navigation/destination.dart';
import 'package:flutter/material.dart';

class DestinationView extends StatelessWidget {
  const DestinationView({Key key, @required this.destination})
      : super(key: key);

  final Destination destination;

  @override
  Widget build(BuildContext context) {
    return destination.child;
  }
}
