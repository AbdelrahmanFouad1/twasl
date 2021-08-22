abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterChangePasswordVisibilityState extends RegisterStates {}

class RegisterChangeCheckState extends RegisterStates {}

class RegisterRotationPeriodState extends RegisterStates {}

class RegisterCreateSuccessStates extends RegisterStates {}

class RegisterCreateErrorStates extends RegisterStates {
  final String error;

  RegisterCreateErrorStates(this.error);
}

class RegisterLoadingStates extends RegisterStates {}

class RegisterFinishStates extends RegisterStates {
  final String uId;

  RegisterFinishStates(this.uId);
}

