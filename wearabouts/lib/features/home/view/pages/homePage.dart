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
      bottomNavigationBar: new Theme(
        data: Theme.of(context).copyWith(
          // sets the background color of the `BottomNavigationBar`
          canvasColor: Pallete.color2,
        ),
        child: Container(
          color: Colors.transparent,
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BottomNavigationBar(
                backgroundColor: Colors.transparent,
                fixedColor: Pallete.whiteColor,
                unselectedItemColor: Pallete.color1,
                currentIndex: mycurrentIndex,
                showSelectedLabels: false,
                onTap: (index) => {
                      if (index == 0)
                        {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()))
                        },
                      if (index == 2)
                        {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()))
                        }
                    },
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: "home"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.sell), label: "sell"),
                  BottomNavigationBarItem(
                      icon: FaIcon(FontAwesomeIcons.gifts), label: "donate"),
                  BottomNavigationBarItem(
                      icon: FaIcon(FontAwesomeIcons.solidHeart),
                      label: "favorites"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.circle), label: "profile")
                ]),
          ),
        ),
      ),
      body: SingleChildScrollView(
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
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
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
      ),
    );
  }
}
