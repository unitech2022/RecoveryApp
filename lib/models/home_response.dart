import 'package:discovery_zone/models/field.dart';
import 'package:discovery_zone/models/offer.dart';
import 'package:equatable/equatable.dart';

class HomeResponse extends Equatable {
  final List<OfferModel> offers;
  final List<FieldModel> fields;
   final String codeMarkets;
   final String callUsNumber;
   final String cardDetails;
   

  const HomeResponse({required this.offers, required this.codeMarkets,required this.fields,required this.callUsNumber,required this.cardDetails});

  factory HomeResponse.fromJson(Map<String, dynamic> json) => HomeResponse(
      offers: List<OfferModel>.from(
          (json["offers"] as List).map((e) => OfferModel.fromJson(e))),
      fields: List<FieldModel>.from(
          (json["fields"] as List).map((e) => FieldModel.fromJson(e))),
          codeMarkets: json["codeMarkets"],
           callUsNumber: json["callUsNumber"],
             cardDetails: json["cardDetails"]
          );

  @override
  List<Object?> get props => [offers, fields,codeMarkets,callUsNumber];
}
