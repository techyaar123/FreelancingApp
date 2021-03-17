import 'package:employmentappproject/src/providers/auth.dart';
import 'package:employmentappproject/src/screens/home.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShowScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    switch (Provider.of<Auth>(context).appState) {
      case AppState.authenticating:
        return Center(child: CircularProgressIndicator());
      case AppState.unauthenticated:
        return HomeScreen();
      case AppState.initial:
        return HomeScreen();
      case AppState.authenticated:
        return HomeScreen();
    }
    return HomeScreen();
  }
}
