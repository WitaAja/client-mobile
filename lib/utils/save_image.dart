import 'package:http/http.dart' show get;
import 'dart:io';
import 'package:path_provider/path_provider.dart';
class SaveImage {
  static void save(String url) async {
    try {
      print(url);
      var response = await get(url); // <--2
      var documentDirectory = await getApplicationDocumentsDirectory();
      var firstPath = documentDirectory.path + "/images";
      var filePathAndName = documentDirectory.path + '/images/pic.jpg';
      await Directory(firstPath).create(recursive: true);
      File file2 = new File(filePathAndName);
      file2.writeAsBytesSync(response.bodyBytes);
    } catch (error) {
      print(error);
    }
  }
}
