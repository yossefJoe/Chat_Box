import 'package:flutter/material.dart';
import 'package:zoom_clone/core/resources/navigation.dart';
import 'package:zoom_clone/core/resources/styles_manager.dart';
import 'package:zoom_clone/features/Chat/presentation/views/widgets/bottomsheet_children.dart';

void showAttachmentBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true, // important for taller sheets
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
    ),
    builder: (context) {
      return SizedBox(
        height:
            MediaQuery.of(context).size.height * 0.7, // 70% of screen height
        child: const AttachmentBottomsheet(),
      );
    },
  );
}

class AttachmentBottomsheet extends StatelessWidget {
  const AttachmentBottomsheet({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize:
              MainAxisSize.min, // content controls height inside container
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.close, size: 20),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                const SizedBox(width: 90),
                const Text(
                  "Share Content",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            const BottomsheetChildren(),
            // You can add Spacer() here to push content up if needed
          ],
        ),
      ),
    );
  }
}
