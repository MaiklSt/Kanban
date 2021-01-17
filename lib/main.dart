import 'package:flutter/material.dart';
import 'package:kanban_app/pages/registr_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kanban App',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF000000),
        primaryColor: const Color(0xFF222220),
      ),
      home: RegistrPage(),
      //home: RegistrPage(),
    );
  }
}
