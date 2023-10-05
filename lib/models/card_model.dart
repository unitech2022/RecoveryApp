import 'package:equatable/equatable.dart';

class CardModel extends Equatable {
  final int id;
  final String nameAr;
  final String nameEng;
  final double price;
  final String link;
  final int order;
  final int typeDate;
  final String image;
  final int status;

  final String createdAt;

  const CardModel(
      {required this.id,
      required this.nameAr,
       required this.price,
        required this.typeDate,
      required this.nameEng,
      required this.link,
      required this.image,
      required this.order,
      required this.status,
      required this.createdAt});

  factory CardModel.fromJson(Map<String, dynamic> json) => CardModel(
      id: json["id"],
      nameAr: json["nameAr"],
      nameEng: json["nameEng"],
      link: json["link"],
      price: json["price"].toDouble(),
      order: json["order"],
       image: json["image"],
      typeDate: json["typeDate"],
      status: json["status"],
      createdAt: json["createdAt"]);

  @override
  List<Object?> get props => [
        id,
        order,
        nameAr,
        image,
        status,
        nameEng,
        createdAt,
        link,typeDate,
        price
      ];
}
