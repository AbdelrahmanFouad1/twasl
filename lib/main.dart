import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twasl/layout/social_layout.dart';
import 'package:twasl/modules/drawer/home_drawer.dart';
import 'package:twasl/modules/login/login_screen.dart';
import 'package:twasl/modules/on_boarding/on_boarding_screen.dart';
import 'package:twasl/modules/splash/splash_screen.dart';
import 'package:twasl/shared/bloc_observer.dart';
import 'package:twasl/shared/components/constant.dart';
import 'package:twasl/shared/cubit/cubit.dart';
import 'package:twasl/shared/cubit/states.dart';
import 'package:twasl/shared/network/local/cache_helper.dart';
import 'package:twasl/shared/style/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  Bloc.observer = MyBlocObserver();

  await CacheHelper.init();

  Widget widget;
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');

  uId = CacheHelper.getData(key: 'uId');

  if (onBoarding != null) {
    if(uId != null) widget = MyHomeDrawerPage();
    else widget = LoginScreen();
  } else {
    widget = OnBoardingScreen();
  }

  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {

  final Widget startWidget;

  MyApp({
    required this.startWidget,
  });

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context) => AppCubit()..getUserData(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, state) {  },
        builder: (BuildContext context, Object? state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: defaultColor,
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: AppBarTheme(
                titleSpacing: 20.0,
                backwardsCompatibility: false,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark,
                ),
                backgroundColor: Colors.white,
                elevation: 0.0,
                titleTextStyle: TextStyle(
                  fontFamily: 'janna',
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: defaultColor,
                  unselectedItemColor: Colors.grey,
                  elevation: 20.0,
                  backgroundColor: Colors.white),
              textTheme: TextTheme(
                bodyText1: TextStyle(
                  fontFamily: 'janna',
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                subtitle1: TextStyle(
                  fontFamily: 'janna',
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  height: 1.3,
                ),
                caption: TextStyle(
                  fontFamily: 'janna',
                ),
              ),
              fontFamily: 'janna',
            ),
            themeMode: ThemeMode.light,
            home: SplashScreen(startWidget: startWidget,),
          );
        },
      ),
    );
  }
}

