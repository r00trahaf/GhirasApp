// To parse this JSON data, do
//
//     final weatherModel = weatherModelFromJson(jsonString);

import 'dart:convert';

WeatherModel weatherModelFromJson(String str) => WeatherModel.fromJson(json.decode(str));

String weatherModelToJson(WeatherModel data) => json.encode(data.toJson());

class WeatherModel {
  Data? data;

  WeatherModel({
    this.data,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class Data {
  List<Timeline>? timelines;

  Data({
    this.timelines,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    timelines: json["timelines"] == null ? [] : List<Timeline>.from(json["timelines"]!.map((x) => Timeline.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "timelines": timelines == null ? [] : List<dynamic>.from(timelines!.map((x) => x.toJson())),
  };
}

class Timeline {
  String? timestep;
  DateTime? endTime;
  DateTime? startTime;
  List<Interval>? intervals;

  Timeline({
    this.timestep,
    this.endTime,
    this.startTime,
    this.intervals,
  });

  factory Timeline.fromJson(Map<String, dynamic> json) => Timeline(
    timestep: json["timestep"],
    endTime: json["endTime"] == null ? null : DateTime.parse(json["endTime"]),
    startTime: json["startTime"] == null ? null : DateTime.parse(json["startTime"]),
    intervals: json["intervals"] == null ? [] : List<Interval>.from(json["intervals"]!.map((x) => Interval.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "timestep": timestep,
    "endTime": endTime?.toIso8601String(),
    "startTime": startTime?.toIso8601String(),
    "intervals": intervals == null ? [] : List<dynamic>.from(intervals!.map((x) => x.toJson())),
  };
}

class Interval {
  DateTime? startTime;
  Values? values;

  Interval({
    this.startTime,
    this.values,
  });

  factory Interval.fromJson(Map<String, dynamic> json) => Interval(
    startTime: json["startTime"] == null ? null : DateTime.parse(json["startTime"]),
    values: json["values"] == null ? null : Values.fromJson(json["values"]),
  );

  Map<String, dynamic> toJson() => {
    "startTime": startTime?.toIso8601String(),
    "values": values?.toJson(),
  };
}

class Values {
  double? humidity;
  int? precipitationProbability;
  double? temperature;
  int? weatherCode;

  Values({
    this.humidity,
    this.precipitationProbability,
    this.temperature,
    this.weatherCode,
  });

  factory Values.fromJson(Map<String, dynamic> json) => Values(
    humidity: json["humidity"]?.toDouble(),
    precipitationProbability: json["precipitationProbability"],
    temperature: json["temperature"]?.toDouble(),
    weatherCode: json["weatherCode"],
  );

  Map<String, dynamic> toJson() => {
    "humidity": humidity,
    "precipitationProbability": precipitationProbability,
    "temperature": temperature,
    "weatherCode": weatherCode,
  };
}
