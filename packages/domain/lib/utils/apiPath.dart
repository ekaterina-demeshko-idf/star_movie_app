import 'dart:core';
import 'const.dart';

class ApiPath {
  static String getCastImagePath(String? filePath) {
    return '${Config.imagePath}$filePath';
  }
}
