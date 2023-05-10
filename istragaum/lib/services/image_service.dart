import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';

class ImageService {
  Future<List<String>> retrieveImages() async {
    final directory = await getApplicationDocumentsDirectory();
    List<String> images = directory
        .listSync()
        .map((item) => item.path)
        .where((item) => item.endsWith('.png'))
        .toList();

    images.sort((a, b) => b.compareTo(a));

    return images;
  }

  saveImage(Uint8List? imageBytes) async {
    if (imageBytes != null) {
      final DateTime filename = DateTime.now();
      final directory = await getApplicationDocumentsDirectory();
      final imagePath =
          await File('${directory.path}/img-$filename.png').create();
      await imagePath.writeAsBytes(imageBytes);
    }
  }
}
