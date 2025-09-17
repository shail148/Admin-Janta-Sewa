import 'package:get/get.dart';

class AuthorizedUserController extends GetxController {
  // ✅ Observable step
  var currentStep = 0.obs;

  // ✅ Go to next step
  void nextStep() {
    if (currentStep.value < 2) {
      currentStep.value++;
    }
  }

  // ✅ Go back
  void previousStep() {
    if (currentStep.value > 0) {
      currentStep.value--;
    }
  }

  // ✅ Final submit action
  void submit() {
    Get.snackbar("Success", "Authorized User Created Successfully!");
  }
}
