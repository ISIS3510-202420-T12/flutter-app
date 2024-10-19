import 'package:flutter/material.dart';

import '../../../../core/theme/app_pallete.dart';

class AddToKartButton extends StatelessWidget {
  final VoidCallback onTap;
  const AddToKartButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Pallete.color3, Pallete.color2]),
          borderRadius: BorderRadius.circular(10)),
      child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
              fixedSize: const Size(150, 50),
              backgroundColor: Pallete.transparentColor,
              shadowColor: Pallete.transparentColor),
          child: const Text(
            "Add to kart",
            style: TextStyle(fontSize: 20, color: Colors.white),
          )),
    );
    ;
  }
}
