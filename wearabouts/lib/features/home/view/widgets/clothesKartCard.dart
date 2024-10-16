import 'package:flutter/material.dart';
import 'package:wearabouts/features/home/model/clothe.dart';

class ClothesKartCard extends StatefulWidget {
  final Clothe item;
  const ClothesKartCard({super.key, required this.item});

  @override
  State<ClothesKartCard> createState() => _ClothesKartCardState();
}

class _ClothesKartCardState extends State<ClothesKartCard> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
