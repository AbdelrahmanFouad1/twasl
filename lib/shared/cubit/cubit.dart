import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twasl/modules/add_posts/add_posts_screen.dart';
import 'package:twasl/modules/chats/chats_screen.dart';
import 'package:twasl/modules/feeds/feeds_screen.dart';
import 'package:twasl/modules/notifications/notifications_screen.dart';
import 'package:twasl/modules/setting/settings_screen.dart';
import 'package:twasl/shared/cubit/states.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screen =[
    FeedsScreen(),
    ChatsScreen(),
    AddPostsScreen(),
    NotificationsScreen(),
    SettingsScreen(),
  ];

  List<String> title = [
    'Feeds',
    'Chats',
    'Post',
    'Notifications',
    'Setting',
  ];

  void changeBottomNav(int index) {

      currentIndex = index;
      emit(AppChangeBottomNavState());
  }

}