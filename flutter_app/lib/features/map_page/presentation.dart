import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatelessWidget {
  final _initialPosition = CameraPosition(
    target: LatLng(58.9177924, 5.7020611),
    zoom: 12,
  );
  static const _tripId = 'y0YhKJG9lMAVbgECzSaN';

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection('trips')
            .document(_tripId)
            .collection('people')
            .snapshots()
            .handleError(() {
          Scaffold.of(context).showSnackBar(
              SnackBar(content: Text('Failed to find any people 🦗️')));
        }),
        builder: (context, snapshot) {
          return GoogleMap(
            initialCameraPosition: _initialPosition,
            markers: snapshot.data.documents.map(
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
            ).toSet(),
          );
        });
  }
}
