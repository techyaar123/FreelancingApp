import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:employmentappproject/src/providers/auth.dart';
import 'package:employmentappproject/src/providers/vIewallProducts.dart';
import 'package:employmentappproject/src/screens/PageViewAllJobs.dart';

import 'package:employmentappproject/src/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewAllJobsScreen extends StatefulWidget {
  @override
  _ViewAllJobsScreenState createState() => _ViewAllJobsScreenState();
}

class _ViewAllJobsScreenState extends State<ViewAllJobsScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    final authUser = Provider.of<Auth>(context, listen: false);
    final pageState = Provider.of<ViewAllProducts>(context);

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBar(
            backgroundColor: Colors.pink[700],
            elevation: 1,
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                }),
            title: Text(
              'Jobs Available',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            actions: [
              InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: Text('View Results'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('Choose a Result'),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 8),
                                      child: TextButton(
                                        style: TextButton.styleFrom(
                                            primary: Colors.black),
                                        onPressed: () {
                                          pageState.onlyClientsPage();
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(
                                          'User',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 8),
                                      child: TextButton(
                                        onPressed: () {
                                          pageState.viewallpages();
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(
                                          'All',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.filter_list),
                ),
              )
            ],
          ),
        ),
        body: Container(
            padding: EdgeInsets.only(left: 15, top: 24, right: 15),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors: [
                  Colors.pink[900],
                  Colors.pink[800],
                  Colors.pink[700],
                  Colors.pink[600],
                ],
              ),
            ),
            child: pageState.pagelayout == PageLayout.onlyclient
                ? StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('Post a Job')
                        .doc(authUser.user.uid)
                        .collection(authUser.user.uid)
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: Text('No data'),
                        );
                      } else {
                        return Container(
                          height: MediaQuery.of(context).size.height,
                          child: ListView.builder(
                            itemCount: snapshot.data.size,
                            itemBuilder: (context, index) {
                              return buildContainer(snapshot, index);
                            },
                          ),
                        );
                      }
                    },
                  )
                : StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('Post a Job')
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: Text('No data'),
                        );
                      } else {
                        return Container(
                          height: MediaQuery.of(context).size.height,
                          child: ListView.builder(
                            itemCount: snapshot.data.size,
                            itemBuilder: (context, index) {
                              return buildContainer(snapshot, index);
                            },
                          ),
                        );
                      }
                    },
                  )),
      ),
    );
  }

  Container buildContainer(AsyncSnapshot<QuerySnapshot> snapshot, int index) {
    var page = snapshot.data.docs[index].data();
    return Container(
        child: InkWell(
      onTap: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => PageViewAllJobsScreen(
                  jobTitle: page['job Title'],
                  jobDes: page['Job Description'],
                  nofopen: page['No of Openings'],
                  organizationName: page['Organization Name'],
                  skillsRequired: page['Skills Required'],
                  userId: page['User id'],
                )));
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 8),
                child: Row(
                  children: [
                    Text(snapshot.data.docs[index].data()['job Title']),
                    Spacer(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 8),
                child: Row(
                  children: [
                    Text(snapshot.data.docs[index].data()['Organization Name']),
                    Spacer(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 8),
                child: Row(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 5.0,
                            left: 10,
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.play_circle_fill),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text('dd-MM-yyy'),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 15, left: 15),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.calendar_today),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text('duration'),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 15, left: 15),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.money),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text('Stripen'),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.timelapse),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text('apply by'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
