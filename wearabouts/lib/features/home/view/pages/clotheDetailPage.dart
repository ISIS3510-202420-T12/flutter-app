import 'package:flutter/material.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:wearabouts/features/home/model/clothe.dart';
import 'package:wearabouts/features/home/view/pages/checkoutPage.dart';
import 'package:wearabouts/features/home/view/widgets/addToKart.dart';
import 'package:wearabouts/features/home/view/widgets/buyBotton.dart';
import 'package:wearabouts/features/home/view/widgets/contextAppBar.dart';
import 'package:wearabouts/features/home/view/widgets/vendorProfileCard.dart';
import 'package:wearabouts/features/home/viewmodel/marketPlaceViewModel.dart';

class ClotheDetailPage extends StatefulWidget {
  final Clothe item;
  const ClotheDetailPage({super.key, required this.item});

  @override
  State<ClotheDetailPage> createState() => _ClotheDetailPageState(item);
}

class _ClotheDetailPageState extends State<ClotheDetailPage> {
  Clothe item;

  _ClotheDetailPageState(this.item);

  @override
  Widget build(BuildContext context) {
    MoneyFormatter formatedPrice = MoneyFormatter(
        amount: item.price.toDouble(),
        settings: MoneyFormatterSettings(fractionDigits: 0));

    return Scaffold(
        appBar: const ContextAppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                      height: 400,
                      width: double.infinity,
                      color: Colors.grey,
                      child: Image.network(
                        item.imagesURLs[0],
                        fit: BoxFit.fitHeight,
                      )),
                ),
                const SizedBox(height: 20),
                Text(item.title, style: const TextStyle(fontSize: 24)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "S size | No use",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w100),
                    ),
                    Column(
                      children: [
                        BuyButton(
                          onTap: () {
                            MarketPlaceViewModel().addToKart(item);
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        AddToKartButton(onTap: () {
                          MarketPlaceViewModel().addToKart(item);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CheckoutPage()),
                          );
                        })
                      ],
                    )
                  ],
                ),
                Text(formatedPrice.output.symbolOnRight,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold)),
                const Divider(),
                const Row(
                  children: [
                    Icon(
                      Icons.support_agent,
                      size: 40,
                    ),
                    SizedBox(
                      width: 30,
                      height: 50,
                    ),
                    Text(
                      "Ask a question to the vendor",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
                const Divider(),
                const Text("Description",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                Text(item.description,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w400)),
                const SizedBox(
                  height: 20,
                ),
                const VendorProfileCard()
              ],
            ),
          ),
        ));
  }
}
