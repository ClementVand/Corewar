import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:my_app/corewar_page.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:io';

class Asm_page extends StatefulWidget {
  const Asm_page({Key? key}) : super(key: key);
  static String message = '';

  @override
  _Asm_PageState createState() => _Asm_PageState();
}

class _Asm_PageState extends State<Asm_page> {

  void add_in_string_champ(String newChamp) {
    if (CorewarPage.listChampion[0] == "") {
      CorewarPage.valueChoose = newChamp;
      CorewarPage.listChampion[0] = newChamp;
    }
    for (int i = 0; i < CorewarPage.listChampion.length; i++) {
      if (CorewarPage.listChampion[i] == newChamp) {
        return;
      }
    }
    CorewarPage.listChampion.add(newChamp);
  }

  void buttonPressed() {
    String tmp = "${AsmTextField.name.text}";

    if (AsmTextField.name.text == '' || AsmTextField.prog.text == '') {
      print("Missing element");
    } else {
      AsmTextField.name.text = ("${AsmTextField.name.text}.cor");
      add_in_string_champ(AsmTextField.name.text);
      AsmTextField.name.text = tmp;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child : Stack(
          children: [ AsmTextField(),
            Positioned(bottom: 0, left : MediaQuery.of(context).size.width / 5, child: Row(
            children: [FlatButton(onPressed: () => buttonPressed(), child: Text("Compile"), color: Colors.red,),
            Padding(child : FlatButton(onPressed: () => {AsmTextField.name.text = '', AsmTextField.prog.text = ''}, child: Text("Clear"), color: Colors.red,), padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 5),)],)
            ),],
        ),
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
      ),
    );
  }
}

class AsmTextField extends StatefulWidget {
  const AsmTextField({Key? key}) : super(key: key);
  static TextEditingController name = TextEditingController();
  static TextEditingController prog = TextEditingController();

  _AsmTextFieldState createState() => _AsmTextFieldState();
}

class _AsmTextFieldState extends State<AsmTextField>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
        child : ConstrainedBox(
          constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width,
            minHeight: MediaQuery.of(context).size.height,),
          child : IntrinsicHeight(child : Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                  width: 280,
                  height: 125,
                  padding: EdgeInsetsDirectional.only(top : 60.0),
                  child: TextField(
                    controller: AsmTextField.name,
                    autocorrect: true,
                    decoration: const InputDecoration(hintText: 'Enter Name of file here', border: OutlineInputBorder()),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                    ],
                  )
              ),
              Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: MediaQuery.of(context).size.height / 1.5,
                  padding: EdgeInsetsDirectional.only(top : 30.0),
                  child: TextField(
                    controller: AsmTextField.prog,
                    decoration: const InputDecoration(hintText: 'Enter your prog here', border: OutlineInputBorder()),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                  )
              ),
            ],
          ),
        ),
        ),)
        ));
  }
}


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // This will be displayed on the screen
  String? _content;

  // Find the Documents path
  Future<String> _getDirPath() async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  // This function is triggered when the "Read" button is pressed
  Future<void> _readData() async {
    final dirPath = await _getDirPath();
    final myFile = File('$dirPath/test.txt');
    final data = await myFile.readAsString(encoding: utf8);
    setState(() {
      _content = data;
    });
  }

  // TextField controller
  final _textController = TextEditingController();
  // This function is triggered when the "Write" buttion is pressed
  Future<void> _writeData() async {
    final _dirPath = await _getDirPath();

    final _myFile = File('$_dirPath/test.txt');
    // If data.txt doesn't exist, it will be created automfatically

    await _myFile.writeAsString(_textController.text);
    _textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kindacode.com'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _textController,
              decoration: const InputDecoration(labelText: 'Enter your name'),
            ),
            ElevatedButton(
              child: const Text('Save to file'),
              onPressed: _writeData,
            ),
            const SizedBox(
              height: 150,
            ),
            Text(_content ?? 'Press the button to load your name',
                style: const TextStyle(fontSize: 24, color: Colors.pink)),
            ElevatedButton(
              child: const Text('Read my name from the file'),
              onPressed: _readData,
            )
          ],
        ),
      ),
    );
  }
}
