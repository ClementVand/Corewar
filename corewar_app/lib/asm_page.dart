import 'package:flutter/material.dart';
import 'network/tcp_manager.dart';
import 'file_manager.dart';

class Asm_page extends StatefulWidget {
  const Asm_page({Key? key}) : super(key: key);
  static String message = '';

  @override
  _Asm_PageState createState() => _Asm_PageState();
}

class _Asm_PageState extends State<Asm_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Stack(
          children: [
            HomeScreen(),
            Positioned(
                bottom: 0,
                left: MediaQuery.of(context).size.width / 5,
                child: Row(
                  children: [
                    FlatButton(
                      onPressed: () => {
                        sendRawFile("grossebite", "16", "salut tu suces ?"), // FILENAME // SIZE
                      },
                      child: Text("Compile"),
                      color: Colors.red,
                    ),
                    Padding(
                      child: FlatButton(
                        onPressed: () => {HomeScreen.name.text = '', HomeScreen.prog.text = ''},
                        child: Text("Clear"),
                        color: Colors.red,
                      ),
                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 5),
                    )
                  ],
                )),
          ],
        ),
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static TextEditingController name = TextEditingController();
  static TextEditingController prog = TextEditingController();

  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width,
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: IntrinsicHeight(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                      width: 280,
                      height: 125,
                      padding: EdgeInsetsDirectional.only(top: 60.0),
                      child: TextField(
                        controller: HomeScreen.name,
                        autocorrect: true,
                        decoration: const InputDecoration(hintText: 'Champion Name...', border: OutlineInputBorder()),
                      )),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    height: MediaQuery.of(context).size.height / 1.5,
                    padding: EdgeInsetsDirectional.only(top: 30.0),
                    child: TextField(
                      controller: HomeScreen.prog,
                      decoration: const InputDecoration(hintText: 'Type your code...', border: OutlineInputBorder()),
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
