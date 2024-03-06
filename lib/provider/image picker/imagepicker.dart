import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_student_app/getx/snackbar/snackbar.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerController extends ChangeNotifier {
  Future<File?> selectImageFromGalleryOrCamera(ImageSource option) async {
    File? image;
    try {
      final pickedImage = await ImagePicker().pickImage(source: option);
      if (pickedImage != null) {
        image = File(pickedImage.path);
      }
    } catch (e) {
      throw Exception('Error selecting image: $e');
    }
    return image;
  }
}
