import 'package:flutter/material.dart';

class BottomSheetOption {
  final String label;
  final VoidCallback onTap;
  BottomSheetOption(this.label, this.onTap);
}

void openOptionsSheet(
  BuildContext context,
  String title,
  List<BottomSheetOption> items,
) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (_) => SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 8),
          Container(
            width: 36,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Text(title, style: const TextStyle(color: Colors.black)),
              ],
            ),
          ),
          const Divider(height: 1),
          ...items.map(
            (e) => ListTile(
              title: Text(
                e.label,
                style: TextStyle(color: Colors.black, fontSize: 12),
              ),
              onTap: () {
                Navigator.pop(context);
                e.onTap();
              },
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    ),
  );
}
