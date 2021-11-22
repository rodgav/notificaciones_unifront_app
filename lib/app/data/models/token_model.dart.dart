// To parse this JSON data, do
//
//     final tokenModel = tokenModelFromJson(jsonString);

import 'dart:convert';

TokenModel tokenModelFromJson(String str) =>
    TokenModel.fromJson(json.decode(str));

String tokenModelToJson(TokenModel data) => json.encode(data.toJson());

class TokenModel {
  TokenModel({
    required this.status,
    required this.message,
    required this.code,
    required this.jwt,
  });

  String status;
  String message;
  int code;
  String? jwt;

  factory TokenModel.fromJson(Map<String, dynamic> json) => TokenModel(
        status: json["status"],
        message: json["message"],
        code: json["code"],
        jwt: json["jwt"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "code": code,
        "jwt": jwt,
      };
}
