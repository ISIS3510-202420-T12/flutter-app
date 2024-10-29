import 'package:flutter/material.dart';
import 'package:wearabouts/features/home/view/widgets/contextAppBar.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        appBar: ContextAppBar(),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Text("Notifications"),
            SizedBox(
              height: 10,
            ),
          ],
        )));
  }
}
