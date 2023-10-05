import 'package:equatable/equatable.dart';

class CategoryModel extends Equatable {
  final int id;
  final String nameAr;
  final int order;
  final int fieldId;
  final String nameEng;
  final String imageUrl;
  final int status;
  final String createdAt;

  const CategoryModel(
      {required this.id,
      required this.nameAr,
      required this.order,
      required this.fieldId,
      required this.nameEng,
      required this.imageUrl,
      required this.status,
      required this.createdAt});

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
      id: json["id"],
      nameAr: json["nameAr"],
      nameEng: json["nameEng"],
      order: json["order"],
      fieldId: json["fieldId"],
      imageUrl: json["imageUrl"],
      status: json["status"],
      createdAt: json["createdAt"]);

  @override
  List<Object?> get props => [id,
  fieldId,
  order, 
  nameAr, 
  imageUrl, 
  status, 
  nameEng, 
  createdAt];
}
