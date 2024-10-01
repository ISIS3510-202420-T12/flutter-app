import 'package:flutter/material.dart';
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
    return Scaffold(
        appBar: const MyAppBar(),
        drawer: Drawer(
            child: ListView(
          children: [
            DrawerHeader(
                decoration: BoxDecoration(
                  color: Pallete.color1,
                ),
                child: Text("Options",
                    style: TextStyle(color: Pallete.whiteColor, fontSize: 24))),
            ListTile(
              title: const Text("My profile"),
              onTap: () {
                // Handle tap
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              title: const Text("My donations"),
              onTap: () {
                // Handle tap
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              title: const Text("Settings"),
              onTap: () {
                // Handle tap
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              title: const Text("About us"),
              onTap: () {
                // Handle tap
                Navigator.pop(context); // Close the drawer
              },
            )
          ],
        )),
        body: Center(
          child: Column(
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient:
                      LinearGradient(colors: [Pallete.color3, Pallete.color2]),
                ),
                child: const SizedBox(height: 10, width: double.infinity),
              ),
              const SizedBox(height: 10),
              const Text("Marketplace",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CategoryTab(
                      name: "Shoes",
                      assetName: "Assets/shoes.svg",
                    ),
                    CategoryTab(
                      name: "Bottoms",
                      assetName: "Assets/bottoms.svg",
                    ),
                    CategoryTab(
                      name: "Tops",
                      assetName: "Assets/tops.svg",
                    ),
                    CategoryTab(
                      name: "Jackets",
                      assetName: "Assets/jackets.svg",
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.network(
                  "https://www.fashiongonerogue.com/wp-content/uploads/2021/04/Model-Chic-Fashion.jpg",
                  fit: BoxFit.fill,
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text("New releases"), Text("See all")],
                ),
              ),
              const Divider(
                color: Colors.black,
              ),
              //--------------- CARDS -------------------------
              Consumer<MarketPlaceViewModel>(
                builder: (context, viewMoodel, child) {
                  return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, childAspectRatio: 2 / 3),
                      itemCount: viewMoodel.items.length,
                      itemBuilder: (context, index) {
                        final clothe = viewMoodel.items[index];
                        return ClothesCard(item: clothe);
                      });
                },
              )
            ],
          ),
        ));
  }
}
