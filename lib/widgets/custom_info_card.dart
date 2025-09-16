// ignore_for_file: deprecated_member_use

import 'package:admin_jantasewa/widgets/colors.dart';
import 'package:flutter/material.dart';

class InfoRowData {
  final IconData icon;
  final String text;
  InfoRowData({required this.icon, required this.text});
}

class CustomInfoCard extends StatelessWidget {
  final String title; // e.g. TKT0002
  final List<InfoRowData> rows; // e.g. ID, Date, Route, Train
  final String description; // reason
  final String status; // Approved/Pending/Rejected
  final Color statusColor;
  final String buttonText;
  final VoidCallback onButtonTap;

  const CustomInfoCard({
    super.key,
    required this.title,
    required this.rows,
    required this.description,
    required this.status,
    required this.statusColor,
    this.buttonText = 'View',
    required this.onButtonTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      //margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 0,
      color: Color(0xFFDDDBE6).withAlpha(76),
      borderOnForeground: true,
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 1, color: Color(0xFF403572).withOpacity(0.2)),
        borderRadius: BorderRadius.circular(16),
      ),

      child: Padding(
        padding: const EdgeInsets.only(top: 0, left: 5, right: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // pill title
            Card(
              elevation: 0,
              margin: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 1,
                  color: Color(0xFF403572).withOpacity(0.2),
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(top: 5, left: 12, bottom: 8),
                child: Column(
                  spacing: 0,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xffF6F8FA),

                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        title,
                        style: TextStyle(
                          color: AppColors.primary,

                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),

                    ...rows.map(
                      (r) => Padding(
                        padding: const EdgeInsets.only(bottom: 8, right: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Icon always top-left
                            Icon(r.icon, size: 20, color: Colors.black),
                            const SizedBox(width: 8),
                            // Text right-aligned, wraps below if long
                            Expanded(
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  r.text,
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    //   Row(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: const [
                    //       Icon(
                    //         Icons.chat_bubble_outline,
                    //         size: 20,
                    //         color: Colors.black,
                    //       ),
                    //       SizedBox(width: 8),
                    //     ],
                    //   ),
                    //   Padding(
                    //     padding: const EdgeInsets.only(
                    //       left: 26,
                    //       top: 4,
                    //       bottom: 10,
                    //     ),
                    //     child: Text(
                    //       description,
                    //       style: const TextStyle(fontSize: 12),
                    //     ),
                    //   ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
              child: Row(
                children: [
                  const Icon(Icons.access_time, size: 20),
                  const SizedBox(width: 8),
                  const Text('Status :', style: TextStyle(fontSize: 12)),
                  const SizedBox(width: 6),
                  Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height * 0.035,

                    width: MediaQuery.of(context).size.width * 0.20,
                    padding: const EdgeInsets.only(
                      left: 6,
                      right: 6,
                      top: 4,
                      bottom: 4,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      status,
                      style: TextStyle(
                        color: statusColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: onButtonTap,
                    child: Container(
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height * 0.038,

                      padding: const EdgeInsets.only(
                        left: 8,
                        right: 8,
                        top: 4,
                        bottom: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            buttonText,
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          Icon(
                            Icons.arrow_forward_ios_outlined,
                            size: 14,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // TextButton.icon(
                  //   onPressed: onButtonTap,
                  //   style: TextButton.styleFrom(
                  //     backgroundColor: const Color(0xFF5D5FEF),
                  //     foregroundColor: Colors.white,
                  //     padding: const EdgeInsets.symmetric(
                  //       horizontal: 10,
                  //       vertical: 6,
                  //     ),
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(8),
                  //     ),
                  //   ),
                  //   icon: const Icon(Icons.visibility, size: 16),
                  //   label: Text(buttonText),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
