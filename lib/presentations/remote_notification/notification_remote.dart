import 'package:english_learner/presentations/global_instance/appbar.dart';
import 'package:english_learner/presentations/global_instance/bloc/global_bloc.dart';
import 'package:english_learner/presentations/remote_notification/widgets/notification_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationRemote extends StatefulWidget {
  const NotificationRemote({super.key});

  @override
  State<NotificationRemote> createState() => _NotificationRemoteState();
}

class _NotificationRemoteState extends State<NotificationRemote> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppbar(text: "Notifications"),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 6,
          vertical: 6,
        ),
        child: BlocBuilder<GlobalBloc, GlobalState>(
          builder: (context, state) {
            return ListView.builder(
              itemCount: state.notificationApps.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 6),
                  child: NotificationItems(
                    notificationApp: state.notificationApps[index],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
