import 'dart:async';

import 'package:flutter/material.dart';
import 'package:twasl/modules/login/login_screen.dart';
import 'package:twasl/modules/on_boarding/on_boarding_screen.dart';
import 'package:twasl/shared/network/local/cache_helper.dart';

class SplashScreen extends StatefulWidget {
  final Widget startWidget;

  const SplashScreen({Key? key, required this.startWidget}) : super(key: key);
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),
            ()=> Navigator.pushReplacement(context,
            MaterialPageRoute(
                builder: (context) => widget.startWidget
            )
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: Center(
        child: Text(
          'Hello',
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
    );
  }
}
