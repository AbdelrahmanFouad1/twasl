
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twasl/modules/drawer/menu_controller.dart';
import 'package:twasl/shared/components/components.dart';
import 'package:twasl/shared/style/colors.dart';
import 'package:twasl/shared/style/iconly_broken.dart';

class MenuPageScreen extends StatelessWidget {
  final List<MenuItem> options = [
    MenuItem(Icons.search, 'Search'),
    MenuItem(Icons.shopping_basket, 'Basket'),
    MenuItem(Icons.favorite, 'Discounts'),
    MenuItem(Icons.code, 'Prom-codes'),
    MenuItem(Icons.format_list_bulleted, 'Orders'),
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        //on swiping left
        if (details.delta.dx < -6) {
          Provider.of<MenuController>(context, listen: true).toggle();
        }
      },
      child: Container(
        padding: EdgeInsets.only(
            top: 62,
            left: 32,
            bottom: 8,
            right: MediaQuery.of(context).size.width / 2.9),
        color: defaultColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.only(start: 30.0),
                        child: defaultCircularImage(
                          width: 70.0,
                          height: 70.0,
                          image: NetworkImage(
                              'https://as1.ftcdn.net/v2/jpg/01/71/25/36/500_F_171253635_8svqUJc0BnLUtrUOP5yOMEwFwA8SZayX.jpg'),
                        ),
                      ),
                      SizedBox(height: 16,),
                      Text(
                        'Abd El Rahman Fouad',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'abdofouad.cs@gmail.com',
                        style: Theme.of(context).textTheme.caption!.copyWith(
                          color: Colors.grey[350],
                          fontWeight: FontWeight.bold,
                            height: 0.8,
                        ),
                      ),
                      // SizedBox(height: 16,),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Align(
                alignment: AlignmentDirectional.topStart,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      MaterialButton(
                        onPressed: () {  },
                        padding: EdgeInsets.zero,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                                IconBroken.Home,
                              color: Colors.white,
                            ),
                            SizedBox(width: 5.0,),
                            Text(
                                'Home',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {  },
                        padding: EdgeInsets.zero,
                        child: Row(
                          children: [
                            Icon(
                              IconBroken.Chat,
                              color: Colors.white,
                            ),
                            SizedBox(width: 5.0,),
                            Text(
                              'Chats',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {  },
                        padding: EdgeInsets.zero,
                        child: Row(
                          children: [
                            Icon(
                              IconBroken.Heart,
                              color: Colors.white,
                            ),
                            SizedBox(width: 5.0,),
                            Text(
                              'Favourite',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {  },
                        padding: EdgeInsets.zero,
                        child: Row(
                          children: [
                            Icon(
                              IconBroken.Profile,
                              color: Colors.white,
                            ),
                            SizedBox(width: 5.0,),
                            Text(
                              'Profile',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {  },
                        padding: EdgeInsets.zero,
                        child: Row(
                          children: [
                            Icon(
                              IconBroken.Setting,
                              color: Colors.white,
                            ),
                            SizedBox(width: 5.0,),
                            Text(
                              'Setting',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),
            // Spacer(),
            Expanded(
              child: Align(
                alignment: AlignmentDirectional.bottomStart,
                child: MaterialButton(
                  onPressed: () {  },
                  padding: EdgeInsets.zero,
                  child: Row(
                    children: [
                      Icon(
                        IconBroken.Logout,
                        color: Colors.grey[350],
                      ),
                      SizedBox(width: 5.0,),
                      Text(
                        'Logout',
                        style: TextStyle(
                          color: Colors.grey[350],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuItem {
  String title;
  IconData icon;

  MenuItem(this.icon, this.title);
}
