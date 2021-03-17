import 'package:employmentappproject/src/providers/auth.dart';
import 'package:employmentappproject/src/screens/UserEditProfile.dart';
import 'package:employmentappproject/src/screens/ViewAllJobs.dart';
import 'package:employmentappproject/src/screens/dummy_screen.dart';

import 'package:employmentappproject/src/screens/login.dart';
import 'package:employmentappproject/src/screens/main_drawer.dart';
import 'package:employmentappproject/src/screens/postAjob.dart';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Material myItems(IconData icon, String heading, Color color,
      BuildContext context, Widget pageRoute, AppState user) {
    return Material(
      color: color,
      elevation: 5,
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        onTap: () {
          if (user == AppState.unauthenticated) {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => LoginScreen()));
          } else if (user == AppState.authenticated) {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => pageRoute));
          }
        },
        child: Container(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            heading,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 21,
                            ),
                          ),
                        ),
                      ),
                      Material(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Icon(
                            icon,
                            color: color,
                            size: 30,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Auth>(context, listen: false).appState;
    final auth = Provider.of<Auth>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('DashBoard (Client)'),
          backgroundColor: Colors.pink[700],
          actions: [
            auth.appState == AppState.authenticated
                ? IconButton(
                    icon: Icon(Icons.logout),
                    onPressed: () {
                      auth.logout();
                    })
                : Container(),
          ],
        ),
        drawer: MainDrawer(),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topCenter, colors: [
            Colors.pink[900],
            Colors.pink[800],
            Colors.pink[700],
            Colors.pink[600],
          ])),
          child: StaggeredGridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            padding: EdgeInsets.symmetric(
              vertical: 75,
              horizontal: 16,
            ),
            children: [
              myItems(Icons.people, 'Profile', Colors.amber, context,
                  UserEditProfile(), user),
              myItems(Icons.work, 'Post a Job', Colors.green, context,
                  PostAjobScreen(), user),
              myItems(Icons.remove_red_eye, 'View all Jobs', Colors.deepOrange,
                  context, ViewAllJobsScreen(), user),
            ],
            staggeredTiles: [
              StaggeredTile.extent(2, MediaQuery.of(context).size.height * 0.4),
              StaggeredTile.extent(1, MediaQuery.of(context).size.height * 0.3),
              StaggeredTile.extent(1, MediaQuery.of(context).size.height * 0.3),
            ],
          ),
        ),
      ),
    );
  }
}
