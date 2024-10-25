import 'package:flutter/material.dart';
import 'package:wearabouts/core/theme/app_pallete.dart';

class FeaturedCard extends StatelessWidget {
  final String title;
  final String goal;
  final int percentage;
  final String imagePath;

  const FeaturedCard(
      {super.key,
      required this.title,
      required this.goal,
      required this.percentage,
      required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 4,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15)),
            child: Image.asset(imagePath,
                height: 150, width: double.infinity, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Pallete.color1),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(goal,
                        style: TextStyle(fontSize: 16, color: Pallete.color1)),
                    Text("$percentage%",
                        style: TextStyle(fontSize: 16, color: Pallete.color1)),
                  ],
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: percentage / 100,
                  backgroundColor: Pallete.backgroundColor2,
                  color: Pallete.color2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
