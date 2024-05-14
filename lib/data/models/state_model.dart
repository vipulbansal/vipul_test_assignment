// To parse this JSON data, do
//
//     final stateModel = stateModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<StateModel> stateModelFromJson(String str) => List<StateModel>.from(json.decode(str).map((x) => StateModel.fromJson(x)));

String stateModelToJson(List<StateModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StateModel {
  int id;
  String value;

  StateModel({
    required this.id,
    required this.value,
  });

  StateModel copyWith({
    int? id,
    String? value,
  }) =>
      StateModel(
        id: id ?? this.id,
        value: value ?? this.value,
      );

  factory StateModel.fromJson(Map<String, dynamic> json) => StateModel(
    id: json["id"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "value": value,
  };
}
