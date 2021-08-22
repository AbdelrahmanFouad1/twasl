import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twasl/shared/cubit/cubit.dart';
import 'package:twasl/shared/cubit/states.dart';
import 'package:twasl/shared/style/colors.dart';
import 'package:twasl/shared/style/iconly_broken.dart';

class SocialLayout extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              cubit.title[cubit.currentIndex],
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(IconBroken.Notification),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(IconBroken.Search),
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
                          icon: Icon(IconBroken.Heart),
                          label: 'Notification',
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
          floatingActionButtonLocation:  FloatingActionButtonLocation.miniCenterDocked,
           floatingActionButton: Padding(
             padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  FloatingActionButton(
                    backgroundColor: Colors.white,
                    hoverElevation: 10,
                    splashColor: defaultColor,
                    elevation: 4,
                    child: Icon(IconBroken.Paper_Upload,color: Colors.black,),
                    onPressed: () {
                      cubit.changeBottomNav(2);
                    },
                  ),
                  Container(
                    padding: EdgeInsetsDirectional.all(8.0),
                    child: InkWell(
                      onTap: (){
                        cubit.changeBottomNav(2);
                      },
                      child: CircleAvatar(
                        radius: 20.0,
                        backgroundColor: Colors.grey[100],
                        child:  Icon(IconBroken.Paper_Upload,color: Colors.grey[600],),
                      ),
                    ),
                  ),
                ],
              )
           )
        );
      },
    );
  }
}
