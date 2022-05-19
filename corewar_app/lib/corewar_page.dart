import 'package:flutter/material.dart';

class CorewarPage extends StatefulWidget {
  const CorewarPage({Key? key}) : super(key: key);

  _CorewarPageSate createState() => _CorewarPageSate();
}

class _CorewarPageSate extends State<CorewarPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
    body: GestureDetector(
      child: Center(
        child: Row(
          children: [Text("Je suis le corewar"),
            FlatButton(onPressed: () => {},
              child: Text("Play"),
              color: Colors.red),
          ],
        ),
      ),
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
    ),
  );
}