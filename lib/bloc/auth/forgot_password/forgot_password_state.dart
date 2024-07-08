part of 'forgot_password_bloc.dart';

@immutable
abstract class ForgotPasswordState {
  const ForgotPasswordState();
}

class ForgotPasswordInitial extends ForgotPasswordState {}

class ForgotPasswordSuccessState extends ForgotPasswordState {
  final SuccessModel? successModel;

  const ForgotPasswordSuccessState({required this.successModel});
}

class ForgotPasswordErrorState extends ForgotPasswordState {
  final ErrorModel? errorModel;

  const ForgotPasswordErrorState({required this.errorModel});
}

class LoadingState extends ForgotPasswordState {
  const LoadingState();
}

class ValidateFormState extends ForgotPasswordState {
  bool errorEmail = false;
  String? errorEmailMsg;

  ValidateFormState({required this.errorEmail, required this.errorEmailMsg});
}

class VerifyNewPasswordSuccessState extends ForgotPasswordState {
  final SuccessModel? successModel;

  const VerifyNewPasswordSuccessState({required this.successModel});
}

class VerifyNewPasswordErrorState extends ForgotPasswordState {
  final ErrorModel? errorModel;

  const VerifyNewPasswordErrorState({required this.errorModel});
}

class ChangePasswordVisibilityState extends ForgotPasswordState {
  final bool value;

  const ChangePasswordVisibilityState({required this.value});
}
