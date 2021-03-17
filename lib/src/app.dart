import 'package:employmentappproject/src/providers/auth.dart';
import 'package:employmentappproject/src/providers/profileProvider.dart';
import 'package:employmentappproject/src/providers/vIewallProducts.dart';

import 'package:employmentappproject/src/screens/showScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Auth.instance(),
        ),
        ChangeNotifierProvider(
          create: (_) => ViewAllProducts(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProfileProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          accentColor: Colors.pinkAccent,
          primarySwatch: Colors.blue,
        ),
        home: ShowScreen(),
      ),
    );
  }
}
