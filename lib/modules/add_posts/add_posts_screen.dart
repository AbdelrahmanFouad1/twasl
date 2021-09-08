import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:textfield_tags/textfield_tags.dart';
import 'package:twasl/shared/components/components.dart';
import 'package:twasl/shared/cubit/cubit.dart';
import 'package:twasl/shared/cubit/states.dart';
import 'package:twasl/shared/style/colors.dart';
import 'package:twasl/shared/style/iconly_broken.dart';

class AddPostsScreen extends StatelessWidget {

  var textController = TextEditingController();
  String? tags;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, state) {
        if(state is AppCreatePostSuccessState){
          showToast(message: 'Post uploaded successfully', state: ToastStates.SUCCESS);
        }
      },
      builder: (BuildContext context, Object? state) {
        var cubit = AppCubit.get(context);
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25.0,
                    backgroundImage: NetworkImage('${cubit.userModel.image}'),
                  ),
                  SizedBox(width: 15.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${cubit.userModel.fullName}',
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
                        Row(
                          children: [
                            Text(
                              'Public',
                              style: Theme.of(context).textTheme.caption!.copyWith(height: 1.4,),
                            ),
                            SizedBox(width: 5.0,),
                            Icon(
                              Icons.public,
                              color: Colors.grey[500],
                              size: 16.0,
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),
                  TextButton(
                      onPressed: (){
                        var now = DateTime.now();
                        cubit.uploadPost(
                            dateTime: now.toString(),
                            body: textController.text,
                            tags: tags,
                            time: DateTime.now().toString(),
                        );
                        cubit.getAllPostsData();
                      },
                      child: Text(
                        'POST'
                      ),
                  ),
                ],
              ),
              Expanded(
                child: TextFormField(
                  controller: textController,
                  decoration: InputDecoration(
                    hintText: 'what is on your mind ...',
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: 10.0,),
              if(cubit.isTag == true)
                TextFieldTags(
                tagsStyler: TagsStyler(
                  tagTextPadding: EdgeInsets.zero,
                  showHashtag: true,
                  tagMargin: const EdgeInsets.only(right: 2.0,),
                  tagCancelIcon: Icon(Icons.cancel, size: 15.0, color: defaultColor),
                  tagCancelIconPadding: EdgeInsets.only(left: 4.0, top: 0.0,),
                  tagPadding: EdgeInsets.only(top: 0.0, bottom: 4.0, left: 8.0, right: 4.0),
                  tagDecoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  tagTextStyle: TextStyle(color: Colors.blue),
                ),
                textFieldStyler: TextFieldStyler(
                  contentPadding: EdgeInsets
                      .only(top: 12.0),
                  hintText: "Please Enter Tags ...",
                  textFieldFocusedBorder: InputBorder.none,
                  textFieldBorder: InputBorder.none,
                ),
                onDelete: (tag) {
                  print('onDelete: $tag');
                  tags = null;
                },
                onTag: (tag) {
                  print('onTag: $tag');
                  tags = tag;
                },
                validator: (String tag) {
                  if (tag.length > 15) {
                    return "hey that is too much";
                  }
                  return null;
                },
              ),
              if(cubit.postImage != null)
                Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Container(
                      height: 140.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0,),
                        image: DecorationImage(
                          image:FileImage(cubit.postImage!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        cubit.removePikePostImage();
                      },
                      icon: CircleAvatar(
                        radius: 20.0,
                        child: Icon(
                          Icons.close,
                          size: 16.0,
                        ),
                      ),
                    ),
                  ],
                ),
              SizedBox(height: 20.0,),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                        onPressed: (){
                          cubit.pikePostImage();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              IconBroken.Image,
                            ),
                            SizedBox(width: 5.0,),
                            Text(
                                'add photo'
                            ),
                          ],
                        )
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: (){
                        cubit.changeTagText();
                      },
                      child: Text(
                          '# ${cubit.tagName}'
                      ),

                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
