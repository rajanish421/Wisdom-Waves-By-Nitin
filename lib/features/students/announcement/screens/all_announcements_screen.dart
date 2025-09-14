import 'package:flutter/material.dart';
import '../../../../Model/announcement_model.dart';
import '../services/announcement_service.dart';
import 'announcement_details_screen.dart';
import 'create_announcement_screen.dart';
import 'package:intl/intl.dart';

class AllAnnouncementsScreen extends StatelessWidget {
  final service = AnnouncementService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("All Announcements")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (_) => CreateAnnouncementScreen()),
          // );
        },
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<List<Announcement>>(
        stream: service.getAnnouncements(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

          final announcements = snapshot.data!;
          if (announcements.isEmpty) {
            return const Center(child: Text("No announcements yet"));
          }

          return ListView.builder(
            itemCount: announcements.length,
            itemBuilder: (context, index) {
              final ann = announcements[index];
              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  title: Text(ann.title),
                  subtitle: Text(
                    ann.message,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: Text(DateFormat("dd MMM yyyy\nhh:mm a").format(ann.createdAt)),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AnnouncementDetailsScreen(id: ann.announcementId),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
