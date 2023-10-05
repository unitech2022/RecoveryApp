part of 'market_cubit.dart';

class MarketState extends Equatable {
  final BaseResponse? response;

  final RequestState? getMarketsState;
  const MarketState({this.response, this.getMarketsState});

  @override
  List<Object?> get props => [response, getMarketsState];
}
