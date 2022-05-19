import 'package:flutter/material.dart';

import 'sidebar.dart';

class CorewarPage extends StatefulWidget {
  const CorewarPage({Key? key}) : super(key: key);

  _CorewarPageSate createState() => _CorewarPageSate();
}

class _CorewarPageSate extends State<CorewarPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Scaffold(
            drawer: const SideBar(),
            body: Stack(children: const [SideBarButton()]),
          ),
        ),
      );
}
