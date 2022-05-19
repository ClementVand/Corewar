import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child : Stack(
          children: [
            Positioned(child: AsmNameFileTextField(), top: 50, left: 25, width: MediaQuery.of(context).size.width / 1.2, height: 100,),
            Positioned(child: AsmTextFieldProg(), top: 150, left: 0, width: 50, height: 50,),
            Positioned(bottom: 0, child: Row(
            children: [Padding(child: FlatButton(onPressed: () => {print(AsmTextFieldProg.controller.text)}, child: Text("Compile"), color: Colors.red,), padding: EdgeInsets.symmetric(horizontal: 55),),
            Padding(child: FlatButton(onPressed: () => {AsmTextFieldProg.controller.text = ''}, child: Text("Clear"), color: Colors.red,), padding : EdgeInsets.symmetric(horizontal: 50))],)
            ),],
        ),
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
      ),
    );
  }
}

class AsmTextFieldProg extends StatefulWidget {
  const AsmTextFieldProg({Key? key}) : super(key: key);
  static String message = '';
  static TextEditingController controller = TextEditingController();

  @override
  _AsmTextFieldProgState createState() => _AsmTextFieldProgState();
}

class _AsmTextFieldProgState extends State<AsmTextFieldProg> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child : Stack(
          children: [TextField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              controller: AsmTextFieldProg.controller,
            ),
          ],
        ),
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
      ),
    );
  }
}

class AsmNameFileTextField extends StatefulWidget {
  const AsmNameFileTextField({Key? key}) : super(key: key);
  static String message = '';
  static TextEditingController controller = TextEditingController();

  @override
  _AsmNameFileTextFieldState createState() => _AsmNameFileTextFieldState();
}

class _AsmNameFileTextFieldState extends State<AsmNameFileTextField> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child : Stack(
          children: [
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Name of File',
              ),
              keyboardType: TextInputType.multiline,
              maxLines: null,
              controller: AsmTextFieldProg.controller,
            ),
          ],
        ),
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
      ),
    );
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
