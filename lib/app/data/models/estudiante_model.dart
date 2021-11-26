// To parse this JSON data, do
//
//     final estudianteModel = estudianteModelFromJson(jsonString);

import 'dart:convert';

EstudianteModel estudianteModelFromJson(String str) => EstudianteModel.fromJson(json.decode(str));

String estudianteModelToJson(EstudianteModel data) => json.encode(data.toJson());

class EstudianteModel {
  EstudianteModel({
    required this.estudiantes,
    required this.status,
    required this.message,
    required this.code,
  });

  List<Estudiante> estudiantes;
  String status;
  String message;
  int code;

  factory EstudianteModel.fromJson(Map<String, dynamic> json) => EstudianteModel(
    estudiantes: List<Estudiante>.from(json["estudiantes"].map((x) => Estudiante.fromJson(x))),
    status: json["status"],
    message: json["message"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "estudiantes": List<dynamic>.from(estudiantes.map((x) => x.toJson())),
    "status": status,
    "message": message,
    "code": code,
  };
}

class Estudiante {
  Estudiante({
    required this.id,
    required this.idapoderado,
    required this.name,
    required this.lastname,
    required this.correo,
    required this.idSubNivel,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int idapoderado;
  String name;
  String lastname;
  String correo;
  int idSubNivel;
  DateTime createdAt;
  DateTime updatedAt;

  factory Estudiante.fromJson(Map<String, dynamic> json) => Estudiante(
    id: json["id"],
    idapoderado: json["idapoderado"]??0,
    name: json["name"],
    lastname: json["lastname"],
    correo: json["correo"],
    idSubNivel: json["idSubNivel"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "idapoderado": idapoderado,
    "name": name,
    "lastname": lastname,
    "correo": correo,
    "idSubNivel": idSubNivel,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
