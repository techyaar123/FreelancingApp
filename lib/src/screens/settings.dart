import 'package:employmentappproject/src/screens/UserEditProfile.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => UserEditProfile()));
              }),
        ),
        body: Container(
          padding: EdgeInsets.only(left: 16, top: 25, right: 16),
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
                'Settings',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    'Account',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )
                ],
              ),
              Divider(
                height: 16,
                thickness: 2,
                color: Colors.white,
              ),
              SizedBox(
                height: 10,
              ),
              buildAccountSettingsList(context, 'Change Password'),
              buildAccountSettingsList(context, 'Content Settings'),
              buildAccountSettingsList(context, 'Social'),
              buildAccountSettingsList(context, 'Languages'),
              buildAccountSettingsList(context, 'Privacy and Settings'),
              SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  Icon(
                    Icons.volume_up,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    'Notifications',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )
                ],
              ),
              Divider(
                height: 16,
                thickness: 2,
                color: Colors.white,
              ),
              SizedBox(
                height: 10,
              ),
              buildNotificationActionRow(context, 'New For you', true),
              buildNotificationActionRow(context, 'New For you', false),
              buildNotificationActionRow(context, 'New For you', true),
              RaisedButton(
                padding: EdgeInsets.symmetric(horizontal: 40),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: Colors.pink[300],
                onPressed: () {},
                child: Text(
                  'Sign Out',
                  style: TextStyle(
                    fontSize: 16,
                    letterSpacing: 2.2,
                    color: Colors.white70,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNotificationActionRow(
      BuildContext context, String title, bool isActive) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white54),
          ),
          Transform.scale(
            scale: 0.7,
            child: CupertinoSwitch(
              value: isActive,
              onChanged: (bool val) {
                setState(() {
                  isActive = val;
                  print(isActive);
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildAccountSettingsList(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors.pink[700],
                title: Text(
                  title,
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white54),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Option 1'),
                    Text('Option 2'),
                    Text('Option 3'),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Close',
                      style: TextStyle(color: Colors.white54),
                    ),
                  ),
                ],
              );
            },
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white54,
              ),
            ),
            Icon(
              Icons.arrow_forward,
              color: Colors.white54,
            )
          ],
        ),
      ),
    );
  }
}
