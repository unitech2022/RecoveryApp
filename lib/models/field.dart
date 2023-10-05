import 'package:equatable/equatable.dart';

class FieldModel extends Equatable {
  final int id;
  final String nameAr;
  final int order;

  final String nameEng;
  final String imageUrl;
  final int status;
  final String createdAt;

  const FieldModel(
      {required this.id,
      required this.nameAr,
      required this.order,
      required this.nameEng,
      required this.imageUrl,
      required this.status,
      required this.createdAt});

  factory FieldModel.fromJson(Map<String, dynamic> json) => FieldModel(
      id: json["id"],
      nameAr: json["nameAr"],
      nameEng: json["nameEng"],
      order: json["order"],
      imageUrl: json["imageUrl"],
      status: json["status"],
      createdAt: json["createdAt"]);

  @override
  List<Object?> get props =>
      [id, order, nameAr, imageUrl, status, nameEng, createdAt];
}
