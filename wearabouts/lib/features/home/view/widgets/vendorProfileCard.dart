import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wearabouts/features/home/view/widgets/statisticsRow.dart';

class VendorProfileCard extends StatefulWidget {
  const VendorProfileCard({super.key});

  @override
  State<VendorProfileCard> createState() => _VendorProfileCardState();
}

class _VendorProfileCardState extends State<VendorProfileCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 1,
                spreadRadius: 1)
          ]),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            const Row(
              children: [
                Icon(
                  Icons.circle_sharp,
                  size: 70,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Vendor's name"),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.orange),
                        Icon(Icons.star, color: Colors.orange),
                        Icon(Icons.star, color: Colors.orange),
                        Icon(Icons.star, color: Colors.orange),
                        Icon(Icons.star, color: Colors.orange),
                        SizedBox(
                          width: 10,
                        ),
                        Text("(47)")
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            StatisticsRow(
                icon: const Icon(Icons.lock_clock),
                statname: "Average answer time",
                stat: "4.9 minutes"),
            StatisticsRow(
                icon: const Icon(Icons.account_box),
                statname: "Average delivery time",
                stat: "3 days")
          ],
        ),
      ),
    );
  }
}
