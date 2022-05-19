import 'dart:io';

import 'package:corewar_app/file_manager.dart';
import 'package:corewar_app/my_shared_preferences.dart';
import 'package:flutter/services.dart';

void sendRawFile(String filename, String filesize, String filecontent) async {
  Socket clientSocket;
  String? ip = await loadServerIP();
  String? port = await loadServerPort();

  void _sendFileData(Socket socket) {
    socket.write("$filename<SEPARATOR>$filesize");
  }

  void _sendFile(Socket socket) {
    socket.write(filecontent); // CONTENT
  }

  void _callbackHandler(String msg, Socket socket) {
    if (msg == "<GOTCHA>") {
      _sendFile(socket);
      socket.write("<EOS>");
      socket.close();
    }
  }

  void connectToServer(String filename, String filesize) async {
    print("Destination Address: $ip:$port}");

    Socket.connect(ip, int.parse(port.toString()), timeout: const Duration(seconds: 5)).then((socket) {
      clientSocket = socket;

      _sendFileData(socket);
      socket.listen((onData) {
        _callbackHandler(String.fromCharCodes(onData).trim(), socket);
      },
          onDone: () => {
                print("Done !"),
              },
          onError: (e) => {
                print(e.toString()),
              });
    }).catchError((e) {
      print(e.toString());
    });
  }
  connectToServer(filename, filesize);
}
