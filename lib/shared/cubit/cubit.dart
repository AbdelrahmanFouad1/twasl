import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:twasl/models/comment_model.dart';
import 'package:twasl/models/post_model.dart';
import 'package:twasl/models/user_model.dart';
import 'package:twasl/modules/add_posts/add_posts_screen.dart';
import 'package:twasl/modules/chats/chats_screen.dart';
import 'package:twasl/modules/feeds/feeds_screen.dart';
import 'package:twasl/modules/notifications/notifications_screen.dart';
import 'package:twasl/modules/setting/settings_screen.dart';
import 'package:twasl/shared/components/constant.dart';
import 'package:twasl/shared/cubit/states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

// Layout Screen
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
    'Create Post',
    'Notifications',
    'Setting',
  ];

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavState());
  }

  //Main
  late UserModel userModel;

  void getUserData() {
    emit(AppGetUserLoadingState());

    FirebaseFirestore.instance
        .collection('twaslUsers')
        .doc(uId)
        .get()
        .then((value) {
      // print(value.data());
      userModel = UserModel.fromJson(value.data());
      // profileImage = null;
      // coverImage = null;
      emit(AppGetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(AppGetUserErrorState(error.toString()));
    });
  }

  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];
  List<int> commentsNum = [];
  List<CommentModel> comments = [];

  void getPostsData() {
    emit(AppGetPostsLoadingState());

    FirebaseFirestore.instance.collection('twaslPosts').get().then((value) {
      value.docs.forEach((element) {

        element.reference.collection('likes').get().then((value) {
          element.reference.collection('comments').get().then((value) {
            likes.add(value.docs.length);
            postsId.add(element.id);
            posts.add(PostModel.fromJson(element.data()));
            commentsNum.add(value.docs.length);
            emit(AppGetPostsSuccessState());
          }).catchError((error) {});
        }).catchError((error) {});

      });
    }).catchError((error) {
      print(error.toString());
      emit(AppGetPostsErrorState(error.toString()));
    });


  }

// AddPostScreen Screen
  File? postImage;
  var picker = ImagePicker();

  Future<void> pikePostImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(AppPostImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(AppPostImagePickedErrorState());
    }
  }

  Future<void> removePikePostImage() async {
    // await DefaultCacheManager().emptyCache();

    postImage = null;
    emit(AppRemovePikePostImageSuccessState());
  }

  bool isTag = false;
  String tagName = 'tag';

  void changeTagText() {
    isTag = !isTag;
    tagName = isTag ? 'hide tag' : 'tag';
    emit(AppChangeTagState());
  }

  void createPost({
    required String dateTime,
    required String body,
    String? tags,
    String? postId,
    String? postImage,
  }) {
    emit(AppCreatePostLoadingState());

    PostModel model = PostModel(
      name: userModel.fullName,
      uId: userModel.uId,
      postId: postId ?? '',
      image: userModel.image,
      dateTime: dateTime,
      body: body,
      tags: tags ?? '',
      postImage: postImage ?? '',
    );

    FirebaseFirestore.instance
        .collection('twaslPosts')
        .add(model.toMap())
        .then((value) {
      emit(AppCreatePostSuccessState());
    }).catchError((error) {
      emit(AppCreatePostErrorState());
    });
  }

  void uploadPost({
    required String dateTime,
    required String body,
    String? tags,
  }) {
    emit(AppCreatePostLoadingState());
    if (postImage != null) {
      firebase_storage.FirebaseStorage.instance
          .ref()
          .child('twaslPosts/${Uri.file(postImage!.path).pathSegments.last}')
          .putFile(postImage!)
          .then((value) {
        value.ref.getDownloadURL().then((value) {
          print(value);
          createPost(
            dateTime: dateTime,
            postImage: value,
            body: body,
            tags: tags,
          );
        }).catchError((error) {
          emit(AppCreatePostErrorState());
        });
      }).catchError((error) {
        emit(AppCreatePostErrorState());
      });
    } else {
      createPost(
        dateTime: dateTime,
        body: body,
        tags: tags,
      );
    }
  }

  //feeds screen
  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('twaslPosts')
        .doc(postId)
        .collection("likes")
        .doc(userModel.uId)
        .set({
      'like': true,
    }).then((value) {
      emit(AppLikePostsSuccessState());
    }).catchError((error) {
      emit(AppLikePostsErrorState(error.toString()));
    });
  }

  void commentPost({
    required String dateTime,
    required String text,
    required String postId,
  }) {

    emit(AppCommentPostsLoadingState());

    CommentModel model = CommentModel(
      name: userModel.fullName,
      uId: userModel.uId,
      image: userModel.image,
      dateTime: dateTime,
      text: text,
    );

    FirebaseFirestore.instance
        .collection('twaslPosts')
        .doc(postId)
        .collection("comments")
        .add(model.toMap())
        .then((value) {
      emit(AppCommentPostsSuccessState());
    }).catchError((error) {
      emit(AppCommentPostsErrorState(error.toString()));
    });
  }


  void getCommentData(dynamic index){

    comments.clear();
    FirebaseFirestore.instance.collection('twaslPosts').doc(postsId[index]).collection('comments')
        .get()
        .then((value) {
      commentsNum.add(value.docs.length);
      value.docs.forEach((element) {
        comments.add(CommentModel.fromJson(element.data()));
        emit(AppGetCommentSuccessState());
      });
    }).catchError((error) {
      emit(AppGetCommentErrorState(error.toString()));
    });
  }
}