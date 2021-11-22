// To parse this JSON data, do
//
//     final notificacionModel = notificacionModelFromJson(jsonString);

import 'dart:convert';

NotificacionModel notificacionModelFromJson(String str) => NotificacionModel.fromJson(json.decode(str));

String notificacionModelToJson(NotificacionModel data) => json.encode(data.toJson());

class NotificacionModel {
  NotificacionModel({
    required this.notificaciones,
    required this.status,
    required this.message,
    required this.code,
  });

  List<Notificacione> notificaciones;
  String status;
  String message;
  int code;

  factory NotificacionModel.fromJson(Map<String, dynamic> json) => NotificacionModel(
    notificaciones: List<Notificacione>.from(json["notificaciones"].map((x) => Notificacione.fromJson(x))),
    status: json["status"],
    message: json["message"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "notificaciones": List<dynamic>.from(notificaciones.map((x) => x.toJson())),
    "status": status,
    "message": message,
    "code": code,
  };
}

class Notificacione {
  Notificacione({
    required this.id,
    required this.idapoderado,
    required this.idEstudiante,
    required this.titulo,
    required this.mensaje,
    required this.dateLimit,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int idapoderado;
  int idEstudiante;
  String titulo;
  String mensaje;
  DateTime dateLimit;
  DateTime createdAt;
  DateTime updatedAt;

  factory Notificacione.fromJson(Map<String, dynamic> json) => Notificacione(
    id: json["id"],
    idapoderado: json["idapoderado"],
    idEstudiante: json["idEstudiante"],
    titulo: json["titulo"],
    mensaje: json["mensaje"],
    dateLimit: DateTime.parse(json["date_limit"]),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "idapoderado": idapoderado,
    "idEstudiante": idEstudiante,
    "titulo": titulo,
    "mensaje": mensaje,
    "date_limit": dateLimit.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
