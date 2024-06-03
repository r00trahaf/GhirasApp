// To parse this JSON data, do
//
//     final humidityModel = humidityModelFromJson(jsonString);

import 'dart:convert';

HumidityModel humidityModelFromJson(String str) => HumidityModel.fromJson(json.decode(str));

String humidityModelToJson(HumidityModel data) => json.encode(data.toJson());

class HumidityModel {
  Channel? channel;
  List<Feed>? feeds;

  HumidityModel({
    this.channel,
    this.feeds,
  });

  factory HumidityModel.fromJson(Map<String, dynamic> json) => HumidityModel(
    channel: json["channel"] == null ? null : Channel.fromJson(json["channel"]),
    feeds: json["feeds"] == null ? [] : List<Feed>.from(json["feeds"]!.map((x) => Feed.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "channel": channel?.toJson(),
    "feeds": feeds == null ? [] : List<dynamic>.from(feeds!.map((x) => x.toJson())),
  };
}

class Channel {
  int? id;
  String? name;
  String? latitude;
  String? longitude;
  String? field1;
  String? field2;
  String? field3;
  String? field4;
  String? field5;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? lastEntryId;

  Channel({
    this.id,
    this.name,
    this.latitude,
    this.longitude,
    this.field1,
    this.field2,
    this.field3,
    this.field4,
    this.field5,
    this.createdAt,
    this.updatedAt,
    this.lastEntryId,
  });

  factory Channel.fromJson(Map<String, dynamic> json) => Channel(
    id: json["id"],
    name: json["name"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    field1: json["field1"],
    field2: json["field2"],
    field3: json["field3"],
    field4: json["field4"],
    field5: json["field5"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    lastEntryId: json["last_entry_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "latitude": latitude,
    "longitude": longitude,
    "field1": field1,
    "field2": field2,
    "field3": field3,
    "field4": field4,
    "field5": field5,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "last_entry_id": lastEntryId,
  };
}

class Feed {
  DateTime? createdAt;
  int? entryId;
  dynamic field1;
  dynamic field2;
  dynamic field3;
  String? field4;
  dynamic field5;

  Feed({
    this.createdAt,
    this.entryId,
    this.field1,
    this.field2,
    this.field3,
    this.field4,
    this.field5,
  });

  factory Feed.fromJson(Map<String, dynamic> json) => Feed(
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    entryId: json["entry_id"],
    field1: json["field1"],
    field2: json["field2"],
    field3: json["field3"],
    field4: json["field4"],
    field5: json["field5"],
  );

  Map<String, dynamic> toJson() => {
    "created_at": createdAt?.toIso8601String(),
    "entry_id": entryId,
    "field1": field1,
    "field2": field2,
    "field3": field3,
    "field4": field4,
    "field5": field5,
  };
}
