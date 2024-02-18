import 'package:flutter/material.dart';

class GetLecturerInfo {
  final int statusCode;
  final String message;
  final List<Lecturer> data;

  GetLecturerInfo({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory GetLecturerInfo.fromJson(Map<String, dynamic> json) {
    try {
      var dataJson = json["data"] as List;

      List<Lecturer> lecturerData =
          dataJson.isNotEmpty ? dataJson.map((e) => Lecturer.fromJson(e)).toList() : [];
      return GetLecturerInfo(
          statusCode: json["statusCode"], message: json["message"], data: lecturerData);
    } catch (err, s) {
      debugPrint("$err");
      Error.throwWithStackTrace(err, s);
    }
  }
}

class Lecturer {
  final int id;
  final String name;
  final String position;
  final String image;
  final List<Courses> courseData;

  Lecturer({
    required this.id,
    required this.image,
    required this.name,
    required this.position,
    required this.courseData,
  });

  factory Lecturer.fromJson(Map<String, dynamic> json) {
    try {
      var dataJson = json["courses"] as List;

      List<Courses> courseData =
          dataJson.isNotEmpty ? dataJson.map((e) => Courses.fromJson(e)).toList() : [];
      return Lecturer(
          id: json["id"],
          image: json["image"],
          name: json["name"],
          position: json["position"],
          courseData: courseData);
    } catch (err, s) {
      debugPrint("$err");
      Error.throwWithStackTrace(err, s);
    }
  }
}

class Courses {
  final int id;
  final String title;
  final String description;
  final String date;
  final String level;

  Courses({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.level,
  });

  factory Courses.fromJson(Map<String, dynamic> json) {
    try {
      return Courses(
          id: json["id"],
          title: json["title"],
          description: json["description"],
          date: json["date"],
          level: json["level"]);
    } catch (err, s) {
      debugPrint("$err");
      Error.throwWithStackTrace(err, s);
    }
  }
}
