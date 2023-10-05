import 'package:discovery_zone/models/card_model.dart';
import 'package:discovery_zone/models/market_model.dart';
import 'package:equatable/equatable.dart';

class BaseResponse extends Equatable {
  final int currentPage;
  final int totalPages;
  final List<MarketResponse> items;

  const BaseResponse(
      {required this.items,
      required this.currentPage,
      required this.totalPages});

  factory BaseResponse.fromJson(Map<String, dynamic> json) => BaseResponse(
      items: List<MarketResponse>.from(
          (json["items"] as List).map((e) => MarketResponse.fromJson(e))),
      currentPage: json["currentPage"],
      totalPages: json["totalPages"]);
  @override
  // TODO: implement props
  List<Object?> get props => [currentPage, totalPages];
}

class MarketResponse {
  final MarketModel market;
  final CardModel? card;

  const MarketResponse({
    required this.market,
    required this.card,
  });

  factory MarketResponse.fromJson(Map<String, dynamic> json) =>
      MarketResponse(market: MarketModel.fromJson(json["market"]), card:json["card"]!=null? CardModel.fromJson(json["card"]):null);
  @override
  // TODO: implement props
  List<Object?> get props => [market, card];
}
