import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:shimmer/shimmer.dart';
import 'package:twasl/models/post_model.dart';
import 'package:twasl/modules/comments/comments_screen.dart';
import 'package:twasl/shared/components/components.dart';
import 'package:twasl/shared/cubit/cubit.dart';
import 'package:twasl/shared/cubit/states.dart';
import 'package:twasl/shared/style/colors.dart';
import 'package:twasl/shared/style/iconly_broken.dart';
import 'package:timeago/timeago.dart' as timeago;

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
        return BlocProvider(
          create: (BuildContext context) => AppCubit()..getUserData()..getAllPostsData(),
          child: BlocConsumer<AppCubit, AppStates>(
            listener: (BuildContext context, state) {},
            builder: (BuildContext context, Object? state) {
              var cubit = AppCubit.get(context);
              return Conditional.single(
                context: context,
                conditionBuilder: (BuildContext context) =>  cubit.posts.length > 0 ,
                widgetBuilder: (BuildContext context) => SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        elevation: 8.0,
                        margin: EdgeInsets.all(8.0),
                        child: Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            Image(
                              image: NetworkImage('https://image.freepik.com/free-photo/portrait-happy-amazed-young-beautiful-lady-with-curly-dark-hair-heard-cool-news-broadly-smiling-looking-camera-pointing-with-finger-copy-space-isolated-pink-background_295783-3092.jpg'),
                              height: 200.0,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'communicate with friends',
                                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) => buildPostItem (cubit.posts[index], context, index),
                        separatorBuilder: ( context, index ) => SizedBox(height: 8.0,),
                        itemCount: cubit.posts.length,
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                    ],
                  ),
                ) ,
                fallbackBuilder: (BuildContext context) => Column(
                  children: [
                    Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      elevation: 8.0,
                      margin: EdgeInsets.all(8.0),
                      child: Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          Shimmer.fromColors(
                            highlightColor: highlightColor,
                            baseColor: baseColor,
                            child: Container(
                              height: 200.0,
                              width: double.infinity,
                              color: baseColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    buildPostShimmerItem (context),
                  ],
                ),
                  // SingleChildScrollView(
                  //   physics: BouncingScrollPhysics(),
                  //   child: Column(
                  //     children: [
                  //       Card(
                  //         clipBehavior: Clip.antiAliasWithSaveLayer,
                  //         elevation: 8.0,
                  //         margin: EdgeInsets.all(8.0),
                  //         child: Stack(
                  //           alignment: AlignmentDirectional.bottomEnd,
                  //           children: [
                  //             Image(
                  //               image: NetworkImage('https://image.freepik.com/free-photo/portrait-happy-amazed-young-beautiful-lady-with-curly-dark-hair-heard-cool-news-broadly-smiling-looking-camera-pointing-with-finger-copy-space-isolated-pink-background_295783-3092.jpg'),
                  //               height: 200.0,
                  //               fit: BoxFit.cover,
                  //               width: double.infinity,
                  //             ),
                  //             Padding(
                  //               padding: const EdgeInsets.all(8.0),
                  //               child: Text(
                  //                 'communicate with friends',
                  //                 style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  //                   color: Colors.white,
                  //                 ),
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //       SizedBox(
                  //         height: 8.0,
                  //       ),
                  //       ListView.separated(
                  //         shrinkWrap: true,
                  //         physics: BouncingScrollPhysics(),
                  //         itemBuilder: (context, index) => buildPostItem (cubit.posts[index], context, index),
                  //         separatorBuilder: ( context, index ) => SizedBox(height: 8.0,),
                  //         itemCount: cubit.posts.length,
                  //       ),
                  //       SizedBox(
                  //         height: 8.0,
                  //       ),
                  //     ],
                  //   ),
                  // )
              );
            },
          ),
        );
  }

}
