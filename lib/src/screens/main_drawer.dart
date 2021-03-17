import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employmentappproject/src/providers/auth.dart';
import 'package:employmentappproject/src/screens/UserEditProfile.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  Reference _reference = FirebaseStorage.instance.ref().child('myImage.jpg');
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: false);

    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('UserProfile')
            .doc(auth.user.uid)
            .snapshots(),
        builder: (context, snapshot) => buildDrawer(auth, context, snapshot));
  }

  Widget buildDrawer(Auth auth, BuildContext context,
      AsyncSnapshot<DocumentSnapshot> snapshot) {
    if (!snapshot.hasData) {
      return Container(
        child: Center(
          child: Text(
            'Please Update your profile',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    } else {
      return Drawer(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              color: Colors.pink[700],
              child: Center(
                child: Column(
                  children: [
                    FutureBuilder(
                        future: _reference.getDownloadURL(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Container();
                          } else {
                            return Container(
                              height: 100,
                              width: 100,
                              margin: EdgeInsets.only(top: 30, bottom: 10),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image:
                                        NetworkImage(snapshot.data.toString()),
                                    fit: BoxFit.fill),
                              ),
                            );
                          }
                        }),
                    Text(
                      'Hello ${snapshot.data.data()['Full Name'].toString()}',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    auth.appState == AppState.authenticated
                        ? Text(
                            auth.user.email,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text(
                'Settings',
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => UserEditProfile()));
              },
            ),
            auth.appState == AppState.authenticated
                ? ListTile(
                    leading: Icon(Icons.exit_to_app),
                    title: Text(
                      'LogOut',
                      style: TextStyle(fontSize: 18),
                    ),
                    onTap: () {
                      auth.logout();
                    },
                  )
                : Container()
          ],
        ),
      );
    }
  }
}
