part of 'forgot_password_bloc.dart';

@immutable
abstract class ForgotPasswordEvent {
  const ForgotPasswordEvent();
}

class ForgotPasswordUserEvent extends ForgotPasswordEvent {
  final String email;
  ForgotPasswordUserEvent({required this.email});
}

class LoadingEvent extends ForgotPasswordEvent {
  const LoadingEvent();
}

class ValidateFormEvent extends ForgotPasswordEvent {
  bool errorEmail = false;
  String? errorEmailMsg;

  ValidateFormEvent({required this.errorEmail, required this.errorEmailMsg});
}

class VerifyNewPasswordEvent extends ForgotPasswordEvent {
  VerifyNewPasswordEvent();
}

class ChangePasswordVisibilityEvent extends ForgotPasswordEvent {
  final bool value;

  const ChangePasswordVisibilityEvent({required this.value});
}
