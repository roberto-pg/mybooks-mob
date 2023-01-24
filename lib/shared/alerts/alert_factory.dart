import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

alertFactory(
  final String title,
  final String content,
  final String confirm,
  final String cancel,
  final VoidCallback executeFunction,
) {
  return asuka.Asuka.showDialog(
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              TextButton(
                  child: Text(confirm),
                  onPressed: () => [
                        executeFunction(),
                        Modular.to.navigate('/home/'),
                        Navigator.pop(context),
                      ]),
              TextButton(
                  child: Text(cancel),
                  onPressed: () => {
                        Navigator.pop(context),
                      }),
            ],
          ));
}
