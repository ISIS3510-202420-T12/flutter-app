import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:wearabouts/core/repositories/model/clothe.dart';
import 'package:wearabouts/features/home/view/pages/clotheDetailPage.dart';

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
    MoneyFormatter formatedRating = MoneyFormatter(
        amount: item.rating.toDouble(),
        settings: MoneyFormatterSettings(fractionDigits: 1));
    MoneyFormatter formatedPrice = MoneyFormatter(
        amount: item.price.toDouble(),
        settings: MoneyFormatterSettings(fractionDigits: 0));

    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ClotheDetailPage(item: item)));
      },
      child: Card(
          elevation: 5.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: SizedBox(
            width: 200,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    color: Colors.grey,
                    child: SizedBox(
                      height: 120,
                      width: 180,
                      child: CachedNetworkImage(
                        imageUrl: item.imagesURLs[0],
                        placeholder: (context, url) => Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) => Image.asset(
                          'assets/images/placeholder.png',
                          fit: BoxFit.fitHeight,
                        ),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    item.title,
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        formatedPrice.output.symbolOnRight,
                        style: const TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.orange,
                          ),
                          Text(formatedRating.output.nonSymbol),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }
}
