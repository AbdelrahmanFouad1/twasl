import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:intl/intl.dart';
import 'package:twasl/models/message_model.dart';
import 'package:twasl/models/user_model.dart';
import 'package:twasl/shared/cubit/cubit.dart';
import 'package:twasl/shared/cubit/states.dart';
import 'package:twasl/shared/style/colors.dart';
import 'package:twasl/shared/style/iconly_broken.dart';

class ChatsScreen extends StatelessWidget {
  UserModel userModel;

  ChatsScreen({required this.userModel});

  var messageController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {

        return BlocConsumer<AppCubit, AppStates>(
          listener: (BuildContext context, state) {},
          builder: (BuildContext context, state) {
            AppCubit.get(context).getMessage(receiverId: userModel.uId,);
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(IconBroken.Arrow___Left_2),
                ),
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 18.0,
                      backgroundImage: NetworkImage('${userModel.image}'),
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      '${userModel.fullName}',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(height: 1.4),
                    ),
                  ],
                ),
              ),
              body: Conditional.single(
                context: context,
                conditionBuilder: (BuildContext context) =>
                    AppCubit.get(context).message.length > 0,
                widgetBuilder: (BuildContext context) => Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) {
                            var message = AppCubit.get(context).message[index];

                            if (AppCubit.get(context).userModel.uId ==
                                message.senderId)
                              return buildMyMessage(message, context);
                            return buildMessage(message, context);
                          },
                          separatorBuilder: (context, index) => SizedBox(
                            height: 15.0,
                          ),
                          itemCount: AppCubit.get(context).message.length,
                        ),
                      ),
                      buildSendMessageField(context),
                    ],
                  ),
                ),
                fallbackBuilder: (BuildContext context) => Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: Image(
                          image: NetworkImage(
                              'https://image.freepik.com/free-vector/no-data-concept-illustration_114360-626.jpg'),
                        ),
                      ),
                      buildSendMessageField(context)
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget buildMessage(MessageModel model, context) => Builder(
    builder: (BuildContext context) {
      var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
      var inputDate = inputFormat.parse(model.dateTime);

      var outputFormat = DateFormat('hh:mm a');
      var outputDate = outputFormat.format(inputDate);
      return Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(
                10.0,
              ),
              topStart: Radius.circular(
                10.0,
              ),
              topEnd: Radius.circular(
                10.0,
              ),
            ),
          ),
          padding: EdgeInsets.symmetric(
            vertical: 5.0,
            horizontal: 10.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.text,
              ),
              Text(
                outputDate,
                style: Theme.of(context).textTheme.caption!.copyWith(
                  fontSize: 10.0,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );

  Widget buildMyMessage(MessageModel model, context) =>
      Builder(builder: (BuildContext context) {
        var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
        var inputDate = inputFormat.parse(model.dateTime);

        var outputFormat = DateFormat('hh:mm a');
        var outputDate = outputFormat.format(inputDate);
        return Align(
          alignment: AlignmentDirectional.centerEnd,
          child: Container(
            decoration: BoxDecoration(
              color: defaultColor.withOpacity(
                0.2,
              ),
              borderRadius: BorderRadiusDirectional.only(
                bottomStart: Radius.circular(
                  10.0,
                ),
                topStart: Radius.circular(
                  10.0,
                ),
                topEnd: Radius.circular(
                  10.0,
                ),
              ),
            ),
            padding: EdgeInsets.symmetric(
              vertical: 5.0,
              horizontal: 10.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  model.text,
                ),
                Text(
                  outputDate,
                  style: Theme.of(context).textTheme.caption!.copyWith(
                        fontSize: 10.0,
                  ),
                ),
              ],
            ),
          ),
        );
      });

  Widget buildSendMessageField(context) => Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: gray300,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(
            15.0,
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        margin: EdgeInsets.symmetric(
          horizontal: 2.0,
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                ),
                child: TextFormField(
                  controller: messageController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'type your message here ...',
                  ),
                ),
              ),
            ),
            Container(
              height: 50.0,
              color: defaultColor,
              child: MaterialButton(
                onPressed: () {
                  AppCubit.get(context).sendMessage(
                    receiverId: userModel.uId,
                    dateTime: DateTime.now().toString(),
                    text: messageController.text,
                  );
                  messageController.text = '';
                },
                minWidth: 1.0,
                child: Icon(
                  IconBroken.Send,
                  size: 16.0,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      );
}
