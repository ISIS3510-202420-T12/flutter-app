import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wearabouts/features/home/model/clothe.dart';
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
    return Scaffold(
      appBar: const ContextAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          const Text("Checkout", style: TextStyle(fontSize: 24)),
          Consumer<MarketPlaceViewModel>(
            builder: (context, viewMoodel, child) {
              return Column(
                children: viewMoodel.kart.map((clothe) {
                  return ClothesKartCard(
                      item: clothe); // Tu widget para cada elemento
                }).toList(),
              );
            },
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text("Subtotal"), Text("20000")],
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text("Delivery fee"), Text("20000")],
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text("Total"), Text("20000")],
          ),
          const Divider(),
          const Row(
            children: [Text("Payment method")],
          ),
          Container(
            decoration: BoxDecoration(
                color: Pallete.color2, borderRadius: BorderRadius.circular(10)),
            child: ElevatedButton(
                onPressed: () {
                  MarketPlaceViewModel().makePayment(context);
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
    );
  }
}
