import 'package:employmentappproject/src/screens/DummyViewALLpAGE.dart';

import 'package:flutter/material.dart';

class PageViewAllJobsScreen extends StatefulWidget {
  final String jobTitle;
  final String skillsRequired;
  final String jobDes;
  final String nofopen;
  final String organizationName;
  final String userId;

  PageViewAllJobsScreen({
    this.jobTitle,
    this.skillsRequired,
    this.jobDes,
    this.nofopen,
    this.organizationName,
    this.userId,
  });
  @override
  _PageViewAllJobsScreenState createState() => _PageViewAllJobsScreenState();
}

class _PageViewAllJobsScreenState extends State<PageViewAllJobsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink[700],
          elevation: 1,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => ViewAllJobsScreen()));
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
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Column(
              children: [
                Text(
                  widget.jobTitle,
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
