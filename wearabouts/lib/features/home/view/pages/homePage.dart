import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:wearabouts/features/home/view/widgets/categoryTab.dart';
import 'package:wearabouts/features/home/view/widgets/clothesCard.dart';
import 'package:wearabouts/features/home/viewmodel/marketPlaceViewModel.dart';

import '../../../../core/theme/app_pallete.dart';
import '../../../auth/viewmodel/userViewModel.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isConnected = true;

  @override
  void initState() {
    super.initState();
    checkInternetAndLoadData();
  }

  Future<void> checkInternetAndLoadData() async {
    final viewModel = Provider.of<MarketPlaceViewModel>(context, listen: false);
    final userViewModel = Provider.of<UserViewModel>(context, listen: false);
    final networkService = viewModel.networkService;

    bool connectionStatus = await networkService.hasInternetConnection();
    setState(() {
      isConnected = connectionStatus;
    });

    if (viewModel.items.isEmpty) {
      if (isConnected) {
        await viewModel.populate(userViewModel);
      } else {
        await viewModel.loadFromCache();
      }
    }
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
                child: CachedNetworkImage(
                  imageUrl:
                      "https://www.fashiongonerogue.com/wp-content/uploads/2021/04/Model-Chic-Fashion.jpg",
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Center(
                    child: Icon(
                      Icons.broken_image,
                      size: 50,
                      color: Colors.red,
                    ),
                  ),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            Consumer<MarketPlaceViewModel>(
              builder: (context, marketPlaceViewModel, child) {
                if (marketPlaceViewModel.items.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: isConnected
                          ? const CircularProgressIndicator()
                          : const Text(
                              "You are offline. Displaying cached data.",
                              style: TextStyle(fontSize: 16, color: Colors.red),
                              textAlign: TextAlign.center,
                            ),
                    ),
                  );
                }

                return Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text("Featured")],
                      ),
                    ),
                    const Divider(color: Colors.black),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: marketPlaceViewModel.featured.map((clothe) {
                        return ClothesCard(item: clothe);
                      }).toList(),
                    ),
                  ],
                );
              },
            ),
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text("New releases"), Text("See all")],
              ),
            ),
            const Divider(color: Colors.black),
            Consumer2<MarketPlaceViewModel, UserViewModel>(
              builder: (context, marketPlaceViewModel, userViewModel, child) {
                if (userViewModel.user != null) {
                  marketPlaceViewModel
                      .sortItemsByUserLabelsAsync(userViewModel.user!.labels);
                }

                return Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: marketPlaceViewModel.filteredItems.map((clothe) {
                    return ClothesCard(item: clothe);
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
