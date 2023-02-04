import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:raven_for_nitc/models.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<DBUser> getUser(String uid) async {
    DocumentSnapshot doc = await _db.collection('users').doc(uid).get();
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return DBUser.fromMap({
      ...data,
      'id': uid,
    });
  }

  Future<Event> getEvent(String id) async {
    DocumentSnapshot doc = await _db.collection('events').doc(id).get();
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Event.fromMap({
      ...data,
      'id': id,
    });
  }

  Future<Announcement> getAnnouncement(String id) async {
    DocumentSnapshot doc = await _db.collection('announcements').doc(id).get();
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Announcement.fromMap({
      ...data,
      'id': id,
    });
  }

  Future<List<MessTimetable>> getMessTimetables() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _db.collection('messTimetables').get();
    List<Map<String, dynamic>> data = snapshot.docs
        .map((doc) => {
              ...doc.data(),
              'id': doc.id,
            })
        .toList();
    return data.map((item) => MessTimetable.fromMap(item)).toList();
  }

  Future<List<Amenity>> getAmenities() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _db.collection('amenities').get();
    List<Map<String, dynamic>> data = snapshot.docs
        .map((doc) => {
              ...doc.data(),
              'id': doc.id,
            })
        .toList();
    return data.map((item) => Amenity.fromMap(item)).toList();
  }

  Stream<List<Event>>? streamEvents() {
    return _db.collection('events').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data();
        return Event.fromMap({
          ...data,
          'id': doc.id,
        });
      }).toList();
    });
  }

  Stream<List<Announcement>>? streamAnnouncements() {
    return _db.collection('announcements').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data();
        return Announcement.fromMap({
          ...data,
          'id': doc.id,
        });
      }).toList();
    });
  }

  Future<Event> createEvent(Map<String, dynamic> event) async {
    String? imageCloudURL;
    if (event['imageURL'] != null) {
      String path = event['imageURL'].split('/').last;
      Reference ref = _storage.ref().child('events/$path');
      UploadTask uploadTask = ref.putFile(event['imageURL']);
      TaskSnapshot taskSnapshot = await uploadTask;
      imageCloudURL = await taskSnapshot.ref.getDownloadURL();
    }
    DocumentReference ref = await _db.collection('events').add({
      'title': event['title'],
      'description': event['description'],
      'startTime': event['startTime'],
      'endTime': event['endTime'],
      'venue': event['venue'],
      'imageURL': imageCloudURL,
      'authority': event['authority'],
    });
    return getEvent(ref.id);
  }

  Future<Announcement> createAnnouncement(
      Map<String, dynamic> announcement) async {
    DocumentReference ref = await _db.collection('announcements').add({
      'title': announcement['title'],
      'description': announcement['description'],
      'startTime': announcement['startTime'],
      'endTime': announcement['endTime'],
      'createdAt': announcement['createdAt'],
      'authority': announcement['authority'],
    });
    return getAnnouncement(ref.id);
  }

  Future<void> setUser(DBUser user) async {
    await _db.collection('users').doc(user.id).set({
      'email': user.email,
      'displayName': user.displayName,
      'photoURL': user.photoURL,
      'mess': user.mess,
    });
  }

  Future<void> setEvent(Event event) async {
    await _db.collection('events').doc(event.id).set({
      'title': event.title,
      'description': event.description,
      'startTime': event.startTime,
      'endTime': event.endTime,
      'venue': event.venue,
      'imageURL': event.imageURL,
      'authority': event.authority,
    });
  }

  Future<void> setAnnouncement(Announcement announcement) async {
    await _db.collection('announcements').doc(announcement.id).set({
      'title': announcement.title,
      'description': announcement.description,
      'startTime': announcement.startTime,
      'endTime': announcement.endTime,
    });
  }

  Future<void> deleteEvent(String id) async {
    await _db.collection('events').doc(id).delete();
  }

  Future<void> deleteAnnouncement(String id) async {
    await _db.collection('announcements').doc(id).delete();
  }
}
