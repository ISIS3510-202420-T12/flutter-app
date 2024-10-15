import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wearabouts/features/home/view/widgets/appBar.dart';
import 'package:wearabouts/features/home/view/widgets/categoryTab.dart';
import 'package:wearabouts/features/home/view/widgets/clothesCard.dart';
import 'package:wearabouts/features/home/viewmodel/marketPlaceViewModel.dart';

import '../../../../core/theme/app_pallete.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int mycurrentIndex = 0;

  @override
  void initState() {
    super.initState();

    // Inicializa el ViewModel y llena la lista de items
    Future.microtask(() {
      Provider.of<MarketPlaceViewModel>(context, listen: false).populate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                gradient:
                    LinearGradient(colors: [Pallete.color3, Pallete.color2]),
              ),
              child: const SizedBox(height: 10, width: double.infinity),
            ),
            const SizedBox(height: 10),
            const Center(
              child: Text("Marketplace",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CategoryTab(
                    name: "Shoes",
                    assetName: "assets/images/shoes.svg",
                  ),
                  CategoryTab(
                    name: "Bottoms",
                    assetName: "assets/images/bottoms.svg",
                  ),
                  CategoryTab(
                    name: "Tops",
                    assetName: "assets/images/tops.svg",
                  ),
                  CategoryTab(
                    name: "Jackets",
                    assetName: "assets/images/jackets.svg",
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                height: 300,
                width: 1000,
                color: Colors.grey,
                child: Image.network(
                  "https://www.fashiongonerogue.com/wp-content/uploads/2021/04/Model-Chic-Fashion.jpg",
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text("New releases"), Text("See all")],
              ),
            ),
            const Divider(color: Colors.black),
            Consumer<MarketPlaceViewModel>(
              builder: (context, viewMoodel, child) {
                return Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: viewMoodel.items.map((clothe) {
                    return ClothesCard(
                        item: clothe); // Tu widget para cada elemento
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
