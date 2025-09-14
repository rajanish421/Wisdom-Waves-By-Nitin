import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:intl/intl.dart';
import 'package:wisdom_waves_by_nitin/comman/widgets/fullScreen_image.dart';

import '../../../../Model/discussion_model.dart';

class MessageTile extends StatelessWidget {
  final DiscussionMessage message;
  final bool isMe;
  // final AudioPlayer audioPlayer;

  const MessageTile({
    super.key,
    required this.message,
    required this.isMe,
    // required this.audioPlayer,
  });

  String _formatTimestamp(DateTime? dt) {
    if (dt == null) return '';
    final now = DateTime.now();
    if (dt.year == now.year && dt.month == now.month && dt.day == now.day) {
      return DateFormat.Hm().format(dt);
    } else {
      return DateFormat('dd MMM HH:mm').format(dt);
    }
  }

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.only(
      topLeft: const Radius.circular(12),
      topRight: const Radius.circular(12),
      bottomLeft: isMe ? const Radius.circular(12) : const Radius.circular(0),
      bottomRight: isMe ? const Radius.circular(0) : const Radius.circular(12),
    );

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.78),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            color: isMe ? Colors.deepPurple.shade100 : Colors.grey.shade200,
            borderRadius: radius,
          ),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          child: Column(
            crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              if (!isMe)
                Text(message.senderName,
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              if (message.text != null && message.text!.isNotEmpty)
                Text(message.text!, style: const TextStyle(fontSize: 15)),
              if (message.imageUrl != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: GestureDetector(
                    onTap: (){
                      // print("ji");
                      Navigator.push(context, MaterialPageRoute(builder: (context) => FullImage(imageUrl: message.imageUrl.toString()),));
                      },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        message.imageUrl!,
                        width: 200,
                        height: 140,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                        const Icon(Icons.broken_image, size: 40),
                      ),
                    ),
                  ),
                ),
              if (message.audioUrl != null)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // IconButton(
                    //   icon: const Icon(Icons.play_arrow),
                    //   onPressed: () async {
                    //     await audioPlayer.play(UrlSource(message.audioUrl!));
                    //   },
                    // ),
                    // Text(message.audioDuration != null
                    //     ? '${message.audioDuration}s'
                    //     : 'Audio'),
                  ],
                ),
              if (message.timestamp != null)
                Text(_formatTimestamp(message.timestamp),
                    style: const TextStyle(fontSize: 11, color: Colors.black54)),
            ],
          ),
        ),
      ),
    );
  }
}
