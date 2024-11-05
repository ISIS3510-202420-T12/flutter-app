import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wearabouts/core/theme/app_pallete.dart';
import 'package:wearabouts/features/donation/view/pages/donationPage.dart';
import 'package:wearabouts/features/home/view/pages/homePage.dart';

class MyBottombar {
  Theme bottomnavbar(context, mycurrentIndex) => new Theme(
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
                                  builder: (context) => const DonationPage()))
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
      );
}
