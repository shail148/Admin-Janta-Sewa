import 'package:get/get.dart';

/// Contact model
class Contact {
  String email;
  String telephone;
  String mobile;
  String website;
  List<String> socialLinks;

  Contact({
    required this.email,
    required this.telephone,
    required this.mobile,
    required this.website,
    required this.socialLinks,
  });
}

/// Contact Controller with GetX
class ContactController extends GetxController {
  var contact = Contact(
    email: "kasperinfotech@gmail.com",
    telephone: "123-456-7890",
    mobile: "+91-9568965352",
    website: "https://kasperinfotech.com",
    socialLinks: [
      "https://wa.me/1234567890",
      "https://instagram.com/example",
      "https://twitter.com/example",
      "https://facebook.com/example",
    ],
  ).obs;

  void updateContact(Contact updatedContact) {
    contact.value = updatedContact;
  }
}
