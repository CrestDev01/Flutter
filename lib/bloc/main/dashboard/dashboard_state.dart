part of 'dashboard_bloc.dart';

@immutable
abstract class DashboardState {
  const DashboardState();
}

class DashboardInitial extends DashboardState {}

class ChangeTabState extends DashboardState {
  final int index;

  const ChangeTabState({
    required this.index,
  });
}

class LoadingState extends DashboardState {
  LoadingState();
}

class LogoutSuccessState extends DashboardState {
  final SuccessModel? successModel;

  const LogoutSuccessState({required this.successModel});
}

class LogoutErrorState extends DashboardState {
  final ErrorModel? errorModel;

  const LogoutErrorState({required this.errorModel});
}
