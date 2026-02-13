abstract class AuthState {}

class AuthInitial extends AuthState {}

class RegisterLoadingState extends AuthState {}

class RegisterSuccessState extends AuthState {}

class RegisterErrorState extends AuthState {
  final String error;
  RegisterErrorState(this.error);
}

class LoginLoadingState extends AuthState {}

class LoginSuccessState extends AuthState {
  final Map<String, dynamic> loginData;
  LoginSuccessState(this.loginData);
}
class LoginErrorState extends AuthState {
  final String error;
  LoginErrorState(this.error);
}

class RequestResetLoadingState extends AuthState {}
class RequestResetSuccessState extends AuthState {}
class RequestResetErrorState extends AuthState {
  final String error;
  RequestResetErrorState(this.error);
}

class ResetPasswordLoadingState extends AuthState {}
class ResetPasswordSuccessState extends AuthState {}
class ResetPasswordErrorState extends AuthState {
  final String error;
  ResetPasswordErrorState(this.error);
}
//otp دول بتوع بتاعت ريسيت الباسورد
class VerifyCodeLoadingState extends AuthState {}

class VerifyCodeSuccessState extends AuthState {
  final Map<String, dynamic> verifyData;
  VerifyCodeSuccessState(this.verifyData);
}
class VerifyCodeErrorState extends AuthState {
  final String error;
  VerifyCodeErrorState(this.error);
}




class VerifyEmailLoadingState extends AuthState {}

class VerifyEmailSuccessState extends AuthState {}

class VerifyEmailErrorState extends AuthState {
  final String error;
  VerifyEmailErrorState(this.error);
}

class LogoutLoadingState extends AuthState {}
class LogoutSuccessState extends AuthState {}
class LogoutErrorState extends AuthState {
  final String error;
  LogoutErrorState(this.error);
}