import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class Utils {
  static final ImagePicker _picker = ImagePicker();

  static Future<List<String>> pickImages() async {
    List<String> imagePaths = [];

    // Pick multiple images from gallery
    final List<XFile>? images = await _picker.pickMultiImage();

    if (images != null) {
      for (var image in images) {
        // Save image to local storage and get its path
        String imagePath = await saveImageToLocalStorage(image);
        imagePaths.add(imagePath);
      }
    }

    return imagePaths;
  }

  // Save the image to local storage
  static Future<String> saveImageToLocalStorage(XFile image) async {
    // Get the app's document directory
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;

    // Create a unique file name and save the image
    final File newImage = await File(image.path)
        .copy('$path/${DateTime.now().millisecondsSinceEpoch}.jpg');

    return newImage.path;
  }

  // Fetch all images from the local storage
  static Future<List<File>> fetchAllImages() async {
    List<File> imageFiles = [];

    // Get the app's document directory
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;

    // Create a directory instance for the app's document directory
    final Directory imageDir = Directory(path);

    // List all files in the directory
    final List<FileSystemEntity> files = imageDir.listSync();

    // Filter out only image files (jpg, jpeg, png)
    for (var file in files) {
      if (file is File &&
          (file.path.endsWith('.jpg') ||
              file.path.endsWith('.jpeg') ||
              file.path.endsWith('.png'))) {
        imageFiles.add(file);
      }
    }

    return imageFiles;
  }

  //delete perticular image from local
  static Future<void> deleteImage(String imagePath) async {
    // Delete the image from local storage
    final File image = File(imagePath);
    await image.delete();
  }
  
}
