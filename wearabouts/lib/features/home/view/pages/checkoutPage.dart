import 'package:flutter/material.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:provider/provider.dart';
import 'package:wearabouts/features/auth/viewmodel/userViewModel.dart';
import 'package:wearabouts/features/home/view/widgets/clothesKartCard.dart';
import 'package:wearabouts/features/home/view/widgets/contextAppBar.dart';

import '../../../../core/theme/app_pallete.dart';
import '../../viewmodel/marketPlaceViewModel.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  Widget build(BuildContext context) {
    double subtotal =
        Provider.of<MarketPlaceViewModel>(context, listen: false).obtainPrice();
    double deliveryFee = 3000;
    double total = subtotal + deliveryFee;
    MoneyFormatter formatedSubTotal = MoneyFormatter(
        amount: subtotal, settings: MoneyFormatterSettings(fractionDigits: 0));
    MoneyFormatter formatedDeliveryFee = MoneyFormatter(
        amount: deliveryFee,
        settings: MoneyFormatterSettings(fractionDigits: 0));
    MoneyFormatter formatedTotalPrice = MoneyFormatter(
        amount: total, settings: MoneyFormatterSettings(fractionDigits: 0));

    return Scaffold(
      appBar: const ContextAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            const Text("Checkout", style: TextStyle(fontSize: 24)),
            Consumer<MarketPlaceViewModel>(
              builder: (context, viewMoodel, child) {
                return Container(
                  decoration: BoxDecoration(
                      color: Pallete.whiteColor,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5, // Qué tan difusa es la sombra
                          offset: Offset(0, 3), // Posición de la sombra (x, y)
                        ),
                      ]),
                  child: Column(
                    children: viewMoodel.kart.map((clothe) {
                      return ClothesKartCard(
                          item: clothe); // Tu widget para cada elemento
                    }).toList(),
                  ),
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Subtotal"),
                Text(formatedSubTotal.output.symbolOnRight)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Delivery fee"),
                Text(formatedDeliveryFee.output.symbolOnRight)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total"),
                Text(formatedTotalPrice.output.symbolOnRight)
              ],
            ),
            const Divider(),
            const Row(
              children: [Text("Payment method")],
            ),
            Container(
              decoration: BoxDecoration(
                  color: Pallete.color2,
                  borderRadius: BorderRadius.circular(10)),
              child: ElevatedButton(
                  onPressed: () {
                    Provider.of<MarketPlaceViewModel>(context, listen: false)
                        .makePayment(context,
                            Provider.of<UserViewModel>(context, listen: false));
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      duration: Duration(seconds: 1),
                      content: Text("Compra exitosa!"),
                    ));
                  },
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size(150, 50),
                      backgroundColor: Pallete.transparentColor,
                      shadowColor: Pallete.transparentColor),
                  child: const Text(
                    "PAY",
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  )),
            )
          ]),
        ),
      ),
    );
  }
}
