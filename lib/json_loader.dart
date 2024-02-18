import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class JsonLoader {
  static Future<Map<String, dynamic>> loadJson(String path) async {
    String jsonString = await rootBundle.loadString(path);

    return json.decode(jsonString);
  }
}
