import 'package:flutter/material.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:provider/provider.dart';
import 'package:wearabouts/core/repositories/model/clothe.dart';
import 'package:wearabouts/features/favorites/viewModel/favoritesViewModel.dart';

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
    MoneyFormatter formatedPrice = MoneyFormatter(
        amount: item.price.toDouble(),
        settings: MoneyFormatterSettings(fractionDigits: 0));
    return Card(
      child: Container(
        height: 140,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox.square(
                  dimension: 80,
                  child: Image.network(item.imagesURLs[0]),
                ),
              ),
              Container(
                width: 240,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.title,
                        style: const TextStyle(fontWeight: FontWeight.w600)),
                    Text(formatedPrice.output.compactSymbolOnRight),
                    Text(
                      item.description,
                      softWrap: true,
                      overflow: TextOverflow.clip,
                    )
                  ],
                ),
              ),
              Column(children: [
                IconButton(
                  icon: Icon(Icons.delete), // Ícono de eliminar
                  color: Colors.black, // Color del ícono
                  onPressed: () {
                    Provider.of<FavoritesViewModel>(context, listen: false)
                        .deleteFromFavorites(
                            item.id); // Llama a la función de eliminación
                  },
                ),
              ])
            ],
          ),
        ),
      ),
    );
  }
}
