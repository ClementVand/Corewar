import 'package:corewar_app/network/cancel_queue.dart';
import 'package:flutter/material.dart';

class LogPage extends StatefulWidget {
  const LogPage({Key? key}) : super(key: key);
  static String message = '';

  @override
  _LogPageState createState() => _LogPageState();
}

class _LogPageState extends State<LogPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: FlatButton(onPressed: () => cancelQueue(context), color: Colors.red, child: const Text("Cancel")),
        ),
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
      ),
    );
  }
}
