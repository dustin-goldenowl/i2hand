import 'package:flutter/foundation.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  String urlTrim() {
    String text = trim().toLowerCase();
    for (final e in ['https://www.', 'http://www.', 'https://', 'http://']) {
      if (text.indexOf(e) == 0) {
        text = text.substring(e.length);
      }
    }
    if (text.isNotEmpty && text[text.length - 1] == '/') {
      text = text.substring(0, text.length - 1);
    }
    return text;
  }

  String capitalizeEachText() {
    List<String> texts = split(' ');
    String capitalizeText = '';
    for (String text in texts) {
      capitalizeText = "$capitalizeText ${text.capitalize()}";
    }
    return capitalizeText.trim();
  }
}

extension ListStringExtension on List<String> {
  Uint8List convertToUint8List() {
    return Uint8List.fromList(map((e) => int.parse(e)).toList());
  }
}
