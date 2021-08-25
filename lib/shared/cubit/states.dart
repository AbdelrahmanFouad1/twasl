abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppChangeBottomNavState extends AppStates {}

class AppPostImagePickedSuccessState extends AppStates {}

class AppPostImagePickedErrorState extends AppStates {}

class AppRemovePikePostImageSuccessState extends AppStates {}

class AppChangeTagState extends AppStates {}

class AppGetUserLoadingState extends AppStates {}

class AppGetUserSuccessState extends AppStates {}

class AppGetUserErrorState extends AppStates {
  final String error;

  AppGetUserErrorState(this.error);

}

class AppCreatePostLoadingState extends AppStates {}

class AppCreatePostSuccessState extends AppStates {}

class AppCreatePostErrorState extends AppStates {

}
