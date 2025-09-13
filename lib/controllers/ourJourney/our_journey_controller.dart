import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../models/ourJourney/our_journey_model.dart';

class OurJourneyController extends GetxController {
  final RxList<OurJourneyModel> journeyList = <OurJourneyModel>[].obs;

  Future<void> loadJourneyData() async {
    try {
      final String data = await rootBundle.loadString('assets/data/our_journey_data.json');
      final List<dynamic> jsonResult = json.decode(data);
      journeyList.value = jsonResult.map((e) => OurJourneyModel.fromJson(e)).toList();
    } catch (e) {
      // Optional: show a snackbar/log
      // Get.snackbar('Error', 'Failed to load journey data');
    }
  }

  // --- CRUD ---

  void addJourney(OurJourneyModel model) {
    journeyList.add(model);
    update(); // not needed for Obx, but safe if someone uses GetBuilder
  }

  /// Returns true if edit succeeded (index in range)
  bool editJourney(int index, OurJourneyModel model) {
    if (index < 0 || index >= journeyList.length) return false;
    journeyList[index] = model;
    update();
    return true;
  }

  /// Returns true if delete succeeded (index in range)
  bool deleteJourney(int index) {
    if (index < 0 || index >= journeyList.length) return false;
    journeyList.removeAt(index);
    update();
    return true;
  }

  /// Convenience: if index is null -> add, else edit at index.
  /// Returns edited index (or new index after add).
  int upsertJourney(OurJourneyModel model, {int? index}) {
    if (index == null) {
      journeyList.add(model);
      update();
      return journeyList.length - 1;
    } else {
      if (index < 0 || index >= journeyList.length) {
        // Fallback to add if index invalid
        journeyList.add(model);
        update();
        return journeyList.length - 1;
      }
      journeyList[index] = model;
      update();
      return index;
    }
  }

  OurJourneyModel? getByIndex(int index) {
    if (index < 0 || index >= journeyList.length) return null;
    return journeyList[index];
  }
}
