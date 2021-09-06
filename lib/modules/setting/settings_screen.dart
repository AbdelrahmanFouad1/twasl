import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twasl/shared/components/components.dart';
import 'package:twasl/shared/cubit/cubit.dart';
import 'package:twasl/shared/cubit/states.dart';
import 'package:twasl/shared/style/colors.dart';
import 'package:twasl/shared/style/iconly_broken.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        var cubit = AppCubit.get(context);
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 220.0,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(
                      child: Container(
                        height: 160.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(4.0),
                            topLeft: Radius.circular(4.0),
                          ),
                          image: DecorationImage(
                            image: NetworkImage('${cubit.userModel.cover}'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      alignment: AlignmentDirectional.topCenter,
                    ),
                    CircleAvatar(
                      radius: 64.0,
                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                      child: CircleAvatar(
                        radius: 60.0,
                        backgroundImage: NetworkImage('${cubit.userModel.image}'),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${cubit.userModel.fullName}',
                    style: Theme.of(context).textTheme.bodyText1,
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
                '${cubit.userModel.bio}',
                style: Theme.of(context).textTheme.caption!.copyWith(
                  height: 1.2,
                ),
              ),
              SizedBox(height: 2.0,),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {  },
                      child: Text(
                          'Add Photo'
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0,),
                  OutlinedButton(
                    onPressed: () {
                      // navigateTo(context, EditProfileScreen());
                    },
                    child: Icon(
                      IconBroken.Edit,
                      size: 16.0,
                    ),
                  ),
                ],
              ),

            ],
          ),
        ) ;
      },
    );
  }
}
