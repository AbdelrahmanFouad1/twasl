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

class AppCreatePostErrorState extends AppStates {}

class AppGetPostsLoadingState extends AppStates {}

class AppGetPostsSuccessState extends AppStates {}

class AppGetPostsErrorState extends AppStates {
  final String error;

  AppGetPostsErrorState(this.error);
}

class AppGetChangePostsSuccessState extends AppStates {}

class AppLikePostsSuccessState extends AppStates {}

class AppLikePostsErrorState extends AppStates {
  final String error;

  AppLikePostsErrorState(this.error);
}

class AppCommentPostsLoadingState extends AppStates {}

class AppCommentPostsSuccessState extends AppStates {}

class AppCommentPostsErrorState extends AppStates {
  final String error;

  AppCommentPostsErrorState(this.error);
}

class AppGetCommentSuccessState extends AppStates {}

