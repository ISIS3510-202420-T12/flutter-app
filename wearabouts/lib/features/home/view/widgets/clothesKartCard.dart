import 'package:flutter/material.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:wearabouts/core/repositories/model/clothe.dart';

class ClothesKartCard extends StatefulWidget {
  final Clothe item;
  const ClothesKartCard({super.key, required this.item});

  @override
  State<ClothesKartCard> createState() => _ClothesKartCardState(item);
}

class _ClothesKartCardState extends State<ClothesKartCard> {
  final Clothe item;

  _ClothesKartCardState(this.item);

  @override
  Widget build(BuildContext context) {
    MoneyFormatter formatedPrice = MoneyFormatter(
        amount: item.price.toDouble(),
        settings: MoneyFormatterSettings(fractionDigits: 0));

    return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 60,
                  width: 80,
                  child: Image.network(
                    item.imagesURLs[0],
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              Text(item.title),
            ],
          ),
          Row(
            children: [
              Text(formatedPrice.output.compactSymbolOnRight),
              const SizedBox(width: 20)
            ],
          ),
        ]);
  }
}
