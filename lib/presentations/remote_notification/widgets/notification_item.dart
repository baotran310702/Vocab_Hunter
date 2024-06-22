import 'package:english_learner/models/notification.dart';
import 'package:english_learner/presentations/remote_notification/views/detail_notification.dart';
import 'package:english_learner/utils/converter.dart';
import 'package:flutter/material.dart';

class NotificationItems extends StatefulWidget {
  final NotificationApp notificationApp;
  const NotificationItems({
    super.key,
    required this.notificationApp,
  });

  @override
  State<NotificationItems> createState() => _NotificationItemsState();
}

class _NotificationItemsState extends State<NotificationItems> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailNotificaitons(
              notificationApp: widget.notificationApp,
            ),
          ),
        );
      },
      //border color
      shape: const RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.grey,
          width: 0.5,
          //radius
        ),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      title: Text(
        widget.notificationApp.title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      subtitle: Row(
        children: [
          Text(
            CustomConverter.convertTimeToString(widget.notificationApp.time),
          ),
          const Text(" - "),
          Text(widget.notificationApp.body),
        ],
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
    );
  }
}
