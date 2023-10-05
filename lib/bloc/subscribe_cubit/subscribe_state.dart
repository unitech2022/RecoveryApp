part of 'subscribe_cubit.dart';

class SubscribeState extends Equatable {
  final RequestState? subscribeCardState;
  const SubscribeState({this.subscribeCardState});

  @override
  List<Object?> get props => [subscribeCardState];
}
