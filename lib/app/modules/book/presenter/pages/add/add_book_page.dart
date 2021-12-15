import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_books/app/modules/book/domain/entities/book.dart';
import 'package:my_books/app/modules/book/presenter/pages/add/add_store.dart';
import 'package:my_books/shared/alerts/dialog_factory.dart';
import 'package:validatorless/validatorless.dart';

class AddBookPage extends StatefulWidget {
  const AddBookPage({Key? key}) : super(key: key);

  @override
  _AddBookState createState() => _AddBookState();
}

class _AddBookState extends ModularState<AddBookPage, AddStore> {
  final _formKey = GlobalKey<FormState>();
  File? imageBook;
  Book book = Book(
    title: '',
    author: '',
    nationality: '',
    imageurl: '',
    year: 0,
    read: false,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Modular.to.navigate('/home/');
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text(
          'Meu livro novo',
          style: TextStyle(
            color: Colors.black45,
            fontFamily: 'Pacifico',
            fontSize: 25,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Título',
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  validator: Validatorless.required('Informe o título'),
                  onSaved: (text) {
                    book = book.copyWith(title: text);
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Autor',
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  validator: Validatorless.required('Informe o autor'),
                  onSaved: (text) {
                    book = book.copyWith(author: text);
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'País',
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  validator: Validatorless.required(
                      'Informe a nacionalidade do autor'),
                  onSaved: (text) {
                    book = book.copyWith(nationality: text);
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Ano',
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  validator:
                      Validatorless.required('Informe o ano de lançamento'),
                  onSaved: (text) {
                    book = book.copyWith(
                        year: (text != null) ? int.parse(text) : 0000);
                  },
                ),
                SizedBox(height: 20),
                Row(children: [
                  Text('Escolha uma foto'),
                  Padding(padding: const EdgeInsets.only(right: 50)),
                  Container(
                    width: 50,
                    height: 50,
                    child: OutlinedButton(
                      onPressed: openGallery,
                      child: imageBook == null
                          ? Icon(Icons.camera_alt)
                          : Image.file(imageBook!),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        padding: const EdgeInsets.all(2.0),
                      ),
                    ),
                  )
                ]),
                SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(5),
                      ),
                    ),
                    onPressed: () async {
                      var formValid =
                          _formKey.currentState?.validate() ?? false;
                      if (formValid) {
                        _formKey.currentState!.save();

                        if (imageBook == null) {
                          return dialogFactory(
                            'Falha na operação',
                            'Selecione uma imagem de capa para enviar',
                            '',
                            'Fechar',
                            () => {},
                          );
                        }

                        String filename = imageBook!.path;
                        FormData formData = FormData.fromMap({
                          "title": book.title,
                          "author": book.author,
                          "nationality": book.nationality,
                          "imageurl": await MultipartFile.fromFile(
                            imageBook!.path,
                            filename: filename,
                            // Add lib http_parser para usar MediaType
                            contentType: MediaType('image', 'png'),
                          ),
                          "year": book.year,
                          "read": false,
                        });
                        store.addBook(formData);
                      }
                    },
                    child: const Text(
                      'Salvar',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  openGallery() async {
    try {
      final ImagePicker _picker = ImagePicker();
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1000,
        imageQuality: 100,
      );
      setState(() {
        imageBook = File(image!.path);
      });
    } catch (e) {
      print(e);
    }
  }
}
