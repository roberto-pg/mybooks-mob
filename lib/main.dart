import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'app/app_module.dart';
import 'app/app_widget.dart';

Future<void> main() async {
  Modular.to.addListener(() {
    log(Modular.to.path);
  });

  runApp(ModularApp(module: AppModule(), child: const AppWidget()));
}
