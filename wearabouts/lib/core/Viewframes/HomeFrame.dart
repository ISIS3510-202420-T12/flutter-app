import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wearabouts/core/theme/app_pallete.dart';
import 'package:wearabouts/core/widgets/appBar.dart';
import 'package:wearabouts/features/donation/pages/donationPage.dart';
import 'package:wearabouts/features/favorites/view/pages/favoritesPage.dart';
import 'package:wearabouts/features/profile/view/pages/profilePage.dart';
import 'package:wearabouts/features/sell/view/pages/sellPage.dart';

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
    const ProfilePage()
  ];
  int mycurrentIndex = 0;

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
      bottomNavigationBar: Theme(
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
                      setState(() {
                        mycurrentIndex = index;
                      })
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
      body: pages[mycurrentIndex],
    );
  }
}
