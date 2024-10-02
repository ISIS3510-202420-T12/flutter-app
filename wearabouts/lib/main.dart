import 'package:flutter/material.dart';
import 'package:wearabouts/core/theme/theme.dart';
import 'package:wearabouts/features/auth/view/pages/firstTimePage.dart';
import 'package:provider/provider.dart';
import 'package:wearabouts/features/home/viewmodel/marketPlaceViewModel.dart';
import 'package:wearabouts/features/donation/pages/donationPage.dart';
import 'package:wearabouts/features/home/view/pages/homePage.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => MarketPlaceViewModel())
  ], child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "WearAbouts",
      theme: AppTheme.lightThemeMode,
      initialRoute: '/',
      routes: {
        '/': (context) => const FirstTimePage(), // Página de inicio
        '/home': (context) => const HomePage(), // Página principal (HomePage)
        '/donations': (context) => const DonationPage(), // Página de donaciones
      },
    );
  }
}
