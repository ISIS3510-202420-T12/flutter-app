import 'package:flutter/material.dart';
import 'package:wearabouts/core/theme/app_pallete.dart';

class DonationStatisticsCard extends StatelessWidget {
  const DonationStatisticsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Pallete.color2,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: "UserName",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Pallete.fontColor1),
                ),
                TextSpan(
                  text: ", you have ",
                  style: TextStyle(fontSize: 15, color: Pallete.fontColor1),
                ),
                TextSpan(
                  text: "donated ",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Pallete.fontColor1),
                ),
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFFDE8),
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      "56",
                      style: TextStyle(
                          color: Pallete.color1,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                TextSpan(
                  text: " clothes.",
                  style: TextStyle(fontSize: 15, color: Pallete.fontColor1),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: "And you've ",
                  style: TextStyle(fontSize: 15, color: Pallete.fontColor1),
                ),
                TextSpan(
                  text: "helped ",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Pallete.fontColor1),
                ),
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFFDE8),
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      "120",
                      style: TextStyle(
                          color: Pallete.color1,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                TextSpan(
                  text: " people.",
                  style: TextStyle(fontSize: 15, color: Pallete.fontColor1),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
