import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/widgets.dart';

class ImageUsecase {
  ClipRRect imageFromBase64String(String base64String) {
    Uint8List bytes = base64Decode(base64String);
    return ClipRRect(
      borderRadius: BorderRadius.circular(30.0),
      child: Image.memory(
        bytes,
        width: 60.0,
        height: 60.0,
        fit: BoxFit.fill,
      ),
    );
  }
}
