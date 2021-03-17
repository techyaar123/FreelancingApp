import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:employmentappproject/src/providers/auth.dart';

import 'package:employmentappproject/src/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostAjobScreen extends StatefulWidget {
  @override
  _PostAjobScreenState createState() => _PostAjobScreenState();
}

class _PostAjobScreenState extends State<PostAjobScreen> {
  TextEditingController jobtitle = TextEditingController();
  TextEditingController skillsRequired = TextEditingController();
  TextEditingController jobdescription = TextEditingController();
  TextEditingController noofopenings = TextEditingController();
  TextEditingController organizationname = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authUser = Provider.of<Auth>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[700],
        elevation: 1,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => HomeScreen()));
            }),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 15, top: 24, right: 15),
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Colors.pink[900],
          Colors.pink[800],
          Colors.pink[700],
          Colors.pink[600],
        ])),
        child: ListView(
          children: [
            Text(
              'Post a Job',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              height: 16,
              thickness: 2,
              color: Colors.white,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Job Title',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white54,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            TextFormField(
              controller: jobtitle,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Skills Required',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white54,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            TextFormField(
              controller: skillsRequired,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Job Description',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white54,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            TextFormField(
              controller: jobdescription,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
              maxLines: 8,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'No of Openings',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white54,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            TextFormField(
              controller: noofopenings,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Organization Name',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white54,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            TextFormField(
              controller: organizationname,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        elevation: 5,
                        padding: EdgeInsets.only(
                            left: 50, right: 50, top: 10, bottom: 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    )),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        elevation: 5,
                        padding: EdgeInsets.only(
                            left: 50, right: 50, top: 10, bottom: 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    onPressed: () {
                      Map<String, dynamic> data = {
                        'job Title': jobtitle.text,
                        'Skills Required': skillsRequired.text,
                        'Job Description': jobdescription.text,
                        'No of Openings': noofopenings.text,
                        'Organization Name': organizationname.text,
                        'Date time Taken': formatDate(
                            DateTime.now(), [yyyy, '-', mm, '-', dd]),
                        'User id': authUser.user.uid,
                      };
                      FirebaseFirestore.instance
                          .collection('Post a Job')
                          .doc()
                          .set(data);
                      FirebaseFirestore.instance
                          .collection('Post a Job')
                          .doc(authUser.user.uid)
                          .collection(authUser.user.uid)
                          .add(data);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => HomeScreen()));
                    },
                    child: Text(
                      'Save',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    )),
              ],
            ),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
