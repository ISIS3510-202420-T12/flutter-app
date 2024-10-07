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
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        icon,
        const SizedBox(
          width: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              statname,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(stat)
          ],
        )
      ],
    );
  }
}
