import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatelessWidget {
  final _initialPosition = CameraPosition(
    target: LatLng(58.9177924, 5.7020611),
    zoom: 12,
  );

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: _initialPosition,
    );
  }
}
