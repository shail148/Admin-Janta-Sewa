import 'package:admin_jantasewa/widgets/colors.dart';
import 'package:admin_jantasewa/widgets/custom_app_bar.dart';
import 'package:admin_jantasewa/widgets/custom_text.dart';
import 'package:admin_jantasewa/widgets/file_upload.dart';
import 'package:admin_jantasewa/widgets/label_text.dart';
import 'package:admin_jantasewa/widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/ourJourney/our_journey_controller.dart';
import '../../models/ourJourney/our_journey_model.dart';

class CreateOurjourneyPage extends StatefulWidget {
  /// When adding:  isEdit=false, journey=null, editIndex=null
  /// When editing: isEdit=true,  journey=<item>, editIndex=<index>
  const CreateOurjourneyPage({
    super.key,
    this.journey,
    required this.isEdit,
    this.editIndex,
  });

  final OurJourneyModel? journey;
  final bool isEdit;
  final int? editIndex;

  @override
  State<CreateOurjourneyPage> createState() => _CreateOurjourneyPageState();
}

class _CreateOurjourneyPageState extends State<CreateOurjourneyPage> {
  final OurJourneyController controller = Get.find<OurJourneyController>();

  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController partyController = TextEditingController();
  final TextEditingController quoteController = TextEditingController();
  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();
  final TextEditingController imagePathController = TextEditingController();
  final TextEditingController filePathController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Prefill when editing
    final j = widget.journey;
    if (j != null) {
      nameController.text = j.name;
      titleController.text = j.title;
      partyController.text = j.partyName;
      quoteController.text = j.quote;
      fromController.text = j.fromYear.toString();
      toController.text = j.toYear.toString();
      imagePathController.text = j.imagePath;
      filePathController.text = j.filePath ?? '';
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    titleController.dispose();
    partyController.dispose();
    quoteController.dispose();
    fromController.dispose();
    toController.dispose();
    imagePathController.dispose();
    filePathController.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    final from = int.tryParse(fromController.text.trim());
    final to = int.tryParse(toController.text.trim());

    if (from == null || to == null) {
      Get.snackbar('Invalid years', 'Please enter valid numeric years.',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    if (from > to) {
      Get.snackbar('Invalid years', 'From year must be less than or equal to To year.',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    final model = OurJourneyModel(
      name: nameController.text.trim(),
      title: titleController.text.trim(),
      partyName: partyController.text.trim(),
      quote: quoteController.text.trim(),
      fromYear: from,
      toYear: to,
      imagePath: imagePathController.text.trim(),
      filePath: filePathController.text.trim().isEmpty ? null : filePathController.text.trim(),
    );

    if (widget.isEdit) {
      // Prefer the provided index; if null, try to locate the item
      final idx = widget.editIndex ??
          controller.journeyList.indexWhere((e) => identical(e, widget.journey));

      if (idx < 0 || idx >= controller.journeyList.length) {
        Get.snackbar('Error', 'Could not find the entry to update.',
            snackPosition: SnackPosition.BOTTOM);
        return;
      }
      controller.editJourney(idx, model);
      Get.back();
      Get.snackbar('Updated', 'Journey updated successfully.',
          snackPosition: SnackPosition.BOTTOM);
    } else {
      controller.addJourney(model);
      Get.back();
      Get.snackbar('Added', 'Journey added successfully.',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomTopAppBar(
        title: widget.isEdit ? 'Edit Journey' : 'Create Journey',
        leftIcon: Icon(Icons.arrow_back_ios, color: AppColors.primary),
        onLeftTap: () => Get.back(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextWidget(
                  text: widget.isEdit ? 'Edit Our Journey' : 'Create Our Journey',
                  fontWeight: FontWeight.bold,
                  fontsize: 16,
                ),
                const SizedBox(height: 8),

                // Name
                const CustomLabelText(text: 'Name'),
                CustomTextFormField(
                  controller: nameController,
                  hintText: 'Enter Name',
                  validator: (v) => v == null || v.trim().isEmpty ? 'Enter name' : null,
                ),
                const SizedBox(height: 8),

                // Title
                const CustomLabelText(text: 'Title'),
                CustomTextFormField(
                  controller: titleController,
                  hintText: 'Enter Title',
                  validator: (v) => v == null || v.trim().isEmpty ? 'Enter title' : null,
                ),
                const SizedBox(height: 8),

                // Party
                const CustomLabelText(text: 'Party Name'),
                CustomTextFormField(
                  controller: partyController,
                  hintText: 'Enter party name',
                  validator: (v) => v == null || v.trim().isEmpty ? 'Enter party name' : null,
                ),
                const SizedBox(height: 8),

                // Quote
                const CustomLabelText(text: 'Message / Quote'),
                CustomTextFormField(
                  controller: quoteController,
                  minLines: 4,
                  maxLines: 5,
                  hintText: 'Enter Message',
                ),
                const SizedBox(height: 8),

                // Years
                Row(
                  children: [
                    Expanded(
                      child: CustomTextFormField(
                        controller: fromController,
                        hintText: "From (Year)",
                        keyboardType: TextInputType.number,
                        validator: (v) =>
                            v == null || v.trim().isEmpty ? 'Enter year' : null,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: CustomTextFormField(
                        controller: toController,
                        hintText: 'To (Year)',
                        keyboardType: TextInputType.number,
                        validator: (v) =>
                            v == null || v.trim().isEmpty ? 'Enter year' : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Image + File inputs
                const CustomLabelText(text: 'Image Path (asset or URL)'),
                CustomTextFormField(
                  controller: imagePathController,
                  hintText: 'e.g. assets/images/pic.png or https://...',
                ),
                const SizedBox(height: 8),

                const CustomLabelText(text: 'File URL (optional)'),
                CustomTextFormField(
                  controller: filePathController,
                  hintText: 'e.g. https://example.com/file.pdf',
                ),

                const SizedBox(height: 12),
                // Keep your upload widget (optional UI). If it exposes a callback,
                // wire it to set imagePathController.text / filePathController.text.
                const CustomLabelText(text: 'Upload Image/File (optional)'),
                const SizedBox(height: 8),
                 CustomFileUpload(),
                // Example (if your CustomFileUpload supports callbacks):
                // CustomFileUpload(
                //   onImageSelected: (path) => imagePathController.text = path,
                //   onFileSelected:  (path) => filePathController.text  = path,
                // ),

                const SizedBox(height: 24),

                // Actions
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.grey.shade400),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 10,
                        ),
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cancel', style: TextStyle(color: Colors.black)),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 10,
                        ),
                      ),
                      onPressed: _save,
                      child: Text(
                        widget.isEdit ? 'Save' : 'Create',
                        style: const TextStyle(color: Colors.white),
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
