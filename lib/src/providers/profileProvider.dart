import 'package:employmentappproject/src/firebaseServices/firebaseServices.dart';
import 'package:employmentappproject/src/models/profile.dart';
import 'package:employmentappproject/src/providers/auth.dart';
import 'package:flutter/cupertino.dart';

class ProfileProvider with ChangeNotifier {
  final firestoreServices = FirebaseServices();
  String _entryusername;
  String _entryname;
  String _entryLocation;
  String _entrypassword;

  String get entryusername => _entryusername;
  String get entryname => _entryname;
  String get entryLocation => _entryLocation;
  String get entrypassword => _entrypassword;
  Stream<List<Profile>> get entries => firestoreServices.getEntries();

  set changeUserName(String entryusername) {
    _entryusername = entryusername;
    notifyListeners();
  }

  set changename(String entryname) {
    _entryname = entryname;
    notifyListeners();
  }

  set changelocation(String entryLocation) {
    _entryLocation = entryLocation;
    notifyListeners();
  }

  set changePassword(String entrypassword) {
    _entrypassword = entrypassword;
    notifyListeners();
  }

  loadAll(Profile entry) {
    if (entry != null) {
      _entryname = entry.entryname;
      _entryusername = entry.entryusername;
      _entryLocation = entry.entryLocation;
      _entrypassword = entry.entrypassword;
    } else {
      _entryname = null;
      _entryusername = null;
      _entryLocation = null;
      _entrypassword = null;
    }
  }

  saveEntry() {
    if (_entryusername == null) {
      var newEntry = Profile(
          entryname: _entryname,
          entryusername: Auth.instance().user.email,
          entryLocation: _entryLocation,
          entrypassword: _entrypassword);
      firestoreServices.setEntry(newEntry);
    } else {
      var updateEntry = Profile(
          entryname: _entryname,
          entryusername: _entryusername,
          entryLocation: _entryLocation,
          entrypassword: _entrypassword);
      firestoreServices.setEntry(updateEntry);
    }
  }
}
