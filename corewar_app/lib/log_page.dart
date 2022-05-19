import 'package:flutter/material.dart';

class LogPage extends StatefulWidget {
  const LogPage({Key? key}) : super(key: key);
  static String message = '';

  @override
  _LogPafeState createState() => _LogPafeState();
}

class _LogPafeState extends State<LogPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Text("Je suis les log"),
        ),
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
      ),
    );
  }
}
