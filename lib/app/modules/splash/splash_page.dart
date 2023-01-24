import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_books/app/modules/splash/splash_store.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  final store = Modular.get<SplashStore>();
  @override
  void initState() {
    super.initState();
    store.countdownSplash(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFffffff),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Image.asset(
              'lib/assets/images/capa.jpg',
              fit: BoxFit.fill,
              width: 150,
            ),
          ),
        ],
      ),
    );
  }
}
