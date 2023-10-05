part of 'notification_cubit.dart';

class NotificationState extends Equatable {
  final RequestState? getAlertsState;

  final AlertResponse? alertResponse;

  const NotificationState({this.getAlertsState, this.alertResponse});

  NotificationState copyWith(
          {final RequestState? getAlertsState,
          final RequestState? viewAlertState,
          final AlertResponse? alertResponse}) =>
      NotificationState(
        getAlertsState: getAlertsState ?? this.getAlertsState,
        alertResponse: alertResponse ?? this.alertResponse,
      );
  @override
  List<Object?> get props => [getAlertsState, alertResponse];
}
