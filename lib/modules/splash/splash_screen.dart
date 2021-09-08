import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:twasl/modules/login/login_screen.dart';
import 'package:twasl/modules/on_boarding/on_boarding_screen.dart';
import 'package:twasl/shared/network/local/cache_helper.dart';
import 'package:twasl/shared/style/colors.dart';

class SplashScreen extends StatefulWidget {
  final Widget startWidget;

  const SplashScreen({Key? key, required this.startWidget}) : super(key: key);
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  void initState() {
    super.initState();
    Timer(Duration(seconds: 3,),
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
     appBar: new AppBar(
       brightness: Brightness.light,
       systemOverlayStyle: SystemUiOverlayStyle(
         statusBarColor: defaultColor,
         statusBarIconBrightness: Brightness.light,
       ),
       backgroundColor: defaultColor,
     ),
      body: Container(
        color: defaultColor,
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
                child: Align(
                  alignment: AlignmentDirectional.bottomCenter,
                    child: Image.asset('assets/images/whiteLogo.png')
                )
            ),
            SizedBox(height: 6.0,),
            Text(
              'T W A S L',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 32.0,
              ),
            ),

            Expanded(
              flex: 2,
              child: Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: Text(
                    'Copyright © 2021 twasl. All rights reserved',
                  style: Theme.of(context).textTheme.caption!.copyWith(
                    color: Colors.white,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        )
      ),
    );
  }
}

// Theme(
// data: ThemeData(
// appBarTheme: AppBarTheme(
// backwardsCompatibility: false,
// systemOverlayStyle: SystemUiOverlayStyle(
// statusBarColor: defaultColor,
// statusBarIconBrightness: Brightness.light,
// ),
// backgroundColor: defaultColor,
// elevation: 0.0,
// ),
// ),
// child: Scaffold(
// backgroundColor: Colors.white,
// body: Container(
// color: defaultColor,
// ),
// ),
// )