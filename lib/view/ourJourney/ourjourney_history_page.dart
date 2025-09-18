import 'package:admin_jantasewa/view/ourJourney/create_ourjourney_page.dart';
import 'package:admin_jantasewa/view/ourJourney/view_ourjourney_page.dart';
import 'package:admin_jantasewa/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/ourJourney/our_journey_controller.dart';
import 'package:admin_jantasewa/widgets/colors.dart';
import 'package:admin_jantasewa/widgets/custom_app_bar.dart';

class OurjourneyHistoryPage extends StatefulWidget {
  const OurjourneyHistoryPage({super.key});

  @override
  State<OurjourneyHistoryPage> createState() => _OurjourneyHistoryPageState();
}

class _OurjourneyHistoryPageState extends State<OurjourneyHistoryPage> {
  final OurJourneyController controller = Get.put(OurJourneyController());

  @override
  void initState() {
    super.initState();
    controller.loadJourneyData();
  }

  Future<void> _confirmDelete(int index) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete entry?'),
        content: const Text('This will remove the journey from the list.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (ok == true) {
      controller.deleteJourney(index);
      Get.snackbar(
        'Deleted',
        'Journey removed.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomTopAppBar(
        title: 'JANTA SEWA',
        leftIcon: Icon(Icons.arrow_back_ios, color: AppColors.primary),
        onLeftTap: () => Get.back(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Our Journey',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    alignment: Alignment.center,
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 5,
                    ),
                  ),
                  onPressed: () {
                    // ADD: open create page in add mode
                    Get.to(() => const CreateOurjourneyPage(isEdit: false));
                  },
                  child: const Row(
                    children: [
                      Icon(Icons.add, color: Colors.white, size: 12),
                      SizedBox(width: 6),
                      Text(
                        "Add",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // List
            Expanded(
              child: Obx(() {
                final items = controller.journeyList;
                if (items.isEmpty) {
                  // Might be initial state before asset load or truly empty
                  return RefreshIndicator(
                    onRefresh: controller.loadJourneyData,
                    child: ListView(
                      children: const [
                        SizedBox(height: 160),
                        Center(
                          child: Text(
                            'No journeys found. Pull down to refresh or tap Add.',
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: controller.loadJourneyData,
                  child: ListView.separated(
                    itemCount: items.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final journey = items[index];

                      return InkWell(
                        onTap: () {
                          // VIEW on tile tap
                          Get.to(() => ViewOurjourneyPage(journey: journey));
                        },
                        borderRadius: BorderRadius.circular(15),
                        child: Card(
                          elevation: 0,
                          color: AppColors.white,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: AppColors.textColor.withAlpha(50),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Image (asset or network) + fallback
                                SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: _JourneyThumb(
                                      path: journey.imagePath,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),

                                // Text & menu
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            '${journey.fromYear}-${journey.toYear}',
                                            style: const TextStyle(
                                              color: Colors.blueGrey,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const Spacer(),

                                          // Three-dot menu
                                          GestureDetector(
                                            onTapDown: (TapDownDetails details) async {
                                              final selected =
                                                  await showMenu<String>(
                                                    context: context,
                                                    position:
                                                        RelativeRect.fromLTRB(
                                                          details
                                                              .globalPosition
                                                              .dx,
                                                          details
                                                              .globalPosition
                                                              .dy,
                                                          0,
                                                          0,
                                                        ),
                                                    items: const [
                                                      PopupMenuItem(
                                                        value: 'view',
                                                        child: Text('View'),
                                                      ),
                                                      PopupMenuItem(
                                                        value: 'edit',
                                                        child: Text('Edit'),
                                                      ),
                                                      PopupMenuItem(
                                                        value: 'delete',
                                                        child: Text('Delete'),
                                                      ),
                                                    ],
                                                  );

                                              if (selected == 'view') {
                                                Get.to(
                                                  () => ViewOurjourneyPage(
                                                    journey: journey,
                                                  ),
                                                );
                                              } else if (selected == 'edit') {
                                                // EDIT: pass journey (and index if your page supports it)
                                                Get.to(
                                                  () => CreateOurjourneyPage(
                                                    journey: journey,
                                                    isEdit: true,
                                                    editIndex:
                                                        index, // <-- remove if your page doesn't take it
                                                  ),
                                                );
                                              } else if (selected == 'delete') {
                                                await _confirmDelete(index);
                                              }
                                            },
                                            child: const Icon(
                                              Icons.more_vert,
                                              size: 18,
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                        ],
                                      ),
                                      const SizedBox(height: 4),

                                      CustomTextWidget(
                                        text: journey.name,
                                        color: AppColors.black,
                                        fontsize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      const SizedBox(height: 2),
                                      CustomTextWidget(
                                        text: journey.title,
                                        color: AppColors.textGrey,
                                        fontsize: 12,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

/// Helper to render either a network or asset image, with a graceful fallback.
class _JourneyThumb extends StatelessWidget {
  final String path;
  const _JourneyThumb({required this.path});

  @override
  Widget build(BuildContext context) {
    if (path.isEmpty) return const _ThumbFallback();
    if (path.startsWith('http')) {
      return Image.network(
        path,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => const _ThumbFallback(),
      );
    }
    return Image.asset(
      path,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => const _ThumbFallback(),
    );
  }
}

class _ThumbFallback extends StatelessWidget {
  const _ThumbFallback();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black12,
      child: const Center(child: Icon(Icons.image_not_supported_outlined)),
    );
  }
}
