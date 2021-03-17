import 'package:employmentappproject/src/providers/vIewallProducts.dart';
import 'package:employmentappproject/src/screens/UserEditProfile.dart';
import 'package:employmentappproject/src/screens/ViewAllJobs.dart';
import 'package:employmentappproject/src/screens/home.dart';
import 'package:employmentappproject/src/screens/settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewAllStatus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    switch (Provider.of<ViewAllProducts>(context).pagelayout) {
      case PageLayout.initial:
        return ViewAllJobsScreen();
      case PageLayout.onlyclient:
        return HomeScreen();
      case PageLayout.viewAll:
        return UserEditProfile();
    }
    return SettingsPage();
  }
}
