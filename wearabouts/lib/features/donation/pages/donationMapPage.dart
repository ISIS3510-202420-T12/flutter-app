import 'package:flutter/material.dart';
import 'package:wearabouts/features/donation/widgets/searchBar.dart';
import 'package:wearabouts/features/home/view/widgets/contextAppBar.dart';

class DonationMapPage extends StatefulWidget {
  const DonationMapPage({super.key});

  @override
  State<DonationMapPage> createState() => _DonationMapPageState();
}

class _DonationMapPageState extends State<DonationMapPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: ContextAppBar(),
      body: Column(
        children: [
          const SearchBarWithMap(),
        ],
      ),
    );
  }
}
