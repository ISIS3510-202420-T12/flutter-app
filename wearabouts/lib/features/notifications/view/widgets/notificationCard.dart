import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wearabouts/core/theme/app_pallete.dart';
import 'package:wearabouts/features/notifications/viewModel/notificationsViewModel.dart';

class NotificationCard extends StatelessWidget {
  final String message;
  const NotificationCard({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Pallete.color2,
      child: Container(
        height: 80,
        width: 395,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                message,
                style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              IconButton(
                icon: Icon(Icons.delete), // Ícono de eliminar
                color: Colors.white, // Color del ícono
                onPressed: () {
                  Provider.of<NotificationsViewModel>(context, listen: false)
                      .removeNotification(
                          message); // Llama a la función de eliminación
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
