import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wearabouts/core/theme/app_pallete.dart';
import 'package:wearabouts/features/donation/view/widgets/donation_statistics_card.dart';
import 'package:wearabouts/features/donation/view/widgets/categoryIcon.dart';
import 'package:wearabouts/features/donation/view/widgets/featuredCard.dart';
import 'package:wearabouts/features/donation/view/widgets/searchBar.dart';
import 'package:wearabouts/features/donation/viewModel/donationViewModel.dart';

import '../../../auth/viewmodel/userViewModel.dart';

class DonationPage extends StatefulWidget {
  const DonationPage({super.key});

  @override
  State<DonationPage> createState() => _DonationPageState();
}

class _DonationPageState extends State<DonationPage> {
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.microtask(() {
      Provider.of<DonationViewModel>(context, listen: false).populate();
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController inputDonationController = TextEditingController();
    inputDonationController.addListener(() {
      String filteredText =
          inputDonationController.text.replaceAll(RegExp(r'[^0-9]'), '');
      if (inputDonationController.text != filteredText) {
        inputDonationController.text = filteredText;
        inputDonationController.selection = TextSelection.fromPosition(
          TextPosition(offset: inputDonationController.text.length),
        );
      }
    });
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

            Consumer<DonationViewModel>(builder: (context, viewModel, child) {
              return Column(
                children: viewModel.campaigns.map((camp) {
                  return FeaturedCard(
                    title: camp.name,
                    goal: ("\$" +
                        camp.reached.toInt().toString() +
                        "/" +
                        "\$" +
                        camp.goal.toInt().toString()),
                    percentage: ((camp.reached / camp.goal) * 100).toInt(),
                    imagePath: camp.image,
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => Dialog(
                          child: Container(
                            height: 450,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(5)),
                                    color: Pallete.color2,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 5),
                                    child: Image.network(
                                      camp.image,
                                      height: 250,
                                      width: double.infinity,
                                      fit: BoxFit.fill,
                                      loadingBuilder: (BuildContext context,
                                          Widget child,
                                          ImageChunkEvent? loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child; // La imagen se ha cargado completamente
                                        } else {
                                          return SizedBox(
                                            height: 150,
                                            child: Center(
                                              child: CircularProgressIndicator(
                                                value: loadingProgress
                                                            .expectedTotalBytes !=
                                                        null
                                                    ? loadingProgress
                                                            .cumulativeBytesLoaded /
                                                        (loadingProgress
                                                                .expectedTotalBytes ??
                                                            1)
                                                    : null,
                                              ),
                                            ),
                                          ); // Muestra un spinner mientras la imagen se carga
                                        }
                                      },
                                      errorBuilder: (BuildContext context,
                                          Object exception,
                                          StackTrace? stackTrace) {
                                        return Image.asset(
                                          'assets/images/placeholder.png',
                                          height: 150,
                                          fit: BoxFit.fitHeight,
                                        ); // Muestra una imagen local predeterminada si la carga falla
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(camp.name,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500)),
                                const Text("You can support this campaign!",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w200)),
                                const SizedBox(
                                  height: 30,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 140,
                                        child: TextField(
                                          controller: inputDonationController,
                                          decoration: const InputDecoration(
                                              labelText: "Help with funds..",
                                              labelStyle: TextStyle(
                                                  fontWeight: FontWeight.w100),
                                              hintText: "1000...",
                                              hintStyle: TextStyle(
                                                  fontWeight: FontWeight.w200)),
                                          keyboardType: TextInputType.number,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      //BOTON DONAR
                                      Container(
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(colors: [
                                              Pallete.color3,
                                              Pallete.color2
                                            ]),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: ElevatedButton(
                                            onPressed: () {
                                              Provider.of<DonationViewModel>(
                                                      context,
                                                      listen: false)
                                                  .addDonation(
                                                      inputDonationController
                                                          .text,
                                                      Provider.of<
                                                              UserViewModel>(
                                                          context,
                                                          listen: false),
                                                      Provider.of<
                                                              FirebaseAnalytics>(
                                                          context,
                                                          listen: false),
                                                      camp);
                                              inputDonationController.clear();
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                duration: Duration(seconds: 5),
                                                content: Text(
                                                    "Your donation has been procesed, ¡Thank you!"),
                                              ));
                                            },
                                            style: ElevatedButton.styleFrom(
                                                fixedSize: const Size(150, 50),
                                                backgroundColor:
                                                    Pallete.transparentColor,
                                                shadowColor:
                                                    Pallete.transparentColor),
                                            child: const Text(
                                              "Donate",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white),
                                            )),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              );
            }),
            // Featured Cards con las imágenes actualizadas
          ],
        ),
      ),
    );
  }
}
