// controllers/ourJourney/media_upload_controller.dart
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';

class PickedFile {
  final String name;
  final int size; // bytes
  final String path;
  PickedFile({required this.name, required this.size, required this.path});
}

class MediaUploadController extends GetxController {
  // ------------- BANNER -------------
  final bannerFiles = <PickedFile>[].obs;

  // ------------- SPEECHES -------------
  final addressedBy = ''.obs;
  final speechDesc = ''.obs;
  final selectedState = ''.obs;
  final speechThumb = Rx<PickedFile?>(null);
  final speechFiles = <PickedFile>[].obs;

  // ------------- GALLERY -------------
  final galleryDesc = ''.obs;
  final galleryThumb = Rx<PickedFile?>(null);
  final galleryFiles = <PickedFile>[].obs;

  Future<void> pickFilesTo(
    RxList<PickedFile> target, {
    List<String>? allowedExtensions,
    bool allowMultiple = true,
  }) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions:
          allowedExtensions ?? const ['jpg', 'jpeg', 'png', 'webp', 'pdf'],
      allowMultiple: allowMultiple,
      withData: false,
    );
    if (result == null || result.files.isEmpty) return;

    for (final f in result.files) {
      if (f.path == null) continue;
      target.add(PickedFile(name: f.name, size: f.size, path: f.path!));
    }
  }

  Future<void> pickSingleTo(
    Rx<PickedFile?> target, {
    List<String>? allowedExtensions,
  }) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions:
          allowedExtensions ?? const ['jpg', 'jpeg', 'png', 'webp'],
      allowMultiple: false,
      withData: false,
    );
    if (result == null || result.files.isEmpty) return;

    final f = result.files.first;
    if (f.path == null) return;
    target.value = PickedFile(name: f.name, size: f.size, path: f.path!);
  }

  void removeAt(RxList<PickedFile> list, int index) {
    if (index >= 0 && index < list.length) list.removeAt(index);
  }

  Future<bool> submitBanner() async {
    if (bannerFiles.isEmpty) {
      _toast('Missing files', 'Please add at least one banner file');
      return false;
    }

    return true;
  }

  Future<bool> submitSpeech() async {
    if (addressedBy.value.trim().isEmpty) {
      _toast('Required', 'Please enter "Addressed by"');
      return false;
    }
    if (selectedState.value.isEmpty) {
      _toast('Required', 'Please select state');
      return false;
    }
    if (speechThumb.value == null) {
      _toast('Thumbnail', 'Please add a thumbnail');
      return false;
    }
    if (speechFiles.isEmpty) {
      _toast('Files', 'Please upload at least one file');
      return false;
    }

    return true;
  }

  Future<bool> submitGallery() async {
    if (galleryDesc.value.trim().isEmpty) {
      _toast('Required', 'Please add a description');
      return false;
    }
    if (galleryThumb.value == null) {
      _toast('Thumbnail', 'Please add a thumbnail');
      return false;
    }
    if (galleryFiles.isEmpty) {
      _toast('Files', 'Please upload at least one file');
      return false;
    }

    return true;
  }

  void _toast(String title, String msg) {
    Get.snackbar(title, msg);
  }
}
