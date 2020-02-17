import 'package:bratur/models/location.dart';
import 'package:bratur/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreRepository {
  DocumentReference _userRef(String tripId, String userId) => Firestore.instance
      .collection('trips')
      .document(tripId)
      .collection('people')
      .document(userId);

  Future<void> saveCurrentLocation(
    String tripId,
    String userId,
    String displayName,
    String photoUrl,
    double latitude,
    double longitude,
  ) {
    return _userRef(tripId, userId).setData(
      {
        'name': displayName,
        'photoUrl': photoUrl,
        'currentLocation': {
          'latitude': latitude,
          'longitude': longitude,
          'latestUpdate': Timestamp.now(),
        }
      },
      merge: true,
    );
  }

  Future<void> deleteCurrentLocation(String tripId, String userId) {
    return _userRef(tripId, userId)
        .updateData({'currentLocation': FieldValue.delete()});
  }

  Stream<List<User>> connectToUsersInMap(String tripId) {
    return Firestore.instance
        .collection('trips')
        .document(tripId)
        .collection('people')
        .where('currentLocation.latestUpdate',
            isGreaterThan: Timestamp.fromDate(
                DateTime.now().subtract(Duration(minutes: 15))))
        .snapshots()
        .map(
          (snapshot) => snapshot.documents
              .map(
                (doc) => User(
                  doc.documentID,
                  doc['name'],
                  doc['photoUrl'],
                  Location(
                    doc['currentLocation']['latitude'],
                    doc['currentLocation']['longitude'],
                  ),
                ),
              )
              .toList(),
        );
  }
}
