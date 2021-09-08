
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twasl/models/comment_model.dart';
import 'package:twasl/shared/cubit/cubit.dart';
import 'package:twasl/shared/cubit/states.dart';
import 'package:twasl/shared/style/colors.dart';
import 'package:twasl/shared/style/iconly_broken.dart';

class CommentsScreen extends StatelessWidget {

  dynamic postIndex;

  CommentsScreen({
    this.postIndex,
  });

  var commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        AppCubit.get(context).getCommentData(postIndex);
        return BlocConsumer<AppCubit, AppStates>(
          listener: (BuildContext context, state) {},
          builder: (BuildContext context, state) {
            var cubit = AppCubit.get(context);
            // AppCubit()..getCommentData(postIndex);

            return Scaffold(
                appBar: AppBar(
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                      cubit.getAllPostsData();
                    },
                    icon: Icon(
                        IconBroken.Arrow___Left_2
                    ),
                  ),
                  title: Text(
                    'Abdelrahman fouad and 1K comment',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  titleSpacing: 0.0,
                  actions: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        IconBroken.Heart,
                      ),
                    ),
                  ],
                ),
                body: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Comments',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Expanded(
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) => defaultComment(cubit.comments[index], context),
                          separatorBuilder: (context, index) => SizedBox(height: 20.0,),
                          itemCount: cubit.comments.length,
                        ),
                      ),
                      buildWriteComment(context),
                    ],
                  ),
                ));
          },
        );
      },

    );
  }

  Widget defaultComment(CommentModel model, context) => Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage(
                    '${model.image}'),
              ),
              // SizedBox(width: 15.0),
              Expanded(
                child: Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  color: Colors.grey[50],
                  margin: EdgeInsets.symmetric(
                    horizontal: 15.0,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${model.name}',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(height: 1.4),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Icon(
                              Icons.check_circle,
                              color: defaultColor,
                              size: 16.0,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          '${model.text}',
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                                color: Colors.black87,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      );

  Widget buildWriteComment(context) => Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 8.0,
    margin: EdgeInsets.symmetric(horizontal: 2.0,),
    child: Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15.0,
            ),
            child: TextFormField(
              controller: commentController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'type your comment ...',
              ),
            ),
          ),
        ),
        Container(
          height: 50.0,
          color: defaultColor,
          child: MaterialButton(
            onPressed: () {
              AppCubit.get(context).commentPost(
                dateTime: DateTime.now().toString(),
                text: commentController.text,
                postId: AppCubit.get(context).postsId[postIndex],
              );
              commentController.text = '';
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
