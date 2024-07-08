part of 'dashboard_bloc.dart';

@immutable
abstract class DashboardEvent {
  const DashboardEvent();
}

class ChangeTabEvent extends DashboardEvent {
  final int index;

  const ChangeTabEvent({
    required this.index,
  });
}

class FetchIssueEvents extends DashboardEvent {
  const FetchIssueEvents();
}

class LoadingEvent extends DashboardEvent {
  const LoadingEvent();
}

class LogoutEvent extends DashboardEvent {
  const LogoutEvent();
}

class UpdateFcmTokenEvent extends DashboardEvent {
  const UpdateFcmTokenEvent();
}
