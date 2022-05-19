import 'package:flutter/material.dart';
import 'package:my_app/navBar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Corewar App',
      debugShowCheckedModeBanner: false,
      home: const NavBar(),
    );
  }
}
