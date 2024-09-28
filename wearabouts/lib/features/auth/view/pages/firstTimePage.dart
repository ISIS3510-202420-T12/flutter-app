import 'package:flutter/material.dart';
import 'package:wearabouts/features/auth/view/pages/authPage.dart';
import 'package:wearabouts/features/auth/view/widgets/discoverNowButton.dart';

class FirstTimePage extends StatefulWidget {
  const FirstTimePage({super.key});

  @override
  State<FirstTimePage> createState() => _FirstTimePageState();
}

class _FirstTimePageState extends State<FirstTimePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'lib/core/media/homebackground.jpeg'), // Your image file path
            fit: BoxFit.cover, // Ensures the image covers the entire background
          ),
        ),
        child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              const Text("Discover your image", style: TextStyle(fontSize: 40)),
              const SizedBox(height: 40),
              DiscoverNowButton(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Authpage()),
                  );
                },
              )
            ])),
      ),
    );
  }
}
