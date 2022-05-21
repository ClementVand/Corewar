import 'package:corewar_app/network/queue_up.dart';
import 'package:corewar_app/network/cancel_queue.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:corewar_app/sidebar.dart';


class CorewarPage extends StatefulWidget {
  const CorewarPage({Key? key}) : super(key: key);
  static List<String> listChampion = [""];
  static String valueChoose = listChampion[0];
  static bool inQueue = false;

  @override
  _CorewarPageSate createState() => _CorewarPageSate();
}

class _CorewarPageSate extends State<CorewarPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: GestureDetector(
          child: Scaffold(
            drawer: const SideBar(),
            body: Stack(children: const [SideBarButton(), CorewarPageWidgets()]),
          ),
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
        ),
      );
}

class CorewarPageWidgets extends StatefulWidget {
  const CorewarPageWidgets({Key? key}) : super(key: key);

  @override
  State<CorewarPageWidgets> createState() => _CorewarPageWidgetsState();
}

class _CorewarPageWidgetsState extends State<CorewarPageWidgets> {
  late Future<String> message;

  Future<String> readString() async {
    final prefs = await SharedPreferences.getInstance();

    final List<String>? items = prefs.getStringList('Champion');

    if (items != null) {
      CorewarPage.listChampion = items;
    } else {
      CorewarPage.listChampion = [""];
    }
    CorewarPage.valueChoose = CorewarPage.listChampion[0];
    return ("Message");
  }

  @override
  void initState() {
    message = readString();
    super.initState();
  }

  void clearPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final success = await prefs.remove('Champion');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Column(
        children: [
          FlatButton(onPressed: () => queueUp(CorewarPage.valueChoose, context), color: Colors.red, child: const Text("Play")),
          FlatButton(onPressed: () => clearPreferences(), color: Colors.red, child: const Text("Clear")),
          Padding(
            padding: const EdgeInsets.only(top: 200),
            child: Center(
              child: FutureBuilder<String>(
                  future: message,
                  builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                    return (DropdownButton(
                        value: CorewarPage.valueChoose,
                        hint: const Text("No champions created"),
                        onChanged: (newValue) {
                          setState(() {
                            CorewarPage.valueChoose = newValue.toString();
                          });
                        },
                        items: CorewarPage.listChampion.map((valueItem) {
                          return DropdownMenuItem(
                            value: valueItem,
                            child: Text(valueItem),
                          );
                        }).toList()));
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
