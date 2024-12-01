import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wearabouts/core/repositories/model/clothe.dart';
import 'package:wearabouts/core/theme/app_pallete.dart';
import 'package:wearabouts/features/auth/viewmodel/userViewModel.dart';
import 'package:wearabouts/features/profile/view/widgets/saleCard.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();

    // Inicializa el ViewModel y llena la lista de items

    Future.microtask(() {
      print(Provider.of<UserViewModel>(context, listen: false).user!.id);
      Provider.of<UserViewModel>(context, listen: false).fetchUserSales();
    });
  }

  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context);
    final user = userViewModel.user;
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            children: [
              Divider(),
              //Info
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: user!.profilePic,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => const Icon(
                        Icons.person, // Ícono en caso de error
                        size: 140,
                        color: Colors.grey,
                      ),
                      width: 140, // Tamaño del círculo
                      height: 140,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [],
                          mainAxisSize: MainAxisSize.max,
                        ),
                        Text(
                          user!.username,
                          style: TextStyle(fontSize: 24),
                        ),
                        Text(user!.email),
                        Text(user!.city),
                        SizedBox(
                          height: 20,
                        ),
                        Text("Purchases: " + user.purchases.toString()),
                        Text("Sales: " + user.sales.toString())
                      ],
                    ),
                  )
                ],
              ),
              Divider(),
              //Productos comprados
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Pallete.color2,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        "Latest purchases",
                        style:
                            TextStyle(fontSize: 24, color: Pallete.whiteColor),
                      ),
                      Consumer<UserViewModel>(
                        builder: (context, userViewModel, child) {
                          print(userViewModel.userSales.length);
                          return Column(
                            children: userViewModel.userSales.map((sale) {
                              return FutureBuilder(
                                future: sale.item
                                    .get(), // Cargar el documento de Firestore
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return CircularProgressIndicator(); // Indicador de carga
                                  }

                                  if (snapshot.hasError) {
                                    return Text('Error loading item');
                                  }

                                  if (!snapshot.hasData ||
                                      snapshot.data == null) {
                                    return Text('No data found');
                                  }

                                  // Crear el objeto Clothe a partir del DocumentSnapshot usando fromDocument
                                  final clothe =
                                      Clothe.fromDocument(snapshot.data!);

                                  return SaleCard(sale: sale, item: clothe);
                                },
                              );
                            }).toList(),
                          );
                        },
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
