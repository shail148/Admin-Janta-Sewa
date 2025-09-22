import 'package:get/get.dart';

class PickedFile {
  final String name;
  final int size;
  PickedFile(this.name, this.size);
}

/// Gallery ka model
class GalleryItem {
  final String title;
  final String description;
  final String imageUrl;
  final DateTime date;

  GalleryItem({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.date,
  });
}

/// Speech ka model
class SpeechItem {
  final String title;
  final String description;
  final String imageUrl;
  final DateTime date;

  SpeechItem({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.date,
  });
}

class MediaUploadController extends GetxController {
  // Banner
  final RxList<PickedFile> bannerFiles = <PickedFile>[].obs;

  // Speech (form fields)
  final RxString addressedBy = ''.obs;
  final RxString speechDesc = ''.obs;
  final RxList<PickedFile> speechFiles = <PickedFile>[].obs;

  // Uploaded speeches list
  final RxList<SpeechItem> speeches = <SpeechItem>[].obs;

  // Gallery
  final RxString galleryDesc = ''.obs;
  final RxList<PickedFile> galleryFiles = <PickedFile>[].obs;

  // Flags for toggling form vs list
  final RxBool showBannerForm = false.obs;
  final RxBool showSpeechForm = false.obs;
  final RxBool showGalleryForm = false.obs;

  /// Pick dummy file (simulate upload)
  void pickFilesTo(RxList<PickedFile> target) {
    target.add(PickedFile('Sample_${target.length + 1}.png', 2 * 1024 * 1024));
  }

  void removeAt(RxList<PickedFile> list, int index) {
    if (index >= 0 && index < list.length) list.removeAt(index);
  }

  // ---------- Submit Methods ----------

  Future<bool> submitBanner() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return bannerFiles.isNotEmpty;
  }

  Future<bool> submitSpeech() async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (addressedBy.isNotEmpty && speechDesc.isNotEmpty) {
      speeches.add(
        SpeechItem(
          title: "By ${addressedBy.value}",
          description: speechDesc.value,
          imageUrl: "https://placehold.co/150x100/png",
          date: DateTime.now(),
        ),
      );
      // clear form after submit
      addressedBy.value = '';
      speechDesc.value = '';
      speechFiles.clear();
      return true;
    }
    return false;
  }

  // Uploaded Galleries
  final RxList<GalleryItem> galleries = <GalleryItem>[].obs;

  Future<bool> submitGallery() async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (galleryDesc.isNotEmpty) {
      galleries.add(
        GalleryItem(
          title: "By Shri Vijay Baghel",
          description: galleryDesc.value,
          imageUrl: "https://placehold.co/150x100/png", 
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
