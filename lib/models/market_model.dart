import 'package:equatable/equatable.dart';

class MarketModel extends Equatable {
  final int id;
  final String nameAr;
  final String nameEng;
  final String aboutAr;
  final String aboutEng;
  final int order;
 final String logoImage;
  
  final int categoryId;
  final int fieldId;
  final String phone;
  final String email;
  final String images;
   final String link;
  final int status;
  final int cardId;
  final double discount;
  final double rate;
  final String createdAt;

  const MarketModel(
      {required this.id,
      required this.nameAr,
      required this.nameEng,
      required this.aboutAr,
      required this.aboutEng,
       required this.logoImage,
      required this.link,
      required this.order,
      required this.categoryId,
      required this.fieldId,
      required this.phone,
      required this.email,
      required this.images,
      required this.status,
      required this.cardId,
      required this.discount,
      required this.rate,
      required this.createdAt});

  factory MarketModel.fromJson(Map<String, dynamic> json) => MarketModel(
      id: json["id"],
      nameAr: json["nameAr"],
      nameEng: json["nameEng"],
      aboutAr: json["aboutAr"],
      aboutEng: json["aboutEng"],
        logoImage: json["logoImage"],
      order: json["order"],
      categoryId: json["categoryId"],
      fieldId: json["fieldId"],
      phone: json["phone"],
      email: json["email"],
      images: json["images"],
       link: json["link"],
      status: json["status"],
      cardId: json["cardId"],
      discount: json["discount"].toDouble(),
      rate: json["rate"].toDouble(),
      createdAt: json["createdAt"]);

  @override
  List<Object?> get props => [
        id,
        order,
        nameAr,
        discount,
        images,
        status,
          link,
        nameEng,
        logoImage,
        createdAt,
        aboutAr,
        aboutEng,
        cardId,
        categoryId,
        fieldId,
        phone,
        email
      ];
}
