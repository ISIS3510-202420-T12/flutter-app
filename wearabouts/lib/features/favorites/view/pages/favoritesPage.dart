import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wearabouts/features/favorites/view/widgets/favoritesCard.dart';
import 'package:wearabouts/features/favorites/viewModel/favoritesViewModel.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
      padding: EdgeInsets.all(8.0),
      child: Consumer<FavoritesViewModel>(
        builder: (context, viewMoodel, child) {
          return Column(
            children: viewMoodel.items.map((clothe) {
              return FavoritesCard(
                  item: clothe); // Tu widget para cada elemento
            }).toList(),
          );
        },
      ),
    ));
  }
}
