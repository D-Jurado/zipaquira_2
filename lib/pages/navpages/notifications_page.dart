import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zipaquira_2/presentation/blocs/notifications/notifications_bloc.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: context
              .select((NotificationsBloc bloc) => Text('${ bloc.state.status }')),
          actions: [
            IconButton(
                onPressed: () {
                  context.read<NotificationsBloc>().requestPermission();
                },
                icon: const Icon(Icons.notifications_on))
          ]),
      body: _NotificationView(),
    );
  }
}

class _NotificationView extends StatelessWidget {
  const _NotificationView();

  

  @override
  Widget build(BuildContext context) {
    final notifications =
        context.watch<NotificationsBloc>().state.notifications;
    return ListView.builder(
      itemCount: notifications.length,
      itemBuilder: (BuildContext context, int index) {
        final notification = notifications[index];
        return ListTile(
          title: Text(notification.title),
          subtitle: Text(notification.body),
          leading: notification.imageUrl !=null
          ? Image.network(notification.imageUrl!)
          : null,
          onTap: () {
            
          },
        );

      },
    );
  }
}
