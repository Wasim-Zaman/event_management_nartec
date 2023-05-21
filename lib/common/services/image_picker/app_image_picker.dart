import 'dart:io';

import 'package:image_picker/image_picker.dart';

Future<File?> appImagePicker(ImageSource imageSource) async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: imageSource);

  if (pickedFile == null) {
    // User canceled the picker
    return null;
  }

  return File(pickedFile.path);
}
