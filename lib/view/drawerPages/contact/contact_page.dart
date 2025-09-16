import 'package:admin_jantasewa/controllers/contact_page_controller.dart';
import 'package:admin_jantasewa/widgets/colors.dart';
import 'package:admin_jantasewa/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'edit_contact_page.dart';

class ContactPage extends StatelessWidget {
  final ContactController controller = Get.put(ContactController());

  ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: CustomTopAppBar(
        title: 'Edit Contact',
        leftIcon: Icon(Icons.arrow_back_ios, color: AppColors.btnBgColor),
        onLeftTap: () => Get.back(),
      ),
      body: Obx(() {
        final c = controller.contact.value;
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Contact",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              _infoTile(Icons.email, c.email),
              _infoTile(Icons.phone, c.telephone),
              _infoTile(Icons.phone_android, c.mobile),
              _infoTile(Icons.web, c.website),
              const SizedBox(height: 20),
              const Text("Follow us on"),
              const SizedBox(height: 8),
              Row(
                children: const [
                  Icon(Icons.chat_bubble, color: Colors.green),
                  SizedBox(width: 10),
                  Icon(Icons.camera_alt, color: Colors.purple),
                  SizedBox(width: 10),
                  Icon(Icons.alternate_email, color: Colors.blue),
                  SizedBox(width: 10),
                  Icon(Icons.facebook, color: Colors.blueAccent),
                ],
              ),
              const Spacer(),
              ElevatedButton(
              
                onPressed: () => Get.to(() => EditContactPage()),
                child: const Text("Edit Contact"),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _infoTile(IconData icon, String text) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 10),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
