import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wearabouts/core/repositories/model/clothe.dart';
import 'package:wearabouts/features/home/view/widgets/clothesCard.dart';
import 'package:wearabouts/features/home/viewmodel/marketPlaceViewModel.dart';


class MarketplaceSearchResultPage extends StatelessWidget {
  final String searchTerm;

  const MarketplaceSearchResultPage({Key? key, required this.searchTerm})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final marketPlaceViewModel = Provider.of<MarketPlaceViewModel>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      marketPlaceViewModel.filterItemsBySearchTerm(searchTerm);
    });

    return Scaffold(
      appBar: AppBar(
        title: Text("Results for: $searchTerm"),
      ),
      body: Builder(
        builder: (context) {
          final searchResults = marketPlaceViewModel.searchResults;

          if (searchResults.isEmpty) {
            return const Center(
              child: Text("No results found."),
            );
          }

          List<Widget> clothesCards = searchResults.map((result) {
            return ClothesCard(item: result);
          }).toList();

          return SingleChildScrollView(
            child: Column(
              children: [
                const Divider(color: Colors.black),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: clothesCards,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
