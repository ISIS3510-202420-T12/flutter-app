import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wearabouts/core/repositories/model/clothe.dart';
import 'package:wearabouts/core/theme/app_pallete.dart';
import 'package:wearabouts/features/auth/viewmodel/userViewModel.dart';
import 'package:wearabouts/services/networkChecker/networkService.dart';
import 'package:wearabouts/features/profile/view/widgets/saleCard.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isConnected = true;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      await checkInternetConnection();
      final userViewModel = Provider.of<UserViewModel>(context, listen: false);

      if (isConnected) {
        await userViewModel.fetchUser(userViewModel.user?.id ?? '');
      } else {
        if (userViewModel.user == null) {
          setState(() {
            isLoading = false;
          });
        }
      }

      setState(() {
        isLoading = false;
      });
    });
  }

  Future<void> checkInternetConnection() async {
    final networkService = NetworkService();
    isConnected = await networkService.hasInternetConnection();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context);
    final user = userViewModel.user;

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (!isConnected && user == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.cloud_off, size: 100, color: Colors.grey),
            const SizedBox(height: 20),
            const Text(
              "No Internet Connection",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "Please connect to the Internet to view your profile.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            children: [
              const Divider(),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: user?.profilePic ?? '',
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => const Icon(
                        Icons.person,
                        size: 140,
                        color: Colors.grey,
                      ),
                      width: 140,
                      height: 140,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user?.username ?? 'Unknown',
                          style: const TextStyle(fontSize: 24),
                        ),
                        Text(user?.email ?? 'No email'),
                        Text(user?.city ?? 'No city'),
                        const SizedBox(height: 20),
                        Text("Purchases: ${user?.purchases ?? 0}"),
                        Text("Sales: ${user?.sales ?? 0}"),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Pallete.color2,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const Text(
                        "Latest purchases",
                        style: TextStyle(fontSize: 24, color: Colors.white),
                      ),
                      Consumer<UserViewModel>(
                        builder: (context, userViewModel, child) {
                          return Column(
                            children: userViewModel.userSales.map((sale) {
                              return FutureBuilder(
                                future: sale.item.get(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const CircularProgressIndicator();
                                  }

                                  if (snapshot.hasError) {
                                    return const Text('Error loading item');
                                  }

                                  if (!snapshot.hasData ||
                                      snapshot.data == null) {
                                    return const Text('No data found');
                                  }

                                  final clothe =
                                      Clothe.fromDocument(snapshot.data!);

                                  return SaleCard(sale: sale, item: clothe);
                                },
                              );
                            }).toList(),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
