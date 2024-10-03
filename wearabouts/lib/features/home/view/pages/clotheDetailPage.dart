import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wearabouts/features/home/model/clothe.dart';
import 'package:wearabouts/features/home/view/widgets/buyBotton.dart';
import 'package:wearabouts/features/home/view/widgets/contextAppBar.dart';
import 'package:wearabouts/features/home/view/widgets/vendorProfileCard.dart';

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
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "S size | No use",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w100),
                    ),
                    BuyButton()
                  ],
                ),
                const Text("80.000",
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const Divider(),
                const Row(
                  children: [
                    Icon(Icons.support_agent),
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
                SizedBox(
                  height: 20,
                ),
                const VendorProfileCard()
              ],
            ),
          ),
        ));
  }
}
