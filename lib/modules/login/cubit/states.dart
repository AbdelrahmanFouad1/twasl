abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginChangePasswordVisibilityState extends LoginStates {}

class LoginRotationPeriodState extends LoginStates {}

class LoginLoadingStates extends LoginStates {}

class LoginSuccessStates extends LoginStates {
  final String uId;

  LoginSuccessStates(this.uId);
}

class LoginErrorStates extends LoginStates {
  final String error;

  LoginErrorStates(this.error);
}