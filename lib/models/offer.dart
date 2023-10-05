import 'package:equatable/equatable.dart';

class OfferModel extends Equatable {
  final int id;
  final String descAr;
  final int order;
  final double discount;
  final String descEng;
  final String image;
  final int status;
  final String createdAt;

  const OfferModel(
      {required this.id,
      required this.descAr,
      required this.order,
      required this.discount,
      required this.descEng,
      required this.image,
      required this.status,
      required this.createdAt});

  factory OfferModel.fromJson(Map<String, dynamic> json) => OfferModel(
      id: json["id"],
      descAr: json["descAr"],
      discount: json["discount"].toDouble(),
      order: json["order"],
      image: json["image"],
      descEng: json["descEng"],
      status: json["status"],
      createdAt: json["createdAt"]);

  @override
  List<Object?> get props =>
      [id, order, descAr,discount, image, status, descEng, createdAt];
}
