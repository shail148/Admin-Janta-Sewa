import 'package:admin_jantasewa/widgets/colors.dart';
import 'package:admin_jantasewa/widgets/custom_app_bar.dart';
import 'package:admin_jantasewa/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/ourJourney/our_journey_controller.dart';
import '../../models/ourJourney/our_journey_model.dart';
import 'create_ourjourney_page.dart';
import 'package:url_launcher/url_launcher_string.dart'; // pubspec: url_launcher:^6.3.0

class ViewOurjourneyPage extends StatefulWidget {
  final OurJourneyModel? journey;
  final int? index; // optional: pass directly if you have it
  const ViewOurjourneyPage({super.key, this.journey, this.index});

  @override
  State<ViewOurjourneyPage> createState() => _ViewOurjourneyPageState();
}

class _ViewOurjourneyPageState extends State<ViewOurjourneyPage> {
  final OurJourneyController controller = Get.find<OurJourneyController>();

  OurJourneyModel? _journey;
  int? _editIndex;

  @override
  void initState() {
    super.initState();

    // Prefer explicit prop, else try Get.arguments
    final arg = (Get.arguments is OurJourneyModel)
        ? Get.arguments as OurJourneyModel
        : null;
    _journey = widget.journey ?? arg;

    // Resolve index for edit flow
    _editIndex = widget.index;
    if (_editIndex == null && _journey != null) {
      // Try finding by identity first
      int i = controller.journeyList.indexOf(_journey!);
      if (i == -1) {
        // Fallback: match by key fields (in case a copied object was passed)
        i = controller.journeyList.indexWhere(
          (e) =>
              e.name == _journey!.name &&
              e.title == _journey!.title &&
              e.partyName == _journey!.partyName &&
              e.fromYear == _journey!.fromYear &&
              e.toYear == _journey!.toYear &&
              e.imagePath == _journey!.imagePath,
        );
      }
      if (i != -1) _editIndex = i;
    }
  }

  @override
  Widget build(BuildContext context) {
    final j = _journey;

    return Scaffold(
      appBar: CustomTopAppBar(
        title: 'JANTA SEWA',
        leftIcon: Icon(Icons.arrow_back_ios, color: AppColors.primary),
        onLeftTap: () => Get.back(),
      ),
      body: j == null
          ? const Center(child: Text('No details available'))
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Uploaded Image',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: _JourneyImage(path: j.imagePath, height: 200),
                  ),
                  const SizedBox(height: 16),

                  const Text(
                    'Name',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  Text(j.name, style: const TextStyle(fontSize: 15)),
                  const SizedBox(height: 8),

                  const Text(
                    'Title',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  Text(j.title, style: const TextStyle(fontSize: 15)),
                  const SizedBox(height: 8),

                  const Text(
                    'Party Name',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  Text(j.partyName, style: const TextStyle(fontSize: 15)),
                  const SizedBox(height: 8),

                  const Text(
                    'Quote',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  Text(j.quote, style: const TextStyle(fontSize: 15)),
                  const SizedBox(height: 8),

                  Row(
                    children: [
                      const Text(
                        'From :',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${j.fromYear}',
                        style: const TextStyle(fontSize: 15),
                      ),
                      const Spacer(),
                      const Text(
                        'To :',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 8),
                      Text('${j.toYear}', style: const TextStyle(fontSize: 15)),
                    ],
                  ),

                  const SizedBox(height: 16),

                  if ((j.filePath ?? '').isNotEmpty)
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        icon: const Icon(Icons.picture_as_pdf),
                        label: const Text('Open Attached File'),
                        onPressed: () async {
                          final url = j.filePath!;
                          if (await canLaunchUrlString(url)) {
                            await launchUrlString(
                              url,
                              mode: LaunchMode.externalApplication,
                            );
                          } else {
                            Get.snackbar(
                              'Error',
                              'Cannot open the file URL',
                              snackPosition: SnackPosition.BOTTOM,
                            );
                          }
                        },
                      ),
                    ),

                  const SizedBox(height: 30),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomButton(
                        text: 'Cancel',
                        height: 40,
                        width: 100,
                        textSize: 14,
                        onPressed: () => Get.back(),
                        backgroundColor: Colors.white,
                        textColor: Colors.black,
                        borderColor: AppColors.primary,
                      ),
                      const SizedBox(width: 12),
                      CustomButton(
                        height: 40,
                        width: 100,
                        text: 'Edit',
                        textSize: 14,
                        backgroundColor: AppColors.primary,
                        onPressed: () {
                          Get.to(
                            () => CreateOurjourneyPage(
                              journey: j,
                              isEdit: true,
                              editIndex:
                                  _editIndex, // may be null; your Create page handles fallback
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}

/// Renders asset or network image with a soft fallback
class _JourneyImage extends StatelessWidget {
  final String path;
  final double height;
  const _JourneyImage({required this.path, required this.height});

  @override
  Widget build(BuildContext context) {
    Widget fallback = Container(
      height: height,
      width: double.infinity,
      color: Colors.grey.shade200,
      alignment: Alignment.center,
      child: const Icon(Icons.image_not_supported_outlined),
    );

    if (path.isEmpty) return fallback;

    if (path.startsWith('http')) {
      return Image.network(
        path,
        height: height,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => fallback,
      );
    }
    return Image.asset(
      path,
      height: height,
      width: double.infinity,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => fallback,
    );
  }
}
