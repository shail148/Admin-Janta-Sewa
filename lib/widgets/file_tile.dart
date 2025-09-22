import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:admin_jantasewa/constants/colors.dart';
import 'package:admin_jantasewa/controllers/media_upload_controller.dart';

class FileTile extends StatelessWidget {
  final PickedFile file;
  final VoidCallback onRemove;
  const FileTile({super.key, required this.file, required this.onRemove});

  /// Convert file size into KB/MB readable string
  String _readableSize(int bytes) {
    if (bytes <= 0) return '0 B';
    const units = ['B', 'KB', 'MB', 'GB'];
    final i = (math.log(bytes) / math.log(1024)).floor().clamp(
      0,
      units.length - 1,
    );
    final size = (bytes / math.pow(1024, i)).toStringAsFixed(2);
    return '$size ${units[i]}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.primary),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.insert_drive_file_outlined,
            color: AppColors.primary,
          ),
          const SizedBox(width: 10),

          /// File name
          Expanded(
            child: Text(
              file.name,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 13, color: AppColors.primary),
            ),
          ),

          /// File size
          Text(
            _readableSize(file.size),
            style: TextStyle(fontSize: 12, color: AppColors.primary),
          ),
          const SizedBox(width: 8),

          /// Delete button
          IconButton(
            tooltip: "Remove",
            icon: const Icon(
              Icons.close_rounded,
              size: 18,
              color: AppColors.primary,
            ),
            onPressed: onRemove,
          ),
        ],
      ),
    );
  }
}
