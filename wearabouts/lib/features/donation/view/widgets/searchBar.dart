import 'package:flutter/material.dart';
import 'package:wearabouts/core/theme/app_pallete.dart';
import 'package:wearabouts/features/donation/view/pages/donationMapPage.dart';

class SearchBarWithMap extends StatelessWidget {
  const SearchBarWithMap({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: Pallete.color2,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: [
                const SizedBox(width: 8),
                Icon(Icons.search, color: Pallete.fontColor1),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search here for ONGs",
                      hintStyle: TextStyle(color: Pallete.fontColor1),
                      border: InputBorder.none,
                    ),
                    style: TextStyle(color: Pallete.fontColor1),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),
        Container(
          decoration: BoxDecoration(
            color: Pallete.color2,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const DonationMapPage()),
              );
            },
            icon: Icon(Icons.map, color: Pallete.fontColor1),
          ),
        ),
      ],
    );
  }
}
