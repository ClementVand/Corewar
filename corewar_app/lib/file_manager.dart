import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';

Future<String> _getDirPath() async {
  final dir = await getApplicationDocumentsDirectory();
  return dir.path;
}

Future<String> readData(String filename) async {
  final dirPath = await _getDirPath();
  final myFile = File('$dirPath/$filename.txt');
  final data = await myFile.readAsString(encoding: utf8);

  return (data);
}

final _textController = TextEditingController();
Future<void> writeData(String filename, String content) async {
  final _dirPath = await _getDirPath();

  final _myFile = File('$_dirPath/$filename.txt');

  // await _myFile.writeAsString(_textController.text);
  await _myFile.writeAsString(content);
  _textController.clear();
}