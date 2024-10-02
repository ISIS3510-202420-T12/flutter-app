import 'package:flutter/material.dart';

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
            onPressed: () {}, icon: const Icon(Icons.leave_bags_at_home)),
        IconButton(onPressed: () {}, icon: const Icon(Icons.search))
      ],
      leading: Row(
        children: [
          IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(Icons.menu)),
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.notifications_none)),
        ],
      ),
    );
  }
}
