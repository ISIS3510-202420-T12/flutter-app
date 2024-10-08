import 'package:flutter/material.dart';
import 'package:wearabouts/core/theme/app_pallete.dart';
import 'package:wearabouts/features/home/model/clothe.dart';
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
                    color: Pallete.color2,
                    child: Image.network(item.imagesURLs[0],
                        height: 120, width: 180, fit: BoxFit.fitHeight),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    item.title,
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 50),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        "10000 ",
                        style: TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.orange,
                          ),
                          Text("4,9"),
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
