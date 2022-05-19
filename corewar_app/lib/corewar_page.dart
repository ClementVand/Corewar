import 'package:flutter/material.dart';

class CorewarPage extends StatefulWidget {
  const CorewarPage({Key? key}) : super(key: key);
  static List listChampion = [""];
  static String valueChoose = listChampion[0];

  _CorewarPageSate createState() => _CorewarPageSate();
}

class _CorewarPageSate extends State<CorewarPage> {

  void print_selected_champions () {
    print(CorewarPage.valueChoose);
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
            Padding(padding: const EdgeInsets.only(top : 200), child : Center(child :
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
            ),),)
          ],
        ),),
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
    ),
  );
}