import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../Model/discussion_model.dart';

class DiscussionRepository {
  final _col = FirebaseFirestore.instance.collection('discussion');

  Stream<List<DiscussionMessage>> messagesStream({int limit = 500}) {
    return _col
        .orderBy('timestamp', descending: false)
        .limit(limit)
        .snapshots()
        .map((snap) =>
        snap.docs.map((d) => DiscussionMessage.fromFirestore(d)).toList());
  }

  Future<void> sendMessage(DiscussionMessage message) async {
    await _col.add(message.toFirestoreMap());
  }
}
