// To parse this JSON data, do
//
//     final dictionaryModel = dictionaryModelFromJson(jsonString);

import 'dart:convert';

DictionaryModel dictionaryModelFromJson(String str) =>
    DictionaryModel.fromJson(json.decode(str));

String dictionaryModelToJson(DictionaryModel data) =>
    json.encode(data.toJson());

class DictionaryModel {
  DictionaryData? data;
  String? status;
  String? message;

  DictionaryModel({
    this.data,
    this.status,
    this.message,
  });

  factory DictionaryModel.fromJson(Map<String, dynamic> json) =>
      DictionaryModel(
        data:
            json["data"] == null ? null : DictionaryData.fromJson(json["data"]),
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "status": status,
        "message": message,
      };
}

class DictionaryData {
  Map<dynamic, dynamic>? dictionary;

  DictionaryData({
    this.dictionary,
  });

  factory DictionaryData.fromJson(Map<dynamic, dynamic> json) => DictionaryData(
        dictionary: json["dictionary"] == null
            ? null
            : Map.from(json["dictionary"]!).map((k, v) =>
                MapEntry<String, String>(k.toString().toLowerCase(), v)),
      );

  Map<String, dynamic> toJson() => {
    if(dictionary!=null)
        "dictionary": Map.from(dictionary!)
            .map((k, v) => MapEntry<String, dynamic>(k, v)),
      };
}
