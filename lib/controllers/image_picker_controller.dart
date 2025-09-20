import 'dart:io';
import 'package:admin_jantasewa/widgets/custom_snackbar.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class ImagePickerController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  var selectedImage = Rxn<File>();

  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(source: source);
      if (image != null) {
        File? croppedFile = await _cropImage(File(image.path));
        if (croppedFile != null) {
          selectedImage.value = croppedFile;
        } else {
          CustomSnackbar.showError(
            title: 'Cancelled',
            message: 'Image cropping cancelled.',
          );
        }
      }
    } catch (e) {
      CustomSnackbar.showError(
        title: 'Error',
        message: "Failed to pick image: $e",
      );
      if (kDebugMode) {
        print('Image pick error: $e');
      }
    }
  }

  Future<File?> _cropImage(File imageFile) async {
    final cropped = await ImageCropper().cropImage(
      sourcePath: imageFile.path,

      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: Colors.blue,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio4x3,
          ],
        ),
        IOSUiSettings(title: 'Crop Image'),
      ],
    );

    if (cropped != null) {
      return File(cropped.path);
    } else {
      return null;
    }
  }

  void clearImage() {
    selectedImage.value = null;
  }
}
