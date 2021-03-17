import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employmentappproject/src/models/profile.dart';

class FirebaseServices {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  Stream<List<Profile>> getEntries() {
    return _db.collection('UserProfile').snapshots().map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => Profile.fromJson(doc.data()),
              )
              .toList(),
        );
  }

  Future<void> setEntry(Profile entry) {
    var options = SetOptions(merge: true);
    return _db
        .collection('UserProfile')
        .doc(entry.entryusername)
        .set(entry.toMap(), options);
  }
}
