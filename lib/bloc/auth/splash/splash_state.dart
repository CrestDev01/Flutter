part of 'splash_bloc.dart';

@immutable
abstract class SplashState {
  const SplashState();
}

class SplashInitial extends SplashState {}

class AuthSuccessState extends SplashState {
  final bool isLoggedIn;
  const AuthSuccessState({required this.isLoggedIn});
}
