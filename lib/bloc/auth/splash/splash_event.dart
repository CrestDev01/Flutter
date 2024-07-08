part of 'splash_bloc.dart';

@immutable
abstract class SplashEvent {
  const SplashEvent();
}

class CheckAuthEvent extends SplashEvent {
  const CheckAuthEvent();
}
