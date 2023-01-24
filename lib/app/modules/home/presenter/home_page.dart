// ignore_for_file: library_private_types_in_public_api

import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_books/app/modules/home/external/total_book_model.dart';

import 'home_store.dart';
import 'widgets/logged_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final store = Modular.get<HomeStore>();
  @override
  void initState() {
    super.initState();
    store.getTotalBooksByRead();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedBuilder<HomeStore, Exception, TotalBookModel>(
      store: store,
      onState: (_, totalForDrawer) {
        return Scaffold(
          backgroundColor: const Color(0xFFffffff),
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Minha biblioteca',
              style: GoogleFonts.pacifico(
                textStyle: const TextStyle(
                  color: Colors.black45,
                  fontSize: 25,
                ),
              ),
            ),
          ),
          drawer: loggedDrawer(
            totalForDrawer.name,
            store.logoutUser,
            totalForDrawer.allBooks,
            totalForDrawer.readBooks,
            totalForDrawer.unreadBooks,
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  AnimatedCard(
                    direction: AnimatedCardDirection.left,
                    duration: const Duration(milliseconds: 1500),
                    child: const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: Text('Lista' '\n' 'de' '\n' 'leitura',
                            style: TextStyle(
                              color: Colors.black54,
                              fontFamily: 'Pacifico',
                              fontSize: 40,
                            )),
                      ),
                    ),
                  ),
                  AnimatedCard(
                    direction: AnimatedCardDirection.right,
                    duration: const Duration(milliseconds: 1500),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Image.asset(
                          'lib/assets/images/capa.jpg',
                          fit: BoxFit.fill,
                          width: 150,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
