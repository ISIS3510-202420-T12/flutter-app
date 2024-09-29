import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoryTab extends StatelessWidget {
  final String name;
  final String assetName;
  const CategoryTab({super.key, required this.name, required this.assetName});

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(assetName, height: 45),
            ),
            Text(name,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w300))
          ],
        ));
  }
}
