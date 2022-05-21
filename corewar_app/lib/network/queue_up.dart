import 'dart:io';

import 'package:corewar_app/my_shared_preferences.dart';
import 'package:corewar_app/navpages/corewar_page.dart';
import 'package:corewar_app/navpages/navBar.dart';

import '../navpages/asm_page.dart';

Future queueUp(String name, context) async {
  final authController = AuthController();
  String? ip = await loadServerIP();
  String? port = await loadServerPort();
  String? uuid = await loadUUID();

  if (name == "") {
    showSnackBar(context, "No champion selected !");
    return;
  }
  if (CorewarPage.inQueue == true) {
    showSnackBar(context, "Already in queue !");
    return;
  }
  if (await authController.tryUuid() == false) {
    await AuthController.genUuid();
  }

  void _sendData(Socket socket) async {
    print("HELLO SERVER");
    socket.write("<QUEUEUP><SEPARATOR>$name<SEPARATOR>$uuid");
  }

  Future<void> _callbackHandler(String msg, Socket socket) async {
    print(msg);
    if (msg.contains("<GOTCHA>")) {
      CorewarPage.inQueue = true;
      showSnackBar(context, "You joined the queue");
    }
    if (msg == "<WAITING>") {
      print("Waiting");
    }
    if (msg.contains("<CANCELQ>")) {
      CorewarPage.inQueue = false;
      socket.close();
    }
    if (msg.contains("<NOCHAMP>")) {
      showSnackBar(context, "$name not in database ! Compile it first !");
      socket.close();
    }
    if (msg.contains("<WON>")) {
      CorewarPage.inQueue = false;
      showSnackBar(context, "You won !!! :D");
      socket.close();
    }
    if (msg.contains("<LOST>")) {
      CorewarPage.inQueue = false;
      showSnackBar(context, "You lost !!! :(");
      socket.close();
    }
    if (msg.contains("<ERROR>")) {
      socket.close();
    }
  }

  void connectToServer() async {

    Socket.connect(ip, int.parse(port.toString()), timeout: const Duration(seconds: 5)).then((socket) {
      if (CorewarPage.inQueue == false) {
        _sendData(socket);
      }
      socket.listen((onData) async {
        await _callbackHandler(String.fromCharCodes(onData).trim(), socket);
      },
          onDone: () => {
            print("Done !"),
            socket.close(),
          },
          onError: (e) => {
            print(e.toString()),
            socket.close(),
          });
    }).catchError((e) {
      showSnackBar(context, "Can't reach the host ($ip:$port)");
      print(e.toString());
    });
  }
  connectToServer();
}