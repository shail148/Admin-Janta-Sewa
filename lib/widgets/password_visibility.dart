import 'package:get/get.dart';

class PasswordVisibility extends GetxController {
  RxBool isPasswordVisible = false.obs;

  void toggleVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }
}
