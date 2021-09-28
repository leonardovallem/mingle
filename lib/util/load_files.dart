import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

class LoadFiles {
  static Future<String> loadAsset(String asset) async {
    return await rootBundle.loadString("assets/" + asset);
  }
}