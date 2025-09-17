import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin_jantasewa/controllers/auth/authorized_user_controller.dart';

class CreateAuthorizedUserPage extends StatelessWidget {
  final AuthorizedUserController controller = Get.put(
    AuthorizedUserController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Authorized User")),
      body: Obx(
        () => Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ===== Stepper Indicator with Connecting Line =====
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) {
                  bool isActive = controller.currentStep.value >= index;
                  return Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Circle Indicator
                        CircleAvatar(
                          radius: 18,
                          backgroundColor: isActive
                              ? Colors.deepPurple
                              : Colors.grey.shade300,
                          child: Text(
                            "${index + 1}",
                            style: TextStyle(
                              color: isActive ? Colors.white : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        // Connecting line (except last)
                        if (index != 2)
                          Expanded(
                            child: Container(
                              height: 3,
                              color: controller.currentStep.value > index
                                  ? Colors.deepPurple
                                  : Colors.grey.shade300,
                              child: Text("Text"),
                            ),
                          ),
                      ],
                    ),
                  );
                }),
              ),
            ),

            // Step Titles
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _stepTitle("Personal\nDetails", 0),
                  _stepTitle("Location\nDetails", 1),
                  _stepTitle("Authorized\nLevel", 2),
                ],
              ),
            ),

            // ===== Step Content =====
            Expanded(
              child: IndexedStack(
                index: controller.currentStep.value,
                children: [_personalStep(), _locationStep(), _authorizedStep()],
              ),
            ),

            // ===== Navigation Buttons =====
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  if (controller.currentStep.value > 0)
                    Expanded(
                      child: OutlinedButton(
                        onPressed: controller.previousStep,
                        child: Text("Back"),
                      ),
                    ),
                  if (controller.currentStep.value > 0) SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                      ),
                      onPressed: () {
                        if (controller.currentStep.value < 2) {
                          controller.nextStep();
                        } else {
                          controller.submit();
                        }
                      },
                      child: Text(
                        controller.currentStep.value < 2 ? "Next" : "Submit",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // === Step Title Widget ===
  Widget _stepTitle(String title, int index) {
    final controller = Get.find<AuthorizedUserController>();
    return Text(
      title,
      style: TextStyle(
        fontSize: 12,
        fontWeight: controller.currentStep.value == index
            ? FontWeight.bold
            : FontWeight.normal,
        color: controller.currentStep.value == index
            ? Colors.deepPurple
            : Colors.grey,
      ),
    );
  }

  // === Step 1 - Personal ===
  Widget _personalStep() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          TextField(decoration: InputDecoration(labelText: "Name")),
          TextField(decoration: InputDecoration(labelText: "Mobile")),
          TextField(decoration: InputDecoration(labelText: "Email")),
          TextField(decoration: InputDecoration(labelText: "Gender")),
        ],
      ),
    );
  }

  // === Step 2 - Location ===
  Widget _locationStep() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          TextField(decoration: InputDecoration(labelText: "Address")),
          TextField(decoration: InputDecoration(labelText: "State")),
          TextField(decoration: InputDecoration(labelText: "District")),
          TextField(decoration: InputDecoration(labelText: "City / Village")),
          TextField(decoration: InputDecoration(labelText: "Block")),
          TextField(decoration: InputDecoration(labelText: "Ward Number")),
          TextField(decoration: InputDecoration(labelText: "Pin Code")),
        ],
      ),
    );
  }

  // === Step 3 - Authorized ===
  Widget _authorizedStep() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          TextField(decoration: InputDecoration(labelText: "Post")),
          TextField(decoration: InputDecoration(labelText: "Current Level")),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(labelText: "Type of Organisation"),
            items: ["MLA", "Pradhan", "Ward Member", "Gram Sachiv"]
                .map((type) => DropdownMenuItem(value: type, child: Text(type)))
                .toList(),
            onChanged: (value) {},
          ),
        ],
      ),
    );
  }
}
