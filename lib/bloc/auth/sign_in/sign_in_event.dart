part of 'sign_in_bloc.dart';

@immutable
abstract class SignInEvent {
  const SignInEvent();
}

class ChangePasswordVisibilityEvent extends SignInEvent {
  final bool value;

  const ChangePasswordVisibilityEvent({required this.value});
}

class SignInUserEvent extends SignInEvent {
  final Map<String, dynamic> bodyData;

  const SignInUserEvent({required this.bodyData});
}

class LoadingEvent extends SignInEvent {
  const LoadingEvent();
}

class GoogleSignInEvent extends SignInEvent {
  const GoogleSignInEvent();
}

class FacebookSignInEvent extends SignInEvent {
  const FacebookSignInEvent();
}
