import 'package:course_system/entities/get_lecturer_info.dart';
import 'package:flutter/material.dart';

import '../json_loader.dart';

class GetLecturerUsecase {
  Future<GetLecturerInfo> call() async {
    Map<String, dynamic> jsonData = await JsonLoader.loadJson('assets/data/data.json');

    GetLecturerInfo getLecturerInfo;

    try {
      getLecturerInfo = GetLecturerInfo.fromJson(jsonData);
    } catch (e, s) {
      debugPrint('get lecturer info error: $e, $s');
      rethrow;
    }

    return getLecturerInfo;
  }
}
