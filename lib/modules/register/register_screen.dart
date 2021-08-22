import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gender_picker/gender_picker.dart';
import 'package:gender_picker/source/enums.dart';
import 'package:intl/intl.dart';
import 'package:twasl/layout/social_layout.dart';
import 'package:twasl/modules/drawer/home_drawer.dart';
import 'package:twasl/modules/register/cubit/cubit.dart';
import 'package:twasl/modules/register/cubit/states.dart';
import 'package:twasl/shared/components/components.dart';
import 'package:twasl/shared/components/constant.dart';
import 'package:twasl/shared/network/local/cache_helper.dart';
import 'package:twasl/shared/style/colors.dart';
import 'package:twasl/shared/style/iconly_broken.dart';

class RegisterScreen extends StatelessWidget {
  // final formKey = GlobalKey<FormState>();
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var birthDayController = TextEditingController();
  var addressController = TextEditingController();
  var genderController = TextEditingController();
  var bioController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (BuildContext context, state) {
          if(state is RegisterFinishStates){
            CacheHelper.saveData(
              key: 'uId',
              value: state.uId,
            ).then((value) {
              showToast(message: 'registered successfully', state: ToastStates.SUCCESS);
              navigateAndFinish(context, MyHomeDrawerPage());
            });
          }
        },
        builder: (BuildContext context, Object? state) {
          var cubit = RegisterCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(IconBroken.Arrow___Left_2),
              ),
              title: Text('Create an account'),
              titleSpacing: 0.0,
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      // padding: EdgeInsetsDirectional.only(start: 6.0),
                      child: Text(
                        'First Name',
                        style: Theme.of(context).textTheme.caption!.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                    Container(
                      height: 36,
                      child: defaultTextField(
                        controller: firstNameController,
                        textInputType: TextInputType.text,
                        preFix: Icons.person_outline,
                        hint: 'enter your name',
                        textAlignVertical: TextAlignVertical.bottom,
                        border: 12.0,
                        cursorColor: Colors.black54,
                        prefixColor: Colors.black54,
                        outlineInputBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black54),
                          borderRadius: BorderRadius.circular(12.0),
                        ),

                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Container(
                      // padding: EdgeInsetsDirectional.only(start: 6.0),
                      child: Text(
                        'Last Name',
                        style: Theme.of(context).textTheme.caption!.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                    Container(
                      height: 36,
                      child: defaultTextField(
                        controller: lastNameController,
                        textInputType: TextInputType.text,
                        preFix: Icons.people_outline,
                        hint: 'enter your father name',
                        textAlignVertical: TextAlignVertical.bottom,
                        border: 12.0,
                        cursorColor: Colors.black54,
                        prefixColor: Colors.black54,
                        outlineInputBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black54),
                          borderRadius: BorderRadius.circular(12.0),
                        ),

                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Container(
                      // padding: EdgeInsetsDirectional.only(start: 6.0),
                      child: Text(
                        'Email Address',
                        style: Theme.of(context).textTheme.caption!.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                    Container(
                      height: 36,
                      child: defaultTextField(
                        controller: emailController,
                        textInputType: TextInputType.emailAddress,
                        preFix: Icons.email_outlined,
                        hint: 'example@thing.eg',
                        textAlignVertical: TextAlignVertical.bottom,
                        border: 12.0,
                        cursorColor: Colors.black54,
                        prefixColor: Colors.black54,
                        outlineInputBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black54),
                          borderRadius: BorderRadius.circular(12.0),
                        ),

                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                // padding: EdgeInsetsDirectional.only(start: 6.0),
                                child: Text(
                                  'Phone Number',
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                              Container(
                                height: 36,
                                child: defaultTextField(
                                  controller: phoneController,
                                  textInputType: TextInputType.number,
                                  preFix: Icons.phone_outlined,
                                  hint: 'ex: 1211111',
                                  textAlignVertical: TextAlignVertical.bottom,
                                  border: 12.0,
                                  cursorColor: Colors.black54,
                                  prefixColor: Colors.black54,
                                  numberNumber: 10,
                                  outlineInputBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.black54),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),

                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                // padding: EdgeInsetsDirectional.only(start: 6.0),
                                child: Text(
                                  'Birthday',
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                              Container(
                                height: 36,
                                child: defaultTextField(
                                  controller: birthDayController,
                                  textInputType: TextInputType.datetime,
                                  preFix: Icons.date_range_outlined,
                                  hint: '0000-00-00',
                                  textAlignVertical: TextAlignVertical.bottom,
                                  border: 12.0,
                                  cursorColor: Colors.black54,
                                  prefixColor: Colors.black54,
                                  outlineInputBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.black54),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  onTap: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      lastDate: DateTime.parse('2025-01-01'),
                                      firstDate: DateTime.parse('1900-01-01'),
                                    ).then((value) {
                                      final formatter =
                                          new DateFormat('yyyy-MM-dd');
                                      birthDayController.text =
                                          formatter.format(value!);
                                    });
                                  },

                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                // padding: EdgeInsetsDirectional.only(start: 6.0),
                                child: Text(
                                  'Country',
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                              Container(
                                height: 36,
                                child: defaultTextField(
                                  controller: addressController,
                                  textInputType: TextInputType.text,
                                  preFix: Icons.location_on_outlined,
                                  hint: 'ex: egypt',
                                  textAlignVertical: TextAlignVertical.bottom,
                                  border: 12.0,
                                  cursorColor: Colors.black54,
                                  prefixColor: Colors.black54,
                                  numberNumber: 10,
                                  outlineInputBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.black54),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                // padding: EdgeInsetsDirectional.only(start: 6.0),
                                child: Text(
                                  'Gender',
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                              Container(
                                height: 36,
                                child: defaultTextField(
                                  controller: genderController,
                                  textInputType: TextInputType.text,
                                  preFix: Icons.male_outlined,
                                  hint: 'ex: male',
                                  textAlignVertical: TextAlignVertical.bottom,
                                  border: 12.0,
                                  cursorColor: Colors.black54,
                                  prefixColor: Colors.black54,
                                  outlineInputBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.black54),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  onTap: () {
                                    genderController.text = '';
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        content: GenderPickerWithImage(
                                          showOtherGender: false,
                                          verticalAlignedText: true,
                                          selectedGender: Gender.Others,
                                          selectedGenderTextStyle: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.0,
                                              fontFamily: 'janna'),
                                          unSelectedGenderTextStyle:
                                              TextStyle(
                                                  color: Colors.white,
                                                  fontWeight:
                                                      FontWeight.normal,
                                                  fontFamily: 'janna'),
                                          maleText: 'Male',
                                          femaleText: 'Female',

                                          onChanged: (Gender? gender) {
                                            if (gender.toString() ==
                                                'Gender.Male') {
                                              genderController.text = 'Male';
                                            } else {
                                              genderController.text =
                                                  'Female';
                                            }
                                            Navigator.of(context).pop();
                                          },
                                          equallyAligned: true,
                                          animationDuration:
                                              Duration(milliseconds: 300),
                                          isCircular: true,
                                          // default : true,
                                          opacityOfGradient: 0.2,
                                          padding: const EdgeInsets.all(3),
                                          size: 100.0, //default : 40
                                        ),
                                        backgroundColor: defaultColor,
                                        shape: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      // padding: EdgeInsetsDirectional.only(start: 6.0),
                      child: Text(
                        'Bio',
                        style: Theme.of(context).textTheme.caption!.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                    TextField(
                      controller: bioController,
                      keyboardType: TextInputType.multiline,
                      maxLength: null,
                      maxLines: null,
                      textAlignVertical: TextAlignVertical.center,
                      cursorColor: Colors.black54,
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: 'enter your bio',
                        prefixIcon: Icon(
                          Icons.info_outline,
                          color: Colors.black54,
                        ),
                        contentPadding: const EdgeInsets.all(8.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black54),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        focusColor: Colors.black54,
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Container(
                      // padding: EdgeInsetsDirectional.only(start: 6.0),
                      child: Text(
                        'Password',
                        style: Theme.of(context).textTheme.caption!.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                    Container(
                      height: 36,
                      child: defaultTextField(
                        controller: passwordController,
                        textInputType: TextInputType.visiblePassword,
                        preFix: Icons.lock_outline,
                        hint: 'enter Your password',
                        textAlignVertical: TextAlignVertical.bottom,
                        border: 12.0,
                        numberNumber: 26,
                        cursorColor: Colors.black54,
                        prefixColor: Colors.black54,
                        outlineInputBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black54),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        isPassword: cubit.isPassword,
                        suffix: cubit.suffix,
                        suffixPressed: () {
                          cubit.changePasswordVisibility();
                        },
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Container(
                      // padding: EdgeInsetsDirectional.only(start: 6.0),
                      child: Text(
                        'Confirm Password',
                        style: Theme.of(context).textTheme.caption!.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                    Container(
                      height: 34,
                      child: defaultTextField(
                        controller: confirmPasswordController,
                        textInputType: TextInputType.visiblePassword,
                        preFix: Icons.lock_outline,
                        numberNumber: 26,
                        hint: 'Re-enter the password',
                        textAlignVertical: TextAlignVertical.bottom,
                        border: 12.0,
                        cursorColor: Colors.black54,
                        prefixColor: Colors.black54,
                        outlineInputBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black54),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        isPassword: cubit.isPassword2,
                        suffix: cubit.suffix2,
                        suffixPressed: () {
                          cubit.changePasswordVisibility2();
                        },
                      ),
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: cubit.checked,
                          onChanged: (value) {
                            cubit.changeCheck();
                          },
                        ),
                        Text(
                          'I want to crete an account',
                          style:
                              Theme.of(context).textTheme.caption!.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: cubit.checked,
                          onChanged: (value) {
                            cubit.changeCheck();
                          },
                        ),
                        Text(
                          'I agree with privacy and term',
                          style:
                              Theme.of(context).textTheme.caption!.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    Container(
                      width: double.infinity,
                      height: 34.0,
                      child: MaterialButton(
                        onPressed: () {
                          if(firstNameController.text.isEmpty
                              || lastNameController.text.isEmpty
                              || emailController.text.isEmpty
                              || phoneController.text.isEmpty
                              || birthDayController.text.isEmpty
                              || addressController.text.isEmpty
                              || genderController.text.isEmpty
                              || bioController.text.isEmpty
                              || passwordController.text.isEmpty
                              || confirmPasswordController.text.isEmpty
                          ){
                            defaultSnackBar(
                                context: context,
                                message: 'Please input fill all fields',
                                actionMessage: 'Cancel',
                            );
                            // showToast(message: firstNameController.text +' '+lastNameController.text, state: ToastStates.SUCCESS);
                          }else if (passwordController.text != confirmPasswordController.text){
                            defaultSnackBar(
                                context: context,
                                message: 'Password does not match',
                                actionMessage: 'Cancel',
                            );
                          }else if(cubit.checked != true){
                            defaultSnackBar(
                              context: context,
                              message: 'Please agree with our terms',
                              actionMessage: 'Cancel',
                            );
                          }else{
                            cubit.userRegister(
                                fullName: firstNameController.text +' '+lastNameController.text,
                                email: emailController.text,
                                password: confirmPasswordController.text,
                                phone: phoneController.text,
                                birthday: birthDayController.text,
                                country: addressController.text,
                                gender: genderController.text,
                                bio: bioController.text,
                            );
                          }
                        },
                        child: Text(
                          'Register',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          12.0,
                        ),
                        color: defaultColor,
                      ),
                    ),
                    SizedBox(
                      height: 18,
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
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(color: Colors.grey),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Sign In'),
                        ),

                      ],
                    ),
                    // SizedBox(height: 10.0,),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
