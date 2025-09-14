import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../Model/announcement_model.dart';
import '../services/announcement_service.dart';

class AnnouncementDetailsScreen extends StatelessWidget {
  final String id;
  final service = AnnouncementService();

  AnnouncementDetailsScreen({required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Announcement Details")),
      body: FutureBuilder<Announcement?>(
        future: service.getAnnouncementById(id),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

          final ann = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(ann.title,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Text(ann.message, style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 20),
                if (ann.imageUrl != null)
                  SizedBox(
                      width: double.infinity,
                      child: Image.network(ann.imageUrl!, height: 200, fit: BoxFit.cover,alignment: Alignment.center,)),
                const SizedBox(height: 20),
                Text(
                  DateFormat("dd MMM yyyy\nhh:mm a").format(ann.createdAt),
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
