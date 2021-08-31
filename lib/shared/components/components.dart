import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:twasl/shared/style/colors.dart';
import 'package:twasl/shared/style/iconly_broken.dart';

void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
      (route) => false,
);

Widget myDivider() => Padding(
  padding: const EdgeInsets.symmetric(horizontal: 20.0,),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);

// FocusNode myFocusNode = new FocusNode();
Widget defaultTextField({
  required TextEditingController controller,
  required TextInputType textInputType,
  required IconData preFix,
  FormFieldValidator? validator,
  String? label,
  double? border,
  Color? cursorColor,
  Color? prefixColor,
  IconData? suffix,
  bool isPassword = false,
  Function? suffixPressed,
  GestureTapCallback? onTap,
  Function? onchange,
  Function? onSubmit,
  String? hint,
  TextAlignVertical? textAlignVertical,
  OutlineInputBorder? outlineInputBorder,
  int? numberNumber,
  int? maxLine,
  int? maxLength,

}) => TextFormField(
  keyboardType: textInputType,
  controller: controller,
  obscureText: isPassword,
  cursorColor: cursorColor,
  validator: validator,
  inputFormatters: [
    new LengthLimitingTextInputFormatter(numberNumber??33),
  ],
  textAlignVertical: textAlignVertical,
  onTap: onTap,

  onFieldSubmitted: (s){
    if (onSubmit != null)
      onSubmit(s);
  },
  onChanged: (s){
    if (onchange != null)
      onchange(s);
  },
  decoration: InputDecoration(
    isDense: true,
    labelText: label,
    hintText: hint,
    prefixIcon: Icon(
      preFix,
      color: prefixColor,
    ),
    suffixIcon: suffix != null
        ? IconButton(
        onPressed: (){
          if (suffixPressed != null)
            suffixPressed();
        },
        icon: Icon(
          suffix,
          color: prefixColor,
        ))
        : null,
    focusedBorder: outlineInputBorder,
    focusColor: Colors.black,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(border ?? 10.0),
    ),
    alignLabelWithHint: true,
  ),
);

Widget defaultRoundLoadingButton ({
  required RoundedLoadingButtonController controller,
  required Function onPress,
  required String text,
}) => RoundedLoadingButton(
  color: defaultColor,
  controller: controller,
  onPressed: (){
    onPress();
  },
  child: Text(
      text,
  ),
);


void showToast({
  required String message,
  required ToastStates state,
}) => Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0);

// enum
enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;

  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }

  return color;
}

void defaultSnackBar({
  required BuildContext context,
  required String message,
   String? actionMessage,
}) => ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      action: SnackBarAction(label: actionMessage!, onPressed: ScaffoldMessenger.of(context).hideCurrentSnackBar),
    ));


Widget defaultCircularImage({
  required double width,
  required double height,
  required ImageProvider image,
}) => Container(
  width: width,
  height: height,
  decoration: BoxDecoration(
      shape: BoxShape.circle,
      image: DecorationImage(image: image),
      boxShadow: [
        BoxShadow(
          blurRadius: 10,
          color: Colors.black45,
        )
      ]),
);


