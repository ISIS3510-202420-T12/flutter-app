import 'package:flutter/material.dart';
import 'package:wearabouts/features/home/view/widgets/appBar.dart';
import 'package:wearabouts/features/home/view/widgets/categoryTab.dart';

import '../../../../core/theme/app_pallete.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
              const Row(
                children: [
                  CategoryTab(
                    name: "Shoes",
                    assetName: "Assets/shoes.svg",
                  ),
                  CategoryTab(
                    name: "Bottoms",
                    assetName: "Assets/shoes.svg",
                  ),
                  CategoryTab(
                    name: "Tops",
                    assetName: "Assets/shoes.svg",
                  ),
                  CategoryTab(
                    name: "Jackets",
                    assetName: "Assets/jackets.svg",
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
