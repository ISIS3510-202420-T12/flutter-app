import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wearabouts/core/theme/app_pallete.dart';
import 'package:wearabouts/core/widgets/appBar.dart';
import 'package:wearabouts/features/donation/view/pages/donationPage.dart';
import 'package:wearabouts/features/favorites/view/pages/favoritesPage.dart';
import 'package:wearabouts/features/profile/view/pages/profilePage.dart';
import 'package:wearabouts/features/sell/view/pages/sellPage.dart';
import 'package:wearabouts/features/home/viewmodel/marketPlaceViewModel.dart';
import '../../features/home/view/pages/homePage.dart';

class HomeFrame extends StatefulWidget {
  const HomeFrame({super.key});

  @override
  State<HomeFrame> createState() => _HomeFrameState();
}

class _HomeFrameState extends State<HomeFrame> {
  List<Widget> pages = [
    const HomePage(),
    const SellPage(),
    const DonationPage(),
    const FavoritesPage(),
    const ProfilePage(),
  ];
  int mycurrentIndex = 0;
  bool isConnected = true;
  final screenNames = ['Home', 'Sell', 'Donate', 'Favorites', 'Profile'];

  @override
  void initState() {
    super.initState();
    checkInternetConnection();
  }

  Future<void> checkInternetConnection() async {
    final networkService =
        Provider.of<MarketPlaceViewModel>(context, listen: false)
            .networkService;
    bool connectionStatus = await networkService.hasInternetConnection();
    setState(() {
      isConnected = connectionStatus;
    });

    if (!isConnected) {
      await Provider.of<MarketPlaceViewModel>(context, listen: false)
          .loadFromCache();
    }
  }

  void _onTabTapped(int index) {
    setState(() {
      mycurrentIndex = index;
      if (index == 0) {
        checkInternetConnection();
      }
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
              child: Text(
                "Options",
                style: TextStyle(color: Pallete.whiteColor, fontSize: 24),
              ),
            ),
            ListTile(
              title: const Text("My profile"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text("My donations"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text("Settings"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text("About us"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
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
              onTap: _onTabTapped,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
                BottomNavigationBarItem(icon: Icon(Icons.sell), label: "sell"),
                BottomNavigationBarItem(
                    icon: FaIcon(FontAwesomeIcons.gifts), label: "donate"),
                BottomNavigationBarItem(
                    icon: FaIcon(FontAwesomeIcons.solidHeart),
                    label: "favorites"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.circle), label: "profile"),
              ],
            ),
          ),
        ),
      ),
      body: Consumer<MarketPlaceViewModel>(
        builder: (context, viewModel, child) {
          if (mycurrentIndex == 0) {
            if (viewModel.items.isEmpty && !isConnected) {
              // Mostrar mensaje si no hay conexión y no hay datos cacheados
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.wifi_off,
                        size: 50,
                        color: Colors.red,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "No internet connection. Please connect to the internet to access this section.",
                        style: TextStyle(fontSize: 16, color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: checkInternetConnection,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Pallete.color2,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                        ),
                        child: const Text(
                          "Retry",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return pages[mycurrentIndex];
          }
          return pages[mycurrentIndex];
        },
      ),
    );
  }
}
