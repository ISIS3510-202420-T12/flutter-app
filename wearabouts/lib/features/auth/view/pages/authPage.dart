import 'package:flutter/material.dart';
import 'package:wearabouts/features/home/view/pages/homePage.dart';

import '../../../../core/theme/app_pallete.dart';

class Authpage extends StatelessWidget {
  const Authpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("This will be the auth page",
            style: TextStyle(fontSize: 50)),
        ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            },
            style: ElevatedButton.styleFrom(
                fixedSize: const Size(350, 70),
                backgroundColor: Pallete.color2,
                shadowColor: Pallete.transparentColor),
            child: const Text(
              "Home page button",
              style: TextStyle(fontSize: 24, color: Colors.white),
            ))
      ],
    ));
  }
}
