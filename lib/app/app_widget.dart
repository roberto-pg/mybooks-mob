import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_books/shared/utils/device_orientation.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    portraitModeOnly();
    return MaterialApp(
      builder: asuka.builder,
      initialRoute: "/",
      title: 'My Books',
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
    ).modular();
  }
}
