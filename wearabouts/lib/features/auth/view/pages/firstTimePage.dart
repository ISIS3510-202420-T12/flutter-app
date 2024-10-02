import 'package:flutter/material.dart';
import 'package:wearabouts/core/theme/app_pallete.dart';
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
      body: Stack(
        children: [
          const SizedBox(
            width: double.maxFinite,
            height: double.maxFinite,
            child: DecoratedBox(
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        'Assets/homebackground.jpeg'), // Your image file path
                    fit: BoxFit
                        .cover, // Ensures the image covers the entire background
                  ),
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent, // Starting color
                      Colors.black, // Ending color
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent, // Start color
                  Colors.black.withOpacity(0.7), // End color
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                  const Text("Discover your image",
                      style: TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 40),
                  DiscoverNowButton(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Authpage()),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 100,
                  )
                ])),
          ),
        ],
      ),
    );
  }
}
