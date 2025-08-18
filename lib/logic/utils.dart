import 'package:flutter/services.dart' show rootBundle;

Future<String> loadMarkdownFile(String path) async {
  return await rootBundle.loadString(path);
}
