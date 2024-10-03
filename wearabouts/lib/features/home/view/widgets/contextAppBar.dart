import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContextAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ContextAppBar({
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
            onPressed: () {}, icon: const FaIcon(FontAwesomeIcons.shoppingBag)),
        IconButton(onPressed: () {}, icon: const Icon(Icons.search))
      ],
      leading: Row(
        children: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const FaIcon(FontAwesomeIcons.arrowLeft)),
        ],
      ),
    );
  }
}
