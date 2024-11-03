import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wearabouts/features/home/view/pages/checkoutPage.dart';
import 'package:wearabouts/features/notifications/view/pages/notificationsPage.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({
    super.key,
  });

  @override
  Size get preferredSize => const Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("WearAbouts",
          style: TextStyle(fontWeight: FontWeight.bold)),
      backgroundColor: Colors.white,
      centerTitle: true,
      actions: <Widget>[
        IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CheckoutPage()),
              );
            },
            icon: const FaIcon(FontAwesomeIcons.shoppingBag)),
        IconButton(onPressed: () {}, icon: const Icon(Icons.search))
      ],
      leadingWidth: 120,
      leading: Row(
        children: [
          IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(Icons.menu)),
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const NotificationsPage()),
                );
              },
              icon: const Icon(Icons.notifications_none)),
        ],
      ),
    );
  }
}
