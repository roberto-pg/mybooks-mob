import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_books/app/modules/book/external/book_model.dart';

import 'book_store.dart';

class BookPage extends StatefulWidget {
  final String read;
  const BookPage({Key? key, required this.read}) : super(key: key);
  @override
  BookPageState createState() => BookPageState();
}

class BookPageState extends State<BookPage> {
  final store = Modular.get<BookStore>();
  String? title;
  @override
  void initState() {
    super.initState();
    loadTitle();
    if (widget.read == 'all') {
      store.getBooks();
      return;
    }
    if (widget.read == 'read') {
      store.getBooksRead(true);
      return;
    }
    if (widget.read == 'unRead') {
      store.getBooksRead(false);
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title!,
            style: const TextStyle(
              color: Colors.black45,
              fontFamily: 'Pacifico',
              fontSize: 25,
            )),
      ),
      body: ScopedBuilder<BookStore, Exception, List<BookModel>>(
        store: store,
        onLoading: (context) =>
            const Center(child: CircularProgressIndicator.adaptive()),
        onState: (_, books) {
          if (books.isEmpty) {
            return Container();
          }
          return ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onLongPress: () {
                      Modular.to
                          .navigate('./detail', arguments: books[index].id);
                    },
                    child: Card(
                      elevation: 5.0,
                      shadowColor: Colors.blue,
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(5),
                                child: Image.network(
                                  books[index].imageurl,
                                  alignment: Alignment.topLeft,
                                  fit: BoxFit.cover,
                                  width: 80.0,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Text(
                                        books[index].title,
                                        style: GoogleFonts.patrickHandSc(
                                            textStyle: const TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Text(
                                        books[index].year.toString(),
                                        style: GoogleFonts.patrickHandSc(
                                            textStyle: const TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Text(
                                        books[index].author,
                                        style: GoogleFonts.patrickHandSc(
                                            textStyle: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                          books[index].read == true
                                              ? 'Lido'
                                              : 'Não lido',
                                          style: const TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.black,
                                              backgroundColor: Colors.red,
                                              fontStyle: FontStyle.italic)),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              });
        },
        onError: (context, error) => Center(
          child: Text(
            'Falha na autenticação\n\nReinicie o aplicativo',
            style: GoogleFonts.roboto(
                textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            )),
          ),
        ),
      ),
    );
  }

  loadTitle() {
    if (widget.read == 'all') {
      title = 'Todos os meus livros';
      return;
    }
    if (widget.read == 'read') {
      title = 'Livros lidos';
      return;
    }
    if (widget.read == 'unRead') {
      title = 'Livros que lerei';
      return;
    }
    setState(() {
      title = title;
    });
  }
}
