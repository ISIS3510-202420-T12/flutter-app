import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wearabouts/core/repositories/model/clothe.dart';
import 'package:wearabouts/features/favorites/viewModel/favoritesViewModel.dart';

class AddToFavoritesButton extends StatelessWidget {
  final Clothe
      clothe; // El ítem de ropa al que se le puede agregar/eliminar favoritos

  AddToFavoritesButton({required this.clothe});

  @override
  Widget build(BuildContext context) {
    final favoritesViewModel = Provider.of<FavoritesViewModel>(context);
    bool isFavorite = favoritesViewModel.isFavorite(clothe.id);

    return IconButton(
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: isFavorite ? Colors.red : Colors.grey,
      ),
      onPressed: () {
        if (isFavorite) {
          favoritesViewModel.deleteFromFavorites(clothe.id);
        } else {
          favoritesViewModel.addFavorite(clothe);
        }
      },
      tooltip: isFavorite ? 'Remove from favorites' : 'Add to favorites',
    );
  }
}
