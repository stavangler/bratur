import 'package:bratur/models/event.dart';
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
          (snapshot) => snapshot.documents.map(_mapDocumentToUser).toList(),
        );
  }

  Stream<List<Event>> agendaEvents(String tripId) {
    return Firestore.instance
        .collection('trips')
        .document(tripId)
        .collection('agenda')
        .snapshots()
        .map((snapshot) {
      return snapshot.documents.map((doc) {
        try {
          return Event(
            doc['title'],
            doc['description'],
            doc['startTime'].toDate(),
            doc['duration'],
            doc['location'],
            doc['track'],
            doc['topics'].cast<String>(),
//          doc['speakers'].map((DocumentReference ref) {
//            return ref.get().then(_mapDocumentToUser);
//          }),
            [],
          );
        } catch (e) {
          return null;
        }
      }).toList();
    });
  }

  User _mapDocumentToUser(doc) => User(
        doc.documentID,
        doc['name'],
        doc['photoUrl'],
        Location(
          doc['currentLocation']['latitude'],
          doc['currentLocation']['longitude'],
        ),
      );
}
