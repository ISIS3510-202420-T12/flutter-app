import 'package:flutter/material.dart';
import 'package:wearabouts/features/home/model/clothe.dart';

class FavoritesCard extends StatefulWidget {
  final Clothe item;
  const FavoritesCard({super.key, required this.item});

  @override
  State<FavoritesCard> createState() => _FavoritesCardState(item);
}

class _FavoritesCardState extends State<FavoritesCard> {
  Clothe item;

  _FavoritesCardState(this.item);

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: SizedBox.square(dimension: 80),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Este es un ejemplo de tarjeta",
                    style: TextStyle(fontWeight: FontWeight.w600)),
                Text("Este es un precio")
              ],
            )
          ],
        ),
      ),
    );
  }
}
