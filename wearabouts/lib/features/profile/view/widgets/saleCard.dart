import 'package:flutter/material.dart';
import 'package:wearabouts/core/repositories/model/clothe.dart';
import 'package:wearabouts/core/repositories/model/sales.dart';

class SaleCard extends StatelessWidget {
  final Sales sale; // Se define el objeto Sale como propiedad
  final Clothe item;
  const SaleCard(
      {Key? key,
      required this.sale,
      required this.item // El constructor ahora requiere un objeto Sale
      })
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    sale.item.get();
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox.square(
            dimension: 100,
            child: Image.network(
              item.imagesURLs[0],
              errorBuilder:
                  (BuildContext context, Object error, StackTrace? stackTrace) {
                return Icon(
                  Icons.broken_image,
                  color: Colors.grey,
                  size: 120,
                ); // Reemplazar con un ícono o widget personalizado
              },
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item.title,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      sale.date.year.toString() +
                          "/" +
                          sale.date.month.toString() +
                          "/" +
                          sale.date.day.toString(),
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ],
                ),
                Text(
                  "" + item.price.toString() + " \$",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w300),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
