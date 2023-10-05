import 'package:equatable/equatable.dart';

class SubscribeModel extends Equatable {
  final int id;
  final String firstName;
  final String lastName;
  final int cardId;
final int code;
  final String phone;
  final String address;
  final int status;
  final String createdAt;
    final String expiredDate;
      final String userId;
  
  

  const SubscribeModel(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.code,
        required this.expiredDate,
      required this.userId,
      required this.cardId,
      required this.phone,
      required this.address,
      required this.status,
      required this.createdAt});

  factory SubscribeModel.fromJson(Map<String, dynamic> json) => SubscribeModel(
      id: json["id"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      cardId: json["cardId"],
      phone: json["phone"],
      address: json["address"],
      status: json["status"],
         code: json["code"],
      createdAt: json["createdAt"],
        expiredDate: json["expiredDate"],
      userId: json["userId"]
      );

  @override
  // TODO: implement props
  List<Object?> get props =>
      [id, cardId, firstName, lastName, phone, address, status, createdAt,code];
}
