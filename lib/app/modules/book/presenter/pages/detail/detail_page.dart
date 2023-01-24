import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_books/app/modules/book/external/book_model.dart';
import 'package:my_books/app/modules/book/presenter/pages/detail/detail_store.dart';
import 'package:my_books/shared/alerts/alert_factory.dart';

class DetailPage extends StatefulWidget {
  final String id;
  const DetailPage({Key? key, required this.id}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailBookState();
}

class _DetailBookState extends State<DetailPage> {
  final store = Modular.get<DetailStore>();
  int _radioValue = 2;

  @override
  void initState() {
    super.initState();
    store.getBookById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Modular.to.navigate('/home/');
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Alterar ou excluir',
            style: TextStyle(
              color: Colors.black45,
              fontFamily: 'Pacifico',
              fontSize: 25,
            )),
      ),
      body: ScopedBuilder<DetailStore, Exception, BookModel>(
        store: store,
        onLoading: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
        onState: (_, book) {
          return Padding(
            padding: const EdgeInsets.only(left: 40, top: 30, right: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.network(book.imageurl,
                    alignment: Alignment.topLeft,
                    fit: BoxFit.cover,
                    width: 140.0),
                const Divider(
                  color: Colors.black38,
                  thickness: 1,
                ),
                Text(
                  book.title,
                  style: GoogleFonts.patrickHandSc(
                    textStyle: const TextStyle(
                      color: Colors.black87,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  book.author,
                  style: GoogleFonts.patrickHandSc(
                    textStyle: const TextStyle(
                      color: Colors.black54,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Text(
                  book.nationality,
                  style: GoogleFonts.patrickHandSc(
                    textStyle: const TextStyle(
                      color: Colors.black54,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Text(
                  book.year.toString(),
                  style: GoogleFonts.patrickHandSc(
                    textStyle: const TextStyle(
                      color: Colors.black54,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Text(
                  book.read == true ? ' Lido ' : ' Não lido ',
                  style: GoogleFonts.patrickHandSc(
                    textStyle: const TextStyle(
                      color: Colors.black87,
                      backgroundColor: Colors.pinkAccent,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const Divider(
                  color: Colors.black38,
                  thickness: 1,
                ),
                Text(
                  'Já leu o livro?',
                  style: GoogleFonts.patrickHandSc(
                    textStyle: const TextStyle(
                      color: Colors.black54,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Text(
                      'Sim',
                      style: GoogleFonts.patrickHandSc(
                        textStyle: const TextStyle(
                          color: Colors.black54,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Radio(
                        value: 1,
                        groupValue: _radioValue,
                        onChanged: (int? value) {
                          setState(() {
                            _radioValue = value!;
                          });
                        }),
                    const SizedBox(width: 20),
                    Text(
                      'Ainda não',
                      style: GoogleFonts.patrickHandSc(
                        textStyle: const TextStyle(
                          color: Colors.black54,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Radio(
                        value: 2,
                        groupValue: _radioValue,
                        onChanged: (int? value) {
                          setState(() {
                            _radioValue = value!;
                          });
                        }),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColorDark,
                          elevation: 4.0,
                        ),
                        onPressed: () {
                          alertFactory(
                            'Confirmação',
                            'Deseja alterar o Status do livro ?',
                            'Sim',
                            'Não',
                            () => store.changeBookStatus(widget.id,
                                (_radioValue == 1 ? 'true' : 'false')),
                          );
                        },
                        child: const Text("Alterar"),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColorDark,
                          elevation: 4.0,
                        ),
                        onPressed: () {
                          alertFactory(
                            'Confirmação',
                            'Confirma a exclusão do livro ?',
                            'Sim',
                            'Não',
                            () => store.deleteBook(widget.id),
                          );
                        },
                        child: const Text("Excluir"),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
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
}
