import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:twasl/modules/drawer/menu_controller.dart';
import 'package:twasl/shared/cubit/cubit.dart';
import 'package:twasl/shared/cubit/states.dart';
import 'package:twasl/shared/style/colors.dart';
import 'package:twasl/shared/style/iconly_broken.dart';


class SocialLayout extends StatelessWidget {

  final Widget menuScreen;
  final Layout contentScreen;

  SocialLayout({
    required this.menuScreen,
    required this.contentScreen,
  });


  Curve scaleDownCurve = new Interval(0.0, 0.3, curve: Curves.easeOut);
  Curve scaleUpCurve = new Interval(0.0, 1.0, curve: Curves.easeOut);
  Curve slideOutCurve = new Interval(0.0, 1.0, curve: Curves.easeOut);
  Curve slideInCurve = new Interval(0.0, 1.0, curve: Curves.easeOut);


  zoomAndSlideContent(context, Widget content) {
    var slidePercent, scalePercent;

    switch (Provider.of<MenuController>(context, listen: true)
        .state) {
      case MenuState.closed:
        slidePercent = 0.0;
        scalePercent = 0.0;
        break;
      case MenuState.open:
        slidePercent = 1.0;
        scalePercent = 1.1;
        break;
      case MenuState.opening:
        slidePercent = slideOutCurve.transform(
            Provider
                .of<MenuController>(context, listen: true)
                .percentOpen);
        scalePercent = scaleDownCurve.transform(
            Provider
                .of<MenuController>(context, listen: true)
                .percentOpen);
        break;
      case MenuState.closing:
        slidePercent = slideInCurve.transform(
            Provider
                .of<MenuController>(context, listen: true)
                .percentOpen);
        scalePercent = scaleUpCurve.transform(
            Provider
                .of<MenuController>(context, listen: true)
                .percentOpen);
        break;
    }

    final slideAmount = 248.0 * slidePercent;

    final contentScale = 1.0 - (0.2 * scalePercent);
    final cornerRadius =
        16.0 * Provider
            .of<MenuController>(context, listen: true)
            .percentOpen;

    return new Transform(
      transform: new Matrix4.translationValues(slideAmount, 0.0, 0.0)
        ..scale(contentScale, contentScale),
      alignment: Alignment.centerLeft,
      child: new Container(
        decoration: new BoxDecoration(
          boxShadow: [
            new BoxShadow(
              color: Colors.black12,
              offset: const Offset(0.0, 5.0),
              blurRadius: 16.0,
              spreadRadius: 16.0,
            ),
          ],
        ),
        child: new ClipRRect(
            borderRadius: new BorderRadius.circular(cornerRadius),
            child: content),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpened = MediaQuery.of(context).viewInsets.bottom != 0.0;
    return Stack(
      children: [
        Container(
          child: Scaffold(
            body: this.menuScreen,
          ),
        ),
        zoomAndSlideContent(context, new Container(
          child: new BlocConsumer<AppCubit, AppStates>(
            listener: (context, state) {},
            builder: (context, state) {
              var cubit = AppCubit.get(context);
              return Scaffold(
                  appBar: AppBar(

                    leading: IconButton(
                        icon: Icon(
                          Icons.menu_outlined,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          Provider.of<MenuController>(context, listen: false)
                              .toggle();
                        }) ,
                    title: Text(
                      cubit.title[cubit.currentIndex],
                    ),
                    actions: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(IconBroken.Notification),
                      ),
                    ],
                  ),
                  body: cubit.screen[cubit.currentIndex],
                  bottomNavigationBar: BottomAppBar(
                    shape: CircularNotchedRectangle(),
                    notchMargin: 0.01,
                    clipBehavior: Clip.antiAlias,
                    child: Container(
                      height: kBottomNavigationBarHeight * 0.98,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            top: BorderSide(
                              color: Colors.grey,
                              width: 0.5,
                            ),
                          ),
                        ),
                        child: SingleChildScrollView(
                          physics: NeverScrollableScrollPhysics(),
                          child: BottomNavigationBar(
                            selectedFontSize: 12,
                            onTap: (index) {
                              cubit.changeBottomNav(index);
                            },
                            currentIndex: cubit.currentIndex,
                            items: [
                              BottomNavigationBarItem(
                                  icon: Icon(IconBroken.Home),
                                  label: 'Home'
                                // title: Text('Home'),
                              ),
                              BottomNavigationBarItem(
                                  icon: Icon(IconBroken.Chat),
                                  label: 'Chat'
                                // title: Text('Chat'),
                              ),
                              BottomNavigationBarItem(
                                  activeIcon: null,
                                  icon: Icon(null),
                                  label: ''
                                // title: Text(''),
                              ),
                              BottomNavigationBarItem(
                                icon: Icon(IconBroken.User),
                                label: 'Users',
                                // title: Text('Notification',style: TextStyle(fontSize: 14.0),),
                              ),
                              BottomNavigationBarItem(
                                  icon: Icon(IconBroken.Setting),
                                  label: 'Setting'
                                // title: Text('Setting'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  floatingActionButtonLocation: FloatingActionButtonLocation
                      .miniCenterDocked,
                  floatingActionButton: keyboardIsOpened ? null : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        children: [
                          FloatingActionButton(
                            backgroundColor: Colors.white,
                            hoverElevation: 10,
                            splashColor: defaultColor,
                            elevation: 4,
                            child: Icon(
                              IconBroken.Paper_Upload, color: Colors.black,),
                            onPressed: () {
                              cubit.changeBottomNav(2);
                            },
                          ),
                          Container(
                            padding: EdgeInsetsDirectional.all(8.0),
                            child: InkWell(
                              onTap: () {
                                cubit.changeBottomNav(2);
                              },
                              child: CircleAvatar(
                                radius: 20.0,
                                backgroundColor: Colors.grey[100],
                                child: Icon(IconBroken.Paper_Upload,
                                  color: Colors.grey[600],),
                              ),
                            ),
                          ),
                        ],
                      )
                  )
              );
            },
          ),
        )),
      ],
    );
  }

}

class SocialScaffoldMenuController extends StatefulWidget {
  final SocialScaffoldBuilder builder;

  SocialScaffoldMenuController({
    required this.builder,
  });

  @override
  SocialScaffoldMenuControllerState createState() {
    return new SocialScaffoldMenuControllerState();
  }
}

class SocialScaffoldMenuControllerState
    extends State<SocialScaffoldMenuController> {
  @override
  Widget build(BuildContext context) {
    return widget.builder(
        context, Provider.of<MenuController>(context, listen: true));
  }
}

typedef Widget SocialScaffoldBuilder(BuildContext context,
    MenuController menuController);

class Layout {
  final WidgetBuilder contentBuilder;

  Layout({
    required this.contentBuilder,
  });
}
