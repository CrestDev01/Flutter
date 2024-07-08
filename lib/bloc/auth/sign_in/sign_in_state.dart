part of 'sign_in_bloc.dart';

@immutable
abstract class SignInState {
  const SignInState();
}

class SignInInitial extends SignInState {}

class ChangePasswordVisibilityState extends SignInState {
  final bool value;

  const ChangePasswordVisibilityState({required this.value});
}

class SignInSuccessState extends SignInState {
  final LoginSuccessModel? loginSuccessModel;
  const SignInSuccessState({required this.loginSuccessModel});
}

class SignInErrorState extends SignInState {
  final ErrorModel? errorModel;

  const SignInErrorState({required this.errorModel});
}

class LoadingState extends SignInState {
  const LoadingState();
}
