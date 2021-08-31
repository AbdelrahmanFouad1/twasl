import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:twasl/models/user_model.dart';
import 'package:twasl/modules/chats/chats_screen.dart';
import 'package:twasl/shared/components/components.dart';
import 'package:twasl/shared/cubit/cubit.dart';
import 'package:twasl/shared/cubit/states.dart';

class UserChatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        var cubit = AppCubit.get(context);
        return Conditional.single(
          context: context,
          conditionBuilder: (BuildContext context) => cubit.user.length > 0,
          widgetBuilder: (BuildContext context) {
              return ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    buildChatUser(cubit.user[index], context),
                separatorBuilder: (context, index) => myDivider(),
                itemCount: AppCubit
                    .get(context).user.length,
              );
            },
            fallbackBuilder: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildChatUser(UserModel model, context) => InkWell(
        onTap: () {
          navigateTo(context, ChatsScreen(userModel: model,));
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage(
                    '${model.image}'
                ),
              ),
              SizedBox(width: 15.0),
              Text(
                '${model.fullName}',
                style:
                Theme.of(context).textTheme.subtitle1!.copyWith(height: 1.4),
              ),
            ],
          ),
        ),
      );
}