import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';

loggedDrawer(
  name,
  Function logout,
  String? allTheBooks,
  String? readBooks,
  String? unreadBooks,
) {
  return Drawer(
    child: ListView(
      children: [
        DrawerHeader(
          padding: EdgeInsets.zero,
          child: Container(
            decoration: const BoxDecoration(color: Colors.blue),
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'lib/assets/images/capa2.jpg',
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                  ),
                  Text(
                    name.toString(),
                    style: GoogleFonts.pacifico(
                      textStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Text(
                    'Minhas leituras',
                    style: GoogleFonts.pacifico(
                      textStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Modular.to.pushNamed('/book/', arguments: 'all');
            Modular.to.pop();
          },
          child: ListTile(
            leading: const Icon(Icons.library_books),
            title: Text('Minha estante', style: GoogleFonts.pacifico()),
            trailing: Text(allTheBooks == null ? '' : '$allTheBooks livros',
                style: GoogleFonts.pacifico()),
          ),
        ),
        GestureDetector(
          onTap: () {
            Modular.to.pushNamed('/book/', arguments: 'read');
            Modular.to.pop();
          },
          child: ListTile(
            leading: const Icon(Icons.check_box),
            title: Text('Livros lidos', style: GoogleFonts.pacifico()),
            trailing: Text(readBooks == null ? '' : '$readBooks livros',
                style: GoogleFonts.pacifico()),
          ),
        ),
        GestureDetector(
          onTap: () {
            Modular.to.pushNamed('/book/', arguments: 'unRead');
            Modular.to.pop();
          },
          child: ListTile(
            leading: const Icon(Icons.check_box_outline_blank),
            title: Text('Livros não lidos', style: GoogleFonts.pacifico()),
            trailing: Text(unreadBooks == null ? '' : '$unreadBooks livros',
                style: GoogleFonts.pacifico()),
          ),
        ),
        GestureDetector(
          onTap: () {
            Modular.to.navigate('/book/addBook');
            Modular.to.pop();
          },
          child: ListTile(
            leading: const Icon(Icons.fiber_new),
            title: Text(
              'Novo livro',
              style: GoogleFonts.pacifico(),
            ),
          ),
        ),
        const Divider(
          color: Colors.black45,
          indent: 16.0,
        ),
        GestureDetector(
          onTap: () {
            logout();
            exit(0);
            // Modular.to.navigate('/');
          },
          child: ListTile(
            title: Text(
              'Logout',
              style: GoogleFonts.pacifico(),
            ),
          ),
        ),
        GestureDetector(
          onTap: () => {
            exit(0),
          },
          child: ListTile(
            title: Text(
              'Fechar',
              style: GoogleFonts.pacifico(),
            ),
          ),
        )
      ],
    ),
  );
}
