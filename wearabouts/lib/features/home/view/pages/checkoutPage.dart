import 'package:flutter/material.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:provider/provider.dart';
import 'package:wearabouts/features/auth/viewmodel/userViewModel.dart';
import 'package:wearabouts/features/home/view/widgets/clothesKartCard.dart';
import 'package:wearabouts/features/home/view/widgets/contextAppBar.dart';
import 'package:wearabouts/services/networkChecker/networkService.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import '../../../../core/theme/app_pallete.dart';
import '../../viewmodel/marketPlaceViewModel.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  bool isConnected = true;

  @override
  void initState() {
    super.initState();
    checkInternetConnection();
  }

  Future<void> checkInternetConnection() async {
    final networkService =
        Provider.of<MarketPlaceViewModel>(context, listen: false)
            .networkService;
    isConnected = await networkService.hasInternetConnection();
    setState(() {});
  }

  void _handlePayment(MarketPlaceViewModel viewModel) async {
    bool currentConnectionStatus =
        await viewModel.networkService.hasInternetConnection();
    if (!currentConnectionStatus) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text("No internet connection. Please connect and try again."),
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Payment"),
          content: const Text("Do you want to proceed with the payment?"),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text("Proceed"),
              onPressed: () {
                Navigator.of(context).pop();
                if (viewModel.kart.isNotEmpty) {
                  viewModel.makePayment(
                    context,
                    Provider.of<UserViewModel>(context, listen: false),
                    Provider.of<FirebaseAnalytics>(context, listen: false),
                  );

                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    duration: Duration(seconds: 2),
                    content: Text("Your order has been processed!"),
                  ));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Your cart is empty."),
                  ));
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ContextAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Text("Checkout", style: TextStyle(fontSize: 24)),
              const SizedBox(height: 10),
              Consumer<MarketPlaceViewModel>(
                builder: (context, viewModel, child) {
                  if (!isConnected) {
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
                              "You are offline. Please connect to the internet to proceed with payment.",
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
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  double subtotal = viewModel.totalPrice;
                  double deliveryFee = viewModel.deliveryFee;
                  double total = subtotal + deliveryFee;

                  MoneyFormatter formattedSubtotal = MoneyFormatter(
                    amount: subtotal,
                    settings: MoneyFormatterSettings(fractionDigits: 0),
                  );
                  MoneyFormatter formattedDeliveryFee = MoneyFormatter(
                    amount: deliveryFee,
                    settings: MoneyFormatterSettings(fractionDigits: 0),
                  );
                  MoneyFormatter formattedTotalPrice = MoneyFormatter(
                    amount: total,
                    settings: MoneyFormatterSettings(fractionDigits: 0),
                  );

                  return Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Pallete.whiteColor,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          children: viewModel.kart.map((clothe) {
                            return ClothesKartCard(
                              item: clothe,
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Subtotal"),
                          Text(formattedSubtotal.output.symbolOnRight),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Delivery fee"),
                          Text(formattedDeliveryFee.output.symbolOnRight),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Total"),
                          Text(formattedTotalPrice.output.symbolOnRight),
                        ],
                      ),
                      const Divider(),
                      const Row(
                        children: [
                          Text("Payment method"),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Pallete.color2,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ElevatedButton(
                          onPressed: viewModel.kart.isEmpty
                              ? null
                              : () => _handlePayment(viewModel),
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(150, 50),
                            backgroundColor: Pallete.transparentColor,
                            shadowColor: Pallete.transparentColor,
                          ),
                          child: const Text(
                            "PAY",
                            style: TextStyle(fontSize: 24, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
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
