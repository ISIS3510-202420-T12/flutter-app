import 'package:flutter/material.dart';
import 'package:wearabouts/features/home/model/clothe.dart';

class ClothesCard extends StatefulWidget {
  final Clothe item;
  const ClothesCard({super.key, required this.item});

  @override
  State<ClothesCard> createState() => _ClothesCardState(item);
}

class _ClothesCardState extends State<ClothesCard> {
  Clothe item;

  _ClothesCardState(this.item);

  @override
  Widget build(BuildContext context) {
    return Text("HEyyy");
  }
}
