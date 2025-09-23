// main.dart
// JANTA SEWA – Media Upload (Banner | Speeches | Gallery)
// Full, self-contained demo that matches your UI mocks.
import 'dart:math' as math;
import 'package:admin_jantasewa/constants/colors.dart';
import 'package:admin_jantasewa/widgets/custom_app_bar.dart';
import 'package:admin_jantasewa/widgets/custom_text.dart';
import 'package:admin_jantasewa/widgets/file_upload.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(
    const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: JantaSewaMediaScreen(),
    ),
  );
}

/// ===== Color palette (matches your mock) =====
class _Palette {
  static const primary = Color(0xFF3D3270); // deep purples
  static const primaryText = Color(0xFF2F2A4A); // charcoal
  static const border = Color(0xFFE6E6F0); // soft gray
  static const bg = Color(0xFFF7F7FB); // light panel bg
  static const danger = Color(0xFFE11D48); // red
  static const hint = Color(0xFF8A8AA3); // muted
}

/// ===== Primary button (filled / outline) =====
class _PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool loading;
  final bool outline;
  const _PrimaryButton({
    super.key,
    required this.label,
    required this.onTap,
    this.loading = false,
    this.outline = false,
  });

  @override
  Widget build(BuildContext context) {
    final child = loading
        ? const SizedBox(
            height: 18,
            width: 18,
            child: CircularProgressIndicator(strokeWidth: 2),
          )
        : Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: outline ? _Palette.primary : Colors.white,
            ),
          );
    return SizedBox(
      height: 44,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: outline ? Colors.white : _Palette.primary,
          foregroundColor: outline ? _Palette.primary : Colors.white,
          side: BorderSide(
            color: _Palette.primary.withOpacity(outline ? 1 : 0),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 0,
        ),
        onPressed: loading ? null : onTap,
        child: child,
      ),
    );
  }
}

class _TopTabs extends StatelessWidget {
  const _TopTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: _Palette.border),
        ),
        child: TabBar(
          dividerColor: Colors.transparent,
          overlayColor: WidgetStateProperty.all(Colors.transparent),
          labelPadding: EdgeInsets.zero,
          labelColor: Colors.white,
          unselectedLabelColor: _Palette.primaryText,
          labelStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          indicator: ShapeDecoration(
            color: _Palette.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          indicatorPadding: const EdgeInsets.all(4),
          tabs: const [
            _SegmentTab('Banner'),
            _SegmentTab('Speeches'),
            _SegmentTab('Gallery'),
          ],
        ),
      ),
    );
  }
}

class _SegmentTab extends StatelessWidget {
  final String text;
  const _SegmentTab(this.text, {super.key});
  @override
  Widget build(BuildContext context) {
    return Tab(height: 40, child: Center(child: Text(text)));
  }
}

class UploadDropZone extends StatelessWidget {
  final String title;
  final String subText;
  final VoidCallback onPick;
  final IconData icon;
  const UploadDropZone({
    super.key,
    required this.title,
    required this.subText,
    required this.onPick,
    this.icon = Icons.file_upload_outlined,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      decoration: BoxDecoration(
        color: _Palette.bg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _Palette.border, width: 1.2),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onPick,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 34, color: _Palette.hint),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: _Palette.primaryText,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subText,
                style: const TextStyle(fontSize: 12, color: _Palette.hint),
              ),
              const SizedBox(height: 10),
              _PrimaryButton(label: 'Browse', onTap: onPick, outline: true),
            ],
          ),
        ),
      ),
    );
  }
}

/// ===== File chip/list tile =====
class FileTile extends StatelessWidget {
  final PickedFile file;
  final VoidCallback onRemove;
  const FileTile({super.key, required this.file, required this.onRemove});

  String _readableSize(int bytes) {
    if (bytes <= 0) return '0 B';
    const units = ['B', 'KB', 'MB', 'GB'];
    final i = (math.log(bytes) / math.log(1024)).floor().clamp(
      0,
      units.length - 1,
    );
    final size = (bytes / math.pow(1024, i)).toStringAsFixed(2);
    return '$size ${units[i]}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: _Palette.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.insert_drive_file_outlined, color: _Palette.hint),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              file.name,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 13, color: _Palette.primaryText),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            _readableSize(file.size),
            style: const TextStyle(fontSize: 12, color: _Palette.hint),
          ),
          const SizedBox(width: 8),
          IconButton(
            tooltip: 'Remove',
            onPressed: onRemove,
            icon: const Icon(
              Icons.close_rounded,
              color: _Palette.hint,
              size: 18,
            ),
          ),
        ],
      ),
    );
  }
}

/// ===== Small input widgets =====
const _labelStyle = TextStyle(
  fontSize: 13,
  fontWeight: FontWeight.w600,
  color: _Palette.primaryText,
);

class _TextBox extends StatelessWidget {
  final String hint;
  final int maxLines;
  final ValueChanged<String>? onChanged;
  const _TextBox({
    required this.hint,
    this.maxLines = 1,
    this.onChanged,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: maxLines,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hint,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 12,
        ),
        filled: true,
        fillColor: Colors.white,
        border: _outline(),
        enabledBorder: _outline(),
        focusedBorder: _outline(color: _Palette.primary),
      ),
    );
  }

  OutlineInputBorder _outline({Color color = _Palette.border}) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: color),
      );
}

// ignore: unused_element
class _DropdownBox extends StatelessWidget {
  final List<String> items;
  final String? value;
  final ValueChanged<String?>? onChanged;
  final String hint;
  const _DropdownBox({
    super.key,
    required this.items,
    required this.value,
    required this.onChanged,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      isExpanded: true,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 12,
        ),
        filled: true,
        fillColor: Colors.white,
        border: _outline(),
        enabledBorder: _outline(),
        focusedBorder: _outline(color: _Palette.primary),
      ),
      hint: Text(hint),
      items: items
          .map((s) => DropdownMenuItem<String>(value: s, child: Text(s)))
          .toList(),
      onChanged: onChanged,
    );
  }

  OutlineInputBorder _outline({Color color = _Palette.border}) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: color),
      );
}

/// ===== Main Screen =====
class JantaSewaMediaScreen extends StatelessWidget {
  const JantaSewaMediaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(MediaUploadController());

    return Scaffold(
      appBar: CustomTopAppBar(
        title: 'Janta Sewa',
        leftIcon: Icon(Icons.arrow_back_ios, color: AppColors.primary),
        onLeftTap: () => Get.back(),
      ),

      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            const SizedBox(height: 8),
            const _TopTabs(),
            const SizedBox(height: 8),
            Expanded(
              child: TabBarView(
                children: [
                  _BannerTab(controller: c),
                  _SpeechTab(controller: c),
                  _GalleryTab(controller: c),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
/// ---------- BANNER TAB ----------
class _BannerTab extends StatelessWidget {
  final MediaUploadController controller;
  const _BannerTab({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView(
        children: [
          CustomTextWidget(text: 'Upload Banner'),
          const SizedBox(height: 8),
          CustomFileUpload(),
          // UploadDropZone(
          //   title: 'Upload Banner',
          //   subText: 'JPG, PNG, PDF (max 20MB)',
          //   onPick: () => controller.pickFilesTo(
          //     controller.bannerFiles,
          //     allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
          //   ),
          // ),
          const SizedBox(height: 12),
          Obx(
            () => Column(
              children: List.generate(
                controller.bannerFiles.length,
                (i) => FileTile(
                  file: controller.bannerFiles[i],
                  onRemove: () =>
                      controller.removeAt(controller.bannerFiles, i),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _PrimaryButton(
                  label: 'Cancel',
                  outline: true,
                  onTap: () {
                    controller.bannerFiles.clear();
                    Get.back<void>();
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _PrimaryButton(
                  label: 'Upload',
                  onTap: () async {
                    final ok = await controller.submitBanner();
                    if (ok) Get.snackbar('Success', 'Banner uploaded');
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// ---------- SPEECHES TAB ----------
class _SpeechTab extends StatelessWidget {
  final MediaUploadController controller;
  const _SpeechTab({required this.controller});

  @override
  Widget build(BuildContext context) {
    // final states = const [
    //   'Andhra Pradesh',
    //   'Assam',
    //   'Bihar',
    //   'Chhattisgarh',
    //   'Delhi',
    //   'Gujarat',
    //   'Karnataka',
    //   'Maharashtra',
    //   'Madhya Pradesh',
    //   'Odisha',
    //   'Punjab',
    //   'Rajasthan',
    //   'Tamil Nadu',
    //   'Telangana',
    //   'Uttar Pradesh',
    //   'Uttarakhand',
    //   'West Bengal',
    // ];

    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: [
          Text('Addressed by', style: _labelStyle),
          const SizedBox(height: 6),
          _TextBox(
            hint: 'Enter Name',
            onChanged: (v) => controller.addressedBy.value = v,
          ),
          const SizedBox(height: 14),

          Text('Add Description', style: _labelStyle),
          const SizedBox(height: 6),
          _TextBox(
            maxLines: 3,
            hint: 'Add description (max 200)',
            onChanged: (v) => controller.speechDesc.value = v,
          ),
          const SizedBox(height: 14),

          // Text('Select State', style: _labelStyle),
          // const SizedBox(height: 6),
          // Obx(
          //   () => _DropdownBox(
          //     items: states,
          //     value: controller.selectedState.value.isEmpty
          //         ? null
          //         : controller.selectedState.value,
          //     onChanged: (v) => controller.selectedState.value = v ?? '',
          //     hint: 'Choose state',
          //   ),
          // ),
          // const SizedBox(height: 16),
          Text('Upload Thumbnail', style: _labelStyle),
          const SizedBox(height: 6),

          CustomFileUpload(),

          // Obx(
          //   () => Column(
          //     children: List.generate(
          //       controller.speechFiles.length,
          //       (i) => FileTile(
          //         file: controller.speechFiles[i],
          //         onRemove: () =>
          //             controller.removeAt(controller.speechFiles, i),
          //       ),
          //     ),
          //   ),
          // ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _PrimaryButton(
                  label: 'Cancel',
                  outline: true,
                  onTap: () {
                    controller.addressedBy.value = '';
                    controller.speechDesc.value = '';
                    controller.selectedState.value = '';
                    controller.speechThumb.value = null;
                    controller.speechFiles.clear();
                    Get.back<void>();
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _PrimaryButton(
                  label: 'Upload',
                  onTap: () async {
                    final ok = await controller.submitSpeech();
                    if (ok) Get.snackbar('Success', 'Speech uploaded');
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// ---------- GALLERY TAB ----------
class _GalleryTab extends StatelessWidget {
  final MediaUploadController controller;
  const _GalleryTab({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: [
          Text('Add Description', style: _labelStyle),
          const SizedBox(height: 6),
          _TextBox(
            maxLines: 3,
            hint: 'Describe this set (max 200)',
            onChanged: (v) => controller.galleryDesc.value = v,
          ),
          const SizedBox(height: 16),

          Text('Upload Thumbnail', style: _labelStyle),
          const SizedBox(height: 6),
          CustomFileUpload(),
          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: _PrimaryButton(
                  label: 'Cancel',
                  outline: true,
                  onTap: () {
                    controller.galleryDesc.value = '';
                    controller.galleryThumb.value = null;
                    controller.galleryFiles.clear();
                    Get.back<void>();
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _PrimaryButton(
                  label: 'Upload',
                  onTap: () async {
                    final ok = await controller.submitGallery();
                    if (ok) Get.snackbar('Success', 'Gallery uploaded');
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PickedFile {
  final String name;
  final int size; // in bytes
  PickedFile(this.name, this.size);
}

class MediaUploadController extends GetxController {
  // Banner
  final RxList<PickedFile> bannerFiles = <PickedFile>[].obs;

  // Speech
  final RxString addressedBy = ''.obs;
  final RxString speechDesc = ''.obs;
  final RxString selectedState = ''.obs;
  final Rx<PickedFile?> speechThumb = Rx<PickedFile?>(null);
  final RxList<PickedFile> speechFiles = <PickedFile>[].obs;

  // Gallery
  final RxString galleryDesc = ''.obs;
  final Rx<PickedFile?> galleryThumb = Rx<PickedFile?>(null);
  final RxList<PickedFile> galleryFiles = <PickedFile>[].obs;

  /// Simulate picking multiple files (adds a dummy file).
  void pickFilesTo(
    RxList<PickedFile> target, {
    List<String>? allowedExtensions,
  }) {
    final idx = target.length + 1;
    target.add(
      PickedFile(
        'Sample_$idx.${(allowedExtensions ?? ['png']).first}',
        2 * 1024 * 1024,
      ),
    );
  }

  /// Simulate picking single file (thumbnail).
  void pickSingleTo(Rx<PickedFile?> target) {
    target.value = PickedFile(
      'thumb_${DateTime.now().millisecondsSinceEpoch}.png',
      420 * 1024,
    );
  }

  /// Remove item from any RxList.
  void removeAt(RxList<PickedFile> list, int index) {
    if (index >= 0 && index < list.length) list.removeAt(index);
  }

  Future<bool> submitBanner() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return bannerFiles.isNotEmpty;
  }

  Future<bool> submitSpeech() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return addressedBy.isNotEmpty || speechFiles.isNotEmpty;
  }

  Future<bool> submitGallery() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return galleryFiles.isNotEmpty || galleryThumb.value != null;
  }
}
