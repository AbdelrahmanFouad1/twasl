import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:shimmer/shimmer.dart';
import 'package:twasl/models/user_model.dart';
import 'package:twasl/modules/chats/chats_screen.dart';
import 'package:twasl/modules/users/users_screen.dart';
import 'package:twasl/shared/components/components.dart';
import 'package:twasl/shared/cubit/cubit.dart';
import 'package:twasl/shared/cubit/states.dart';
import 'package:twasl/shared/style/colors.dart';

class AllUsersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)  => AppCubit()..getAllPostsData()..getAllUser(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, state) {
          var cubit = AppCubit.get(context);
          return Conditional.single(
            context: context,
            conditionBuilder: (BuildContext context) => cubit.user.length > 0,
            widgetBuilder: (BuildContext context) {
                return ListView.separated(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) => buildChatUser(cubit.user[index], context),
                  separatorBuilder: (context, index) => myDivider(),
                  itemCount: AppCubit
                      .get(context).user.length,
                );
              },
              fallbackBuilder: (context) => buildShimmerChatUser(context),
          );
        },
      ),
    );
  }
//
  Widget buildChatUser(UserModel model, context) => InkWell(
        onTap: () {
          navigateTo(context, UserScreen());
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

  Widget buildShimmerChatUser( context) =>
      ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index)  => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
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
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
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
            ),
          ],
        ),
      ),
      separatorBuilder: (context, index) =>  myDivider(),
      itemCount: 8,
  );
}