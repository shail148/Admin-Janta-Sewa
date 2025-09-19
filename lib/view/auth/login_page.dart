import 'package:admin_jantasewa/utils/form_validator.dart';
import 'package:admin_jantasewa/view/auth/registeration/admin_register.dart';
import 'package:admin_jantasewa/view/dashboard/dashboard.dart';
import 'package:admin_jantasewa/constants/colors.dart';
import 'package:admin_jantasewa/widgets/custom_button.dart';
import 'package:admin_jantasewa/widgets/custom_snackbar.dart';
import 'package:admin_jantasewa/widgets/custom_text.dart';
import 'package:admin_jantasewa/widgets/label_text.dart';
import 'package:admin_jantasewa/widgets/password_visibility.dart';
import 'package:admin_jantasewa/widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailPhoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  // final AuthController _authController = Get.put(AuthController());

  final PasswordVisibility passwordCtrl = Get.put(PasswordVisibility());
  @override
  void dispose() {
    emailPhoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // // ignore: unused_element
  // Future<void> _login() async {
  //   if (_formKey.currentState?.validate() ?? false) {
  //     Get.focusScope?.unfocus();
  //     CustomSnackbar.show(
  //       title: 'Please wait',
  //       message: 'Logging in...',
  //       backgroundColor: Colors.blue,
  //       icon: Icons.info_outline,
  //       duration: Duration(milliseconds: 800),
  //     );
  //     final result = await _authController.login(
  //       email: emailPhoneController.text.trim(),
  //       password: passwordController.text.trim(),
  //     );
  //     if (result['success'] == true) {
  //       CustomSnackbar.show(
  //         title: 'Success',
  //         message: 'Login successful',
  //         backgroundColor: Colors.green,
  //         icon: Icons.check_circle_outline,
  //       );
  //       //Get.offAll(() => BottomNav());
  //     } else {
  //       CustomSnackbar.show(
  //         title: 'Error',
  //         message: result['message']?.toString() ?? 'Login failed',
  //         backgroundColor: Colors.red,
  //         icon: Icons.error_outline,
  //       );
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: CustomTextWidget(
          text: "Janta Sewa",
          fontsize: 24,
          color: AppColors.textColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    'assets/images/indialogo.png',
                    height: 150,
                    width: 100,
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: CustomTextWidget(
                    text: "login_btn".tr,
                    fontsize: 30,
                    color: AppColors.textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomLabelText(
                        text: "enter_email_phone".tr,
                        isRequired: true,
                      ),
                      SizedBox(height: 5),
                      CustomTextFormField(
                        hintText: 'enter_email_phone'.tr,
                        controller: emailPhoneController,
                        //validator: FormValidator.validateEmail,
                      ),
                      CustomLabelText(text: "password".tr, isRequired: true),
                      SizedBox(height: 5),
                      Obx(
                        () => CustomTextFormField(
                          hintText: 'enter_password'.tr,
                          controller: passwordController,
                          obscureText: !passwordCtrl.isPasswordVisible.value,
                          suffixIcon: passwordCtrl.isPasswordVisible.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                          onSuffixTap: () {
                            passwordCtrl.toggleVisibility();
                          },
                          validator: (value) => FormValidator.validateRequired(
                            value,
                            'password'.tr,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              //Forgot Password Logic Here
                              //  Get.to(() => ResetPassword());
                            },
                            child: CustomTextWidget(
                              text: 'forgot_password'.tr,
                              color: AppColors.btnBgColor,
                              fontsize: 12,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      CustomButton(
                        text: 'login_btn'.tr,
                        textSize: 14,
                        backgroundColor: AppColors.btnBgColor,
                        height: 62,
                        width: double.infinity,
                        // onPressed: _login,
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            Get.focusScope?.unfocus();

                            final email = emailPhoneController.text.trim();
                            final password = passwordController.text.trim();

                            if (email == 'admin@gmail.com' &&
                                password == 'admin') {
                              CustomSnackbar.showSuccess(
                                title: 'Login',
                                message: 'Successful',
                              );
                              Get.offAll(() => DashboardPage());
                            } else {
                              CustomSnackbar.showError(
                                title: "Login Failed",
                                message: "Invalid email or password",
                              );
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextWidget(
                      text: 'dont_have_account'.tr,
                      fontsize: 12,
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        //add ontap Btn

                        Get.to(() => AuthorizedPersonRegister());
                      },
                      child: CustomTextWidget(
                        text: 'register_here'.tr,
                        fontsize: 12,
                        color: AppColors.btnBgColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
