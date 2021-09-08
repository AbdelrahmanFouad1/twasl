import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shimmer/shimmer.dart';
import 'package:twasl/models/post_model.dart';
import 'package:twasl/modules/comments/comments_screen.dart';
import 'package:twasl/shared/cubit/cubit.dart';
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

Widget buildPostItem (PostModel model, context, index) => Builder(
  builder: (BuildContext context) {
    var currentTime = model.time;
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 8.0,
      margin: EdgeInsets.symmetric(horizontal: 8.0,),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25.0,
                  backgroundImage: NetworkImage('${model.image}'),
                ),
                SizedBox(width: 15.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${model.name}',
                            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                                height: 1.4
                            ),
                          ),
                          SizedBox(width: 5.0,),
                          Icon(
                            Icons.check_circle,
                            color: defaultColor,
                            size: 16.0,
                          ),
                        ],
                      ),
                      Text(
                        '${model.dateTime}',
                        style: Theme.of(context).textTheme.caption!.copyWith(height: 1.4,),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 15.0,),
                IconButton(
                  onPressed: (){},
                  icon: Icon(
                    IconBroken.More_Square,
                    size: 18.0,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0,),
              child: Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey,
              ),
            ),
            Text(
              '${model.body}',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            if(model.tags != '')
              Container(
                width: double.infinity,
                child: Wrap(
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 6.0,),
                      child: Container(
                        height: 20.0,
                        child: MaterialButton(
                          onPressed: (){},
                          minWidth: 1.0,
                          padding: EdgeInsets.zero,
                          child: Text(
                            '#${model.tags}',
                            style: Theme.of(context).textTheme.caption!.copyWith(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            if(model.postImage != '')
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 5.0, top: 15.0,
                ),
                child: Container(
                  width: double.infinity,
                  height: 140.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    image: DecorationImage(
                      image: NetworkImage('${model.postImage}'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0,),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Row(
                          children: [
                            Icon(
                              IconBroken.Heart,
                              size: 18.0,
                              color: Colors.red,
                            ),
                            SizedBox(width: 5.0,),
                            Text(
                              '${AppCubit.get(context).likes[index]}',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                      ),
                      onTap: (){},
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              IconBroken.Chat,
                              size: 18.0,
                              color: Colors.amber,
                            ),
                            SizedBox(width: 5.0,),
                            Text(
                              '${AppCubit.get(context).commentsNum[index]} comment',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                      ),
                      onTap: (){},
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 18.0,
                          backgroundImage: NetworkImage(
                              '${AppCubit.get(context).userModel.image}'
                          ),
                        ),
                        SizedBox(width: 15.0),
                        Text(
                          'Write a comment ...',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                    onTap: (){
                      AppCubit.get(context).getCommentData(index);
                      navigateTo(context, CommentsScreen(postIndex: index,));
                    },
                  ),
                ),
                InkWell(
                  child: Row(
                    children: [
                      Icon(
                        IconBroken.Heart,
                        size: 18.0,
                        color: Colors.red,
                      ),
                      SizedBox(width: 5.0,),
                      Text(
                        'Like',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                  onTap: (){
                    AppCubit.get(context).likePost(AppCubit.get(context).postsId[index]);
                    AppCubit.get(context).getAllPostsData();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  },
);

Widget buildPostShimmerItem ( context) => Builder(
  builder: (BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 8.0,
      margin: EdgeInsets.symmetric(horizontal: 8.0,),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Shimmer.fromColors(
                  highlightColor: highlightColor,
                  baseColor: baseColor,
                  child: CircleAvatar(
                    radius: 25.0,
                    backgroundColor: baseColor,
                  ),
                ),
                SizedBox(width: 15.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Shimmer.fromColors(
                        child: Container(
                          height: 14.0,
                          width: double.infinity,
                          color: baseColor,
                        ),
                        baseColor: baseColor,
                        highlightColor:highlightColor,
                      ),
                      SizedBox(height: 2.0,),
                      Shimmer.fromColors(
                        child: Container(
                          height: 14.0,
                          width: double.infinity,
                          color: baseColor,
                        ),
                        baseColor: baseColor,
                        highlightColor:highlightColor,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 15.0,),
                Shimmer.fromColors(
                  highlightColor: highlightColor,
                  baseColor: baseColor,
                  child: IconButton(
                    onPressed: (){},
                    icon: Icon(
                      IconBroken.More_Square,
                      size: 18.0,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0,),
              child: Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Shimmer.fromColors(
                child: Container(
                  height: 16.0,
                  width: double.infinity,
                  color: baseColor,
                ),
                baseColor: baseColor,
                highlightColor:highlightColor,
              ),
            ),
            SizedBox(height: 5.0,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Shimmer.fromColors(
                child: Container(
                  height: 16.0,
                  width: double.infinity,
                  color: baseColor,
                ),
                baseColor: baseColor,
                highlightColor:highlightColor,
              ),
            ),
            SizedBox(height: 10.0,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Shimmer.fromColors(
                child: Container(
                  height: 160.0,
                  width: double.infinity,
                  color: baseColor,
                ),
                baseColor: baseColor,
                highlightColor:highlightColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0,),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Row(
                          children: [
                            Icon(
                              IconBroken.Heart,
                              size: 18.0,
                              color: Colors.red,
                            ),
                            SizedBox(width: 5.0,),
                            Shimmer.fromColors(
                              highlightColor: highlightColor,
                              baseColor: baseColor,
                              child: Text(
                                'Like',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: (){},
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              IconBroken.Chat,
                              size: 18.0,
                              color: Colors.amber,
                            ),
                            SizedBox(width: 5.0,),
                            Shimmer.fromColors(
                              highlightColor: highlightColor,
                              baseColor: baseColor,
                              child: Text(
                                'Comment',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: (){},
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Shimmer.fromColors(
                        highlightColor: highlightColor,
                        baseColor: baseColor,
                        child: CircleAvatar(
                          radius: 18.0,
                          backgroundColor: baseColor,
                        ),
                      ),
                      SizedBox(width: 15.0),
                      Shimmer.fromColors(
                        highlightColor: highlightColor,
                        baseColor: baseColor,
                        child: Text(
                          'Write a comment ...',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      IconBroken.Heart,
                      size: 18.0,
                      color: Colors.red,
                    ),
                    SizedBox(width: 5.0,),
                    Shimmer.fromColors(
                      highlightColor: highlightColor,
                      baseColor: baseColor,
                      child: Text(
                        'Like',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  },
);

