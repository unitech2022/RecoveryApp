import 'package:equatable/equatable.dart';

class NotificationModel {
  int? id;

  bool? viewed;
  String? createdAt;
  String? titleAr;
  String? titleEng;
  String? descriptionAr;
  String? descriptionEng;

  NotificationModel(
      {this.id,
      this.viewed,
      this.titleAr,
      this.titleEng,
      this.descriptionAr,
      this.descriptionEng,
      this.createdAt});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    titleAr = json['titleAr'];
    titleEng = json['titleEng'];
    descriptionAr = json['descriptionAr'];
    descriptionEng = json['descriptionEng'];
    viewed = json['viewed'];
    createdAt = json['createdAt'];
  }
}

class AlertResponse extends Equatable {
  final int currentPage;
  final int totalPages;
  final List<NotificationModel> items;

  const AlertResponse(
      {required this.items,
      required this.currentPage,
      required this.totalPages});

  factory AlertResponse.fromJson(Map<String, dynamic> json) => AlertResponse(
      items: List<NotificationModel>.from(
          (json["items"] as List).map((e) => NotificationModel.fromJson(e))),
      currentPage: json["currentPage"],
      totalPages: json["totalPages"]);
  @override
  List<Object?> get props => [currentPage, totalPages, items];
}
