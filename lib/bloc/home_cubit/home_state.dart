part of 'home_cubit.dart';

 class HomeState extends Equatable {
    final HomeResponse? homeResponse;

  final RequestState getHomeState;
  const HomeState({ this.homeResponse, this.getHomeState=RequestState.loading});

  @override
  List<Object?> get props => [
    homeResponse,
    getHomeState
  ];
}
