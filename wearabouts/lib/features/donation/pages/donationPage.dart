import 'package:flutter/material.dart';
import 'package:wearabouts/core/theme/app_pallete.dart';
import 'package:wearabouts/features/donation/widgets/donation_statistics_card.dart';
import 'package:wearabouts/features/donation/widgets/categoryIcon.dart';
import 'package:wearabouts/features/donation/widgets/featuredCard.dart';
import 'package:wearabouts/features/donation/widgets/searchBar.dart';
import 'package:wearabouts/features/home/view/widgets/appBar.dart';
import 'package:wearabouts/features/home/view/widgets/bottomBar.dart';

class DonationPage extends StatelessWidget {
  const DonationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DonationStatisticsCard(),
            const SizedBox(height: 20),
            const SearchBarWithMap(),
            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CategoryIcon(
                    icon: Icons.book, label: "Study", color: Pallete.color2),
                CategoryIcon(
                    icon: Icons.local_hospital,
                    label: "Medic",
                    color: Pallete.color2),
                CategoryIcon(
                    icon: Icons.emoji_people,
                    label: "Human",
                    color: Pallete.color2),
                CategoryIcon(
                    icon: Icons.pets, label: "Animals", color: Pallete.color2),
              ],
            ),
            const SizedBox(height: 20),

            // Featured Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Featured",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Pallete.color1),
                ),
                TextButton(
                  onPressed: () {},
                  child:
                      Text("See More", style: TextStyle(color: Pallete.color1)),
                ),
              ],
            ),

            // Featured Cards con las imágenes actualizadas
            const FeaturedCard(
              title: "Help them have access to a hospital!",
              goal: "\$52,650/70,000",
              percentage: 82,
              imagePath: 'Assets/PictureKids.png',
            ),

            const FeaturedCard(
              title: "Help educate underprivileged children!",
              goal: "\$30,000/50,000",
              percentage: 60,
              imagePath: 'Assets/studying_kid.jpg',
            ),

            const FeaturedCard(
              title: "Save endangered species!",
              goal: "\$15,000/20,000",
              percentage: 75,
              imagePath: 'Assets/endangered_animals.jpg',
            ),

            const FeaturedCard(
              title: "Provide meals for the homeless!",
              goal: "\$10,000/12,000",
              percentage: 85,
              imagePath: 'Assets/food_donation.jpg',
            ),

            const FeaturedCard(
              title: "Support recycling efforts!",
              goal: "\$5,000/7,000",
              percentage: 70,
              imagePath: 'Assets/recycling_volunteers.jpg',
            ),
          ],
        ),
      ),
    );
  }
}
