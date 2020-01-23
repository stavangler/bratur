import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatelessWidget {
  final bool isSharingLocation;
  final Function onShareLocationTapped;

  final _initialPosition = CameraPosition(
    target: LatLng(58.9177924, 5.7020611),
    zoom: 12,
  );
  final String tripId;

  MapPage({
    @required this.isSharingLocation,
    @required this.onShareLocationTapped,
    @required this.tripId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          return StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance
                  .collection('trips')
                  .document(tripId)
                  .collection('people')
                  .where('currentLocation.latestUpdate',
                      isGreaterThan: Timestamp.fromDate(
                          DateTime.now().subtract(Duration(minutes: 15))))
                  .snapshots()
                  .handleError(() {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text('Failed to find any people 🦗️'),
                ));
              }),
              builder: (context, snapshot) {
                return GoogleMap(
                  initialCameraPosition: _initialPosition,
                  myLocationButtonEnabled: false,
                  myLocationEnabled: true,
                  markers: snapshot.data?.documents?.map(
                    (person) {
                      return Marker(
                        markerId: MarkerId(person.documentID),
                        position: LatLng(
                          person.data['currentLocation']['latitude'],
                          person.data['currentLocation']['longitude'],
                        ),
                        infoWindow: InfoWindow(title: person.data['name']),
                      );
                    },
                  )?.toSet(),
                );
              });
        },
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
