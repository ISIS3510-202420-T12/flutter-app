import 'package:flutter/material.dart';
import 'package:wearabouts/core/theme/app_pallete.dart';

class DiscoverNowButton extends StatelessWidget {
  final VoidCallback onTap;

  const DiscoverNowButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Pallete.color3, Pallete.color2]),
          borderRadius: BorderRadius.circular(10)),
      child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
              fixedSize: const Size(350, 70),
              backgroundColor: Pallete.transparentColor,
              shadowColor: Pallete.transparentColor),
          child: const Text(
            "Discover now",
            style: TextStyle(fontSize: 24, color: Colors.white),
          )),
    );
  }
}
