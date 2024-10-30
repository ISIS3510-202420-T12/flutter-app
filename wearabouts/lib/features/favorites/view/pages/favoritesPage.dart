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
  void initState() {
    super.initState();

    // Inicializa el ViewModel y llena la lista de items

    Future.microtask(() {
      Provider.of<FavoritesViewModel>(context, listen: false).populate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          children: [
            Text("Favorites",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 10,
            ),
            Consumer<FavoritesViewModel>(
              builder: (context, viewMoodel, child) {
                return Column(
                  children: viewMoodel.items.map((clothe) {
                    return FavoritesCard(
                        item: clothe); // Tu widget para cada elemento
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    ));
  }
}
