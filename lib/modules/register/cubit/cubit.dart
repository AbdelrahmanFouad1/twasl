import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:twasl/models/user_model.dart';
import 'package:twasl/modules/register/cubit/states.dart';
import 'package:twasl/shared/components/components.dart';
import 'package:twasl/shared/network/local/cache_helper.dart';

class RegisterCubit extends Cubit<RegisterStates>{
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(RegisterChangePasswordVisibilityState());
  }

  bool isPassword2 = true;
  IconData suffix2 = Icons.visibility_outlined;
  void changePasswordVisibility2() {
    isPassword2 = !isPassword2;
    suffix2 = isPassword2 ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(RegisterChangePasswordVisibilityState());
  }

  var buttonController = RoundedLoadingButtonController();
  void rotationPeriod() async {
    Timer(Duration(seconds: 3), () {
      buttonController.stop();
      emit(RegisterRotationPeriodState());
    });
  }

  bool checked = false;
  void changeCheck(){
    checked = !checked;
    emit(RegisterChangeCheckState());
  }

  void userCreate({
    required String fullName,
    required String email,
    required String phone,
    required String birthday,
    required String country,
    required String gender,
    required String bio,
    required String uId,
}){
   UserModel model = UserModel(
        fullName: fullName,
        email: email,
        phone: phone,
        birthday: birthday,
        country: country,
        gender: gender,
        bio: bio,
        image: 'https://as1.ftcdn.net/v2/jpg/01/71/25/36/500_F_171253635_8svqUJc0BnLUtrUOP5yOMEwFwA8SZayX.jpg',
        cover: 'https://image.freepik.com/free-photo/greenery-product-background_53876-90824.jpg',
        uId: uId,
    );
    FirebaseFirestore.instance
        .collection('twaslUsers')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(RegisterCreateSuccessStates());
    }).catchError((error) {
      emit(RegisterCreateErrorStates(error.toString()));
    });
  }

  void userRegister({
    required String fullName,
    required String email,
    required String password,
    required String phone,
    required String birthday,
    required String country,
    required String gender,
    required String bio,
  }){
    emit(RegisterLoadingStates());
    FirebaseAuth.instance
    .createUserWithEmailAndPassword(email: email, password: password)
    .then((value) {
      userCreate(
          fullName: fullName,
          email: email,
          phone: phone,
          birthday: birthday,
          country: country,
          gender: gender,
          bio: bio,
          uId: value.user!.uid,
      );
      CacheHelper.saveData(key: 'uId', value: value.user!.uid) ;

      emit(RegisterFinishStates(value.user!.uid));
    }).catchError((error){

    });
  }

  // default background
  // https://image.freepik.com/free-photo/greenery-product-background_53876-90824.jpg

  // default profile image
  // https://as1.ftcdn.net/v2/jpg/01/71/25/36/500_F_171253635_8svqUJc0BnLUtrUOP5yOMEwFwA8SZayX.jpg
  // https://as2.ftcdn.net/v2/jpg/02/17/34/67/500_F_217346782_7XpCTt8bLNJqvVAaDZJwvZjm0epQmj6j.jpg
}