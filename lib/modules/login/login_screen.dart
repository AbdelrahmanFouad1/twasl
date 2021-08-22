import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twasl/layout/social_layout.dart';
import 'package:twasl/modules/drawer/home_drawer.dart';
import 'package:twasl/modules/login/cubit/cubit.dart';
import 'package:twasl/modules/login/cubit/states.dart';
import 'package:twasl/modules/register/register_screen.dart';
import 'package:twasl/shared/components/components.dart';
import 'package:twasl/shared/components/constant.dart';
import 'package:twasl/shared/network/local/cache_helper.dart';

class LoginScreen extends StatelessWidget {
  final  formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (BuildContext context, state) {
          if(state is LoginSuccessStates){
            LoginCubit.get(context).buttonController.stop();
            CacheHelper.saveData(
              key: 'uId',
              value: state.uId,
            ).then((value) {
              showToast(message: 'Signed in successfully', state: ToastStates.SUCCESS);
              navigateAndFinish(context, MyHomeDrawerPage());
            });
          }else if(state is LoginErrorStates){
            showToast(
                message: state.error,
                state: ToastStates.ERROR
            );
          }
        },
        builder: (BuildContext context, Object? state) {
          var cubit = LoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                            child: Image.asset('assets/images/logo3.png')
                        ),
                        SizedBox(height: 20.0,),
                        defaultTextField(
                          controller: emailController,
                          textInputType: TextInputType.emailAddress,
                          preFix: Icons.email_outlined,
                          label: 'enter email address',
                          border: 20.0,
                          validator: (value) {
                            if (value != null && value.isEmpty) {
                              return 'please enter email address';

                            }
                            if(!(emailRegex.hasMatch(value))){
                              return 'Invalid Email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        defaultTextField(
                          controller: passwordController,
                          textInputType: TextInputType.visiblePassword,
                          preFix: Icons.lock_outline,
                          suffix: cubit.suffix,
                          label: 'enter Your password',
                          border: 20.0,
                          isPassword: cubit.isPassword,
                          suffixPressed: () {
                            cubit.changePasswordVisibility();
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'password must not be empty';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),

                        defaultRoundLoadingButton(
                            controller:  cubit.buttonController,
                            onPress:  (){
                              cubit.rotationPeriod();
                              if ( formKey.currentState!.validate()) {
                                cubit.rotationPeriod();
                                cubit.userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                );
                              }
                            },
                            text: 'Sign In',
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsetsDirectional.only(
                                  start: 40.0,
                                  end: 10.0,
                                ),
                                child: Container(
                                  height: 1.0,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            Text('OR'),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsetsDirectional.only(
                                  start: 10.0,
                                  end: 40.0,
                                ),
                                child: Container(
                                  height: 1.0,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account?',
                              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                                color: Colors.grey
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                navigateTo(context, RegisterScreen());
                              },
                              child: Text('Sign Up'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
