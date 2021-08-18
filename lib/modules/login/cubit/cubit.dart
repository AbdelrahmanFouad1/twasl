import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:twasl/modules/login/cubit/states.dart';

class LoginCubit extends Cubit<LoginStates>{
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
    isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(LoginChangePasswordVisibilityState());
  }

  var buttonController = RoundedLoadingButtonController();

  void rotationPeriod() async {
    Timer(Duration(seconds: 3), () {
      buttonController.stop();
      emit(LoginRotationPeriodState());
    });
  }

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingStates());

    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
    ).then((value) {
      // print(value.user!.uid);
      emit(LoginSuccessStates(value.user!.uid));
    }).catchError((error){
      emit(LoginErrorStates(error.toString()));
    });
  }

}