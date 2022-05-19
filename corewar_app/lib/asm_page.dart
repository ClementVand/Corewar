import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'corewar_page.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'file_manager.dart';
import 'network/tcp_manager.dart';

class Asm_page extends StatefulWidget {
  const Asm_page({Key? key}) : super(key: key);
  static String message = '';

  @override
  _Asm_PageState createState() => _Asm_PageState();
}

class _Asm_PageState extends State<Asm_page> {
  void writeString() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setStringList('Champion', CorewarPage.listChampion);
  }

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

  void compileButton() {
    String tmp = "${AsmTextField.name.text}";
    int size = AsmTextField.program.text.length;

    sendRawFile(AsmTextField.name.text, AsmTextField.program.text.length.toString(), AsmTextField.program.text);
    if (AsmTextField.name.text == '' || AsmTextField.program.text == '') {
      print("Missing element");
    } else {
      AsmTextField.name.text = ("${AsmTextField.name.text}.cor");
      print("Name of your champion : ${tmp}\nProg of your champ : ${AsmTextField.program.text}\nSize of your prog :${size}");
      add_in_string_champ(AsmTextField.name.text);
      AsmTextField.name.text = tmp;
      writeString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Stack(
          children: [
            AsmTextField(),
            Positioned(
                bottom: 0,
                left: MediaQuery.of(context).size.width / 5,
                child: Row(
                  children: [
                    FlatButton(
                      onPressed: () => compileButton(),
                      child: Text("Compile"),
                      color: Colors.red,
                    ),
                    Padding(
                      child: FlatButton(
                        onPressed: () => {AsmTextField.name.text = '', AsmTextField.program.text = ''},
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

class AsmTextField extends StatefulWidget {
  const AsmTextField({Key? key}) : super(key: key);
  static TextEditingController name = TextEditingController();
  static TextEditingController program = TextEditingController();

  @override
  _AsmTextFieldState createState() => _AsmTextFieldState();
}

class _AsmTextFieldState extends State<AsmTextField> {
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
                        controller: AsmTextField.name,
                        autocorrect: true,
                        decoration: const InputDecoration(hintText: 'Enter Name of file here', border: OutlineInputBorder()),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                        ],
                      )),
                  Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      height: MediaQuery.of(context).size.height / 1.5,
                      padding: EdgeInsetsDirectional.only(top: 30.0),
                      child: TextField(
                        controller: AsmTextField.program,
                        decoration: const InputDecoration(hintText: 'Enter your prog here', border: OutlineInputBorder()),
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
