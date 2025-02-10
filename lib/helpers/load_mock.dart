import 'dart:convert';

import 'package:flutter/services.dart';

class LoadMock {
  Future<Map<String, dynamic>> loadJsonFromAssets(String filePath) async {
    String jsonString = await rootBundle.loadString(filePath, cache: false);
    return jsonDecode(jsonString);
  }
}
