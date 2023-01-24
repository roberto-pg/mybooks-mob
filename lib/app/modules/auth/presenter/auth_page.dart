// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_books/app/modules/auth/domain/entities/user.dart';
import 'package:my_books/app/modules/auth/external/user_model.dart';
import 'package:my_books/shared/alerts/alert_factory.dart';
import 'package:validatorless/validatorless.dart';

import 'auth_store.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final store = Modular.get<AuthStore>();
  final _formKey = GlobalKey<FormState>();
  bool obscuredTextPassword = true;
  User user = const User(
    id: '',
    email: '',
    password: '',
  );

  @override
  void initState() {
    super.initState();
    store.selectError.listen((event) {
      alertFactory(
        'Falha na autenticação',
        event.message,
        '',
        'Fechar',
        () => {},
      );
    });
    store.selectState.listen((event) {
      Modular.to.pushNamed('/home/');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFffffff),
      appBar: AppBar(
        title: Text(
          'Login',
          style: GoogleFonts.pacifico(
              textStyle: const TextStyle(color: Colors.black45, fontSize: 25)),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(40),
              child: Image.asset(
                'lib/assets/images/capa.jpg',
                fit: BoxFit.fill,
                width: 150,
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 18, horizontal: 40),
                    child: TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.email),
                        labelText: 'Email',
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      onSaved: (text) {
                        user = user.copyWith(email: text);
                      },
                      validator: Validatorless.multiple([
                        Validatorless.required('Informe um email para login'),
                        Validatorless.email('Digite um email válido'),
                      ]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 18, horizontal: 40),
                    child: TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.vpn_key),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              obscuredTextPassword = !obscuredTextPassword;
                            });
                          },
                          icon: Icon(obscuredTextPassword
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                        labelText: 'Password',
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      keyboardType: TextInputType.number,
                      obscureText: obscuredTextPassword,
                      onSaved: (text) => user = user.copyWith(password: text),
                      validator: Validatorless.multiple([
                        Validatorless.required('Informe a senha da sua conta'),
                        Validatorless.min(
                            6, 'A senha deve ter no mínimo 6 caracteres'),
                      ]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 18, horizontal: 40),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size.fromWidth(400),
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: const EdgeInsets.only(top: 15, bottom: 15),
                      ),
                      onPressed: () {
                        var formValid =
                            _formKey.currentState?.validate() ?? false;
                        if (formValid) {
                          _formKey.currentState!.save();
                          Map<String, dynamic> params = UserModel(
                            email: user.email,
                            password: user.password,
                          ).toJson();
                          store.addLogin(params);
                          _formKey.currentState!.reset();
                        }
                      },
                      child: const Text(
                        'Entrar',
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
          ],
        ),
      ),
    );
  }
}
