import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'app/app_module.dart';
import 'app/app_widget.dart';

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();
  Modular.to.addListener(() {
    log(Modular.to.path);
  });

  runApp(ModularApp(
    module: AppModule(),
    child: const AppWidget(),
  ));
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
