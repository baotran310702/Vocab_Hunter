import 'package:english_learner/models/notification.dart';
import 'package:english_learner/presentations/global_instance/appbar.dart';
import 'package:english_learner/utils/converter.dart';
import 'package:english_learner/utils/icons.dart';
import 'package:flutter/material.dart';

class DetailNotificaitons extends StatefulWidget {
  final NotificationApp notificationApp;
  const DetailNotificaitons({super.key, required this.notificationApp});

  @override
  State<DetailNotificaitons> createState() => _DetailNotificaitonsState();
}

class _DetailNotificaitonsState extends State<DetailNotificaitons> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar(text: widget.notificationApp.title),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width,
          height: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.notificationApp.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Text(
                    CustomConverter.convertTimeToString(
                      widget.notificationApp.time,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Image.asset(
                AppIcons.capyNoti,
                width: 200,
                height: 200,
              ),
              const SizedBox(height: 12),
              Text(
                widget.notificationApp.body,
                style: const TextStyle(
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.start,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
