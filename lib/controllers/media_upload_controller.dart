import 'package:get/get.dart';

/// Local Picked File Model
class PickedFile {
  final String name;
  final int size;
  final String path; // ✅ store file path
  PickedFile(this.name, this.size, this.path);
}

/// Gallery ka model
class GalleryItem {
  final String title;
  final String description;
  final String imagePath; // ✅ changed to path
  final DateTime date;

  GalleryItem({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.date,
  });
}

/// Speech ka model
class SpeechItem {
  final String title;
  final String description;
  final String imagePath; // ✅ changed to path
  final DateTime date;

  SpeechItem({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.date,
  });
}

/// Banner ka model (without title)
class BannerItem {
  final String imagePath; // ✅ changed to path
  final DateTime date;

  BannerItem({
    required this.imagePath,
    required this.date,
  });
}

class MediaUploadController extends GetxController {
  // Banner
  final RxList<PickedFile> bannerFiles = <PickedFile>[].obs;
  final RxList<BannerItem> banners = <BannerItem>[].obs;

  // Speech (form fields)
  final RxString addressedBy = ''.obs;
  final RxString speechDesc = ''.obs;
  final RxList<PickedFile> speechFiles = <PickedFile>[].obs;
  final RxList<SpeechItem> speeches = <SpeechItem>[].obs;

  // Gallery
  final RxString galleryDesc = ''.obs;
  final RxList<PickedFile> galleryFiles = <PickedFile>[].obs;
  final RxList<GalleryItem> galleries = <GalleryItem>[].obs;

  // Flags for toggling form vs list
  final RxBool showBannerForm = false.obs;
  final RxBool showSpeechForm = false.obs;
  final RxBool showGalleryForm = false.obs;

  /// Dummy picker (replace with real FilePicker/ImagePicker later)
  void pickFilesTo(RxList<PickedFile> target) {
    target.add(
      PickedFile(
        'Sample_${target.length + 1}.png',
        2 * 1024 * 1024,
        '/storage/emulated/0/Download/sample.png', // ✅ dummy path
      ),
    );
  }

  void removeAt(RxList list, int index) {
    if (index >= 0 && index < list.length) list.removeAt(index);
  }

  // ---------- Submit Methods ----------
  Future<bool> submitBanner() async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (bannerFiles.isNotEmpty) {
      banners.add(
        BannerItem(
          imagePath: bannerFiles.first.path, // ✅ real uploaded image
          date: DateTime.now(),
        ),
      );
      bannerFiles.clear();
      return true;
    }
    return false;
  }

  Future<bool> submitSpeech() async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (addressedBy.isNotEmpty &&
        speechDesc.isNotEmpty &&
        speechFiles.isNotEmpty) {
      speeches.add(
        SpeechItem(
          title: "By ${addressedBy.value}",
          description: speechDesc.value,
          imagePath: speechFiles.first.path, // ✅ real uploaded image
          date: DateTime.now(),
        ),
      );
      addressedBy.value = '';
      speechDesc.value = '';
      speechFiles.clear();
      return true;
    }
    return false;
  }

  Future<bool> submitGallery() async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (galleryDesc.isNotEmpty && galleryFiles.isNotEmpty) {
      galleries.add(
        GalleryItem(
          title: "By Shri Vijay Baghel",
          description: galleryDesc.value,
          imagePath: galleryFiles.first.path, // ✅ real uploaded image
          date: DateTime.now(),
        ),
      );
      galleryDesc.value = '';
      galleryFiles.clear();
      return true;
    }
    return false;
  }
}
