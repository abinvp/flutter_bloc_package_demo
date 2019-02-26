import 'package:flutter/material.dart';
import 'package:flutter_bloc_package_demo/organization/screens/invite_users_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Bloc Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: InviteUsersScreen(),
    );
  }
}
