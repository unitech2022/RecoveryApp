import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';


UserResponse userResponseFromJson(String str) =>
    UserResponse.fromJson(json.decode(str));

String userResponseToJson(UserResponse data) => json.encode(data.toJson());

// ignore: must_be_immutable
class UserResponse extends Equatable {
  String? token;
  UserModel? user;
  bool? status;
  // Address? address;

  UserResponse({
    required this.token,
    required this.user,
    required this.status,
    // required this.address,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        token: json["token"],
        user: UserModel.fromJson(json["user"]),
        // expiration: DateTime.parse(json["expiration"]),
        status: json["status"],
        // address: Address.fromJson(json["address"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "user": user!.toJson(),
        // "expiration": expiration.toString(),
        "status": status,
        // "address": address!.toJson(),
      };

  @override
  List<Object?> get props => [token, user, status];
}

class Address extends Equatable {
  final int id;
  final String userId;
  final String description;
  final String name;
  final double lat;
  final double lng;
  final bool defaultAddress;
  final DateTime createdAt;

  const Address({
    required this.id,
    required this.userId,
    required this.description,
    required this.name,
    required this.lat,
    required this.lng,
    required this.defaultAddress,
    required this.createdAt,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        userId: json["userId"],
        description: json["description"],
        name: json["name"]??"",
        lat: json["lat"]?.toDouble(),
        lng: json["lng"]?.toDouble(),
        defaultAddress: json["defaultAddress"],
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "description": description,
        "name": name,
        "lat": lat,
        "lng": lng,
        "defaultAddress": defaultAddress,
        "createdAt": createdAt.toIso8601String(),
      };

  @override
  List<Object?> get props =>
      [id, userId, defaultAddress, description, lat, lng, createdAt];
}

class UserModel extends Equatable {
  final String id;
  final String userName;
  final String email;

  final String fullName;

  final String deviceToken;
  final int status;

  final String code;
  final String profileImage;

  final String address;

  // final String createdAt;

  UserModel(
      {required this.id,
      required this.userName,
      required this.email,
     
      required this.fullName,
      required this.deviceToken,
      required this.status,
 
      required this.code,
      required this.profileImage,
      required this.address,
 
 
    
      // required this.createdAt
      });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'],
        userName: json['userName'],
      
        email: json['email'] ?? "غير مسجل".tr(),
        fullName: json['fullName'] ?? "غير مسجل".tr(),
        deviceToken: json['deviceToken']??"",
        status: json['status'],
   
        code: json['code'],
        profileImage: json['profileImage'] ?? "",
        address: json['address'] ??"غير مسجلة".tr(),
      
     
     
        // createdAt: json['createdAt'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
   
    data['fullName'] = fullName;
    data['deviceToken'] = deviceToken;
    data['status'] = status;
    data['code'] = code;
    data['profileImage'] = profileImage;

    data['address'] = address;

    data['address'] = address;
  
    // data['createdAt'] = createdAt;
    return data;
  }

  @override
  List<Object?> get props => [
        id,
        fullName,
        userName,
        email,
        profileImage,
    
        deviceToken,
        status,
        code,
        address,
   
        address,
   
        profileImage,
      
        // createdAt
      ];
}
