import 'package:admin_jantasewa/widgets/custom_text.dart';
import 'package:flutter/material.dart';
class ServiceCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  const ServiceCard({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: const Color(0xFF356CC5)),
          color:  Color(0xFF356CC5)
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            //border: Border.all(color: const Color(0xFF356CC5)),
            // ignore: deprecated_member_use
            color: Colors.white,
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF356CC5),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Icon(icon, color: Colors.white, size: 24),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: CustomTextWidget(text: title, color: Colors.black, fontsize: 14),
                ),         
              const Icon(Icons.arrow_forward_ios, size: 16,color:Color(0xFF356CC5)),
            ],
          ),
                      ),
        ),
      ),
    );
  }
}
