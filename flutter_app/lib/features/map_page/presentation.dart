import 'package:bratur/models/user.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatelessWidget {
  final bool isSharingLocation;
  final Function onShareLocationTapped;
  final List<User> users;
  final GlobalKey<ScaffoldState> scaffoldKey;

  final _initialPosition = CameraPosition(
    target: LatLng(58.9177924, 5.7020611),
    zoom: 12,
  );
  final String tripId;

  MapPage({
    @required this.isSharingLocation,
    @required this.onShareLocationTapped,
    @required this.tripId,
    @required this.users,
    @required this.scaffoldKey,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: GoogleMap(
        initialCameraPosition: _initialPosition,
        myLocationButtonEnabled: false,
        myLocationEnabled: true,
        markers: users.map(
          (user) {
            return Marker(
              markerId: MarkerId(user.userId),
              position: LatLng(
                user.currentLocation.latitude,
                user.currentLocation.longitude,
              ),
              infoWindow: InfoWindow(title: user.name),
            );
          },
        )?.toSet(),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => onShareLocationTapped(),
        icon: Icon(Icons.track_changes),
        label: Text(isSharingLocation ? 'Stop sharing' : 'Share my location'),
        backgroundColor: isSharingLocation
            ? Theme.of(context).buttonColor
            : Theme.of(context).accentColor,
        foregroundColor: isSharingLocation
            ? Theme.of(context).textTheme.button.color
            : Theme.of(context).accentTextTheme.button.color,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
