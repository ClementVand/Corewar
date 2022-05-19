import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CorewarPage extends StatefulWidget {
  const CorewarPage({Key? key}) : super(key: key);
  static List<String> listChampion = [""];
  static String valueChoose = listChampion[0];

  _CorewarPageSate createState() => _CorewarPageSate();
}

class _CorewarPageSate extends State<CorewarPage> {
  late Future<String> message;

  Future<String> read_string() async {
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
    message = read_string();
    super.initState();
  }

  void print_selected_champions () {
    print(CorewarPage.valueChoose);
  }

  void clear_preferences() async {
    final prefs = await SharedPreferences.getInstance();
    final success = await prefs.remove('Champion');
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: GestureDetector(
        child :
        Padding(padding: EdgeInsets.only(top: 50), child: Column(
          children: [
            FlatButton(onPressed: () => print_selected_champions(),
              color: Colors.red,
              child: const Text("Play")),
            FlatButton(onPressed: () => clear_preferences(),
                color: Colors.red,
                child: const Text("Clear")),
            Padding(padding: const EdgeInsets.only(top : 200), child :
            Center(child :
                FutureBuilder<String>(
                    future: message, // a previously-obtained Future<String> or null
                    builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                      return (
            DropdownButton(value : CorewarPage.valueChoose,
                hint: const Text("No champions created"),
                onChanged: (newValue) {
                  setState(() {
                    CorewarPage.valueChoose = newValue.toString();
                  });
                }, items: CorewarPage.listChampion.map((valueItem) {
                  return DropdownMenuItem (
                    value: valueItem,
                    child: Text(valueItem),
                  );
                }).toList()
            ));})))
          ],
        ),),
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
    ),
  );
}