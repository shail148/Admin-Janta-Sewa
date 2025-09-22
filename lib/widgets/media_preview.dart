import 'package:flutter/material.dart';
import '../models/media_item.dart';

class MediaPreviewPage extends StatelessWidget {
  final MediaItem item;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const MediaPreviewPage({
    super.key,
    required this.item,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Janta Sewa")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(item.imageUrl,
                  width: double.infinity, height: 200, fit: BoxFit.cover),
            ),
            const SizedBox(height: 16),
            Text(item.title,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(item.description ?? "No description",
                style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 8),
            Text("Date: ${item.date.toLocal()}".split(' ')[0],
                style: const TextStyle(color: Colors.grey)),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: onDelete,
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: const Text("Delete"),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: onEdit,
                    child: const Text("Edit"),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
