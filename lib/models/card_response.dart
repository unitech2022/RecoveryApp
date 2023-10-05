import 'package:discovery_zone/models/card_model.dart';
import 'package:discovery_zone/models/subscribe_model.dart';
import 'package:discovery_zone/models/user_response.dart';

class CardResponse {
  final CardModel card;
  final SubscribeModel? subscription;
  final UserModel? userDetailResponse;
  final bool isSSubscribe;

  CardResponse(
      {required this.card,
      required this.userDetailResponse,
      required this.subscription,
      required this.isSSubscribe});

  factory CardResponse.fromJson(Map<String, dynamic> json) => CardResponse(
      card: CardModel.fromJson(json["card"]),
      subscription: json["subscription"] != null
          ? SubscribeModel.fromJson(json["subscription"])
          : null,
      isSSubscribe: json["isSSubscribe"],
      userDetailResponse:json["userDetailResponse"]!=null? UserModel.fromJson(json["userDetailResponse"]):null
      
      );
}
