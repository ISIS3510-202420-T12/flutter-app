import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wearabouts/features/home/view/widgets/contextAppBar.dart';
import 'package:wearabouts/features/notifications/view/widgets/notificationCard.dart';
import 'package:wearabouts/features/notifications/viewModel/notificationsViewModel.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  void initState() {
    super.initState();
    // Cargar notificaciones cuando se construye la página
    Provider.of<NotificationsViewModel>(context, listen: false)
        .loadNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ContextAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              children: [
                const Text(
                  "Notifications",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Consumer<NotificationsViewModel>(
                  builder: (context, viewModel, child) {
                    return Column(
                      children: viewModel.notifications.map((noti) {
                        return NotificationCard(
                          message: noti,
                        ); // Tu widget para cada elemento
                      }).toList(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
