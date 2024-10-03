import 'package:flutter/material.dart';

class StatisticsRow extends StatelessWidget {
  Icon icon;
  final String statname;
  final String stat;
  StatisticsRow(
      {super.key,
      required this.icon,
      required this.statname,
      required this.stat});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          Icons.lock_clock,
          size: 40,
        ),
        SizedBox(
          width: 20,
        ),
        Column(
          children: [
            Text(
              "Delivery Time",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text("4.8 minutes")
          ],
        )
      ],
    );
  }
}
