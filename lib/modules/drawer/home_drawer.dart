import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twasl/layout/social_layout.dart';
import 'package:twasl/modules/drawer/menu_controller.dart';
import 'package:twasl/modules/drawer/menu_page_screen.dart';

class MyHomeDrawerPage extends StatefulWidget {
  @override
  _MyHomeDrawerPageState createState() => new _MyHomeDrawerPageState();
}

class _MyHomeDrawerPageState extends State<MyHomeDrawerPage> with TickerProviderStateMixin {
  late MenuController menuController;

  @override
  void initState() {
    super.initState();

    menuController = new MenuController(
      vsync: this,
    )..addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    menuController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => menuController ,
      child: SocialLayout(
        menuScreen: MenuPageScreen(),
        contentScreen: Layout(
            contentBuilder: (cc) => Container(
              color: Colors.grey[200],
              child: Container(
                color: Colors.grey[200],
              ),
            )),
      ),
    );
  }
}