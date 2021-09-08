import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:twasl/models/comment_model.dart';
import 'package:twasl/models/message_model.dart';
import 'package:twasl/models/post_model.dart';
import 'package:twasl/models/user_model.dart';
import 'package:twasl/modules/add_posts/add_posts_screen.dart';
import 'package:twasl/modules/chats/chats_screen.dart';
import 'package:twasl/modules/feeds/feeds_screen.dart';
import 'package:twasl/modules/notifications/notifications_screen.dart';
import 'package:twasl/modules/setting/settings_screen.dart';
import 'package:twasl/modules/user_chats/userChatsScreen.dart';
import 'package:twasl/shared/components/constant.dart';
import 'package:twasl/shared/cubit/states.dart';
import 'package:twasl/shared/network/local/cache_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

// Layout Screen
  int currentIndex = 0;

  List<Widget> screen =[
    FeedsScreen(),
    UserChatsScreen(),
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
    if (index == 0) {
      getAllPostsData();
      currentIndex = index;
    }
    else if (index == 1) {
      getAllPostsData();
      getAllUser();
      currentIndex = index;
    }
    else if (index == 4) {
      getAllPostsData();
      currentIndex = index;
    }
    else{
      currentIndex = index;
      emit(AppChangeBottomNavState());
    }

  }

  //Main
  late UserModel userModel;

  void getUserData() {
    emit(AppGetUserLoadingState());

    uId = CacheHelper.getData(key: 'uId');
    FirebaseFirestore.instance
        .collection('twaslUsers')
        .doc(uId)
        .get()
        .then((value) {
      userModel = UserModel.fromJson(value.data());

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

  void getAllPostsData() {
    emit(AppGetAllPostsLoadingState());

    FirebaseFirestore.instance.collection('twaslPosts').orderBy('time').get().then((value) {
      value.docs.forEach((element) {
        posts = [];
        likes =[];
        commentsNum =[];
        element.reference.collection('likes').get().then((value1) {
          element.reference.collection('comments').get().then((value) {
            likes.add(value1.docs.length);
            postsId.add(element.id);
            posts.add(PostModel.fromJson(element.data()));
            commentsNum.add(value.docs.length);
            emit(AppGetAllPostsSuccessState());
          }).catchError((error) {});
        }).catchError((error) {});

      });
    }).catchError((error) {
      print(error.toString());
      emit(AppGetAllPostsErrorState(error.toString()));
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
    required String time,
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
      time: time,
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
    required String time,
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
            time: time,
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
        time: time,
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

    FirebaseFirestore.instance
        .collection('twaslPosts')
        .doc(postsId[index])
        .collection('comments')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      commentsNum.add(event.docs.length);
      comments = [];
      event.docs.forEach((element) {
        comments.add(CommentModel.fromJson(element.data()));
        emit(AppGetCommentSuccessState());
      });
    });
  }

  //UserChatsScreen

  List<UserModel> user = [];
  void getAllUser() {
    if (user.length == 0)
      FirebaseFirestore.instance.collection('twaslUsers').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uId'] != uId)
            user.add(UserModel.fromJson(element.data()));
        });
        emit(AppGetPostsSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(AppGetPostsErrorState(error.toString()));
      });
  }

  //ChatsScreen
  void sendMessage({
    required String receiverId,
    required String dateTime,
    required String text,
    String? image,
  }) {
    MessageModel model = MessageModel(
        senderId: userModel.uId,
        receiverId: receiverId,
        dateTime: dateTime,
        text: text,
        image: image ?? '',
    );

    // set my chats
    FirebaseFirestore.instance
        .collection('twaslUsers')
        .doc(userModel.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(AppSendMessageSuccessState());
    }).catchError((error) {
      emit(AppSendMessageErrorState());
    });

    // set receiver chats
    FirebaseFirestore.instance
        .collection('twaslUsers')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel.uId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(AppSendMessageSuccessState());
    }).catchError((error) {
      emit(AppSendMessageErrorState());
    });
  }

  List<MessageModel> message = [];

  void getMessage({
    required String receiverId,
  }) {
    FirebaseFirestore.instance
        .collection('twaslUsers')
        .doc(userModel.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      message = [];
      event.docs.forEach((element) {
        message.add(MessageModel.fromJson(element.data()));
      });
      emit(AppGetMessagesSuccessState());
    });
  }

  //Setting Screen

  void getPostsData() {
    emit(AppGetPostsLoadingState());

    FirebaseFirestore.instance.collection('twaslPosts').orderBy('time').get().then((value) {
      value.docs.forEach((element) {
        posts = [];
        likes =[];
        commentsNum =[];
        element.reference.collection('likes').get().then((value1) {
          element.reference.collection('comments').get().then((value) {
            likes.add(value1.docs.length);
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
}


// default background
// https://image.freepik.com/free-photo/greenery-product-background_53876-90824.jpg

// default profile image
// https://as1.ftcdn.net/v2/jpg/01/71/25/36/500_F_171253635_8svqUJc0BnLUtrUOP5yOMEwFwA8SZayX.jpg
// https://as2.ftcdn.net/v2/jpg/02/17/34/67/500_F_217346782_7XpCTt8bLNJqvVAaDZJwvZjm0epQmj6j.jpg