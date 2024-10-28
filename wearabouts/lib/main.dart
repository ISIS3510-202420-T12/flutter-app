import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wearabouts/core/repositories/campaignsRepository.dart';
import 'package:wearabouts/core/repositories/clothesRepository.dart';
import 'package:wearabouts/core/repositories/donationPlacesRepository.dart';
import 'package:wearabouts/core/repositories/donationsRepository.dart';
import 'package:wearabouts/core/repositories/usersRepository.dart';
import 'package:wearabouts/core/theme/theme.dart';
import 'package:wearabouts/features/auth/view/pages/firstTimePage.dart';
import 'package:provider/provider.dart';
import 'package:wearabouts/features/donation/viewModel/donationViewModel.dart';
import 'package:wearabouts/features/favorites/viewModel/favoritesViewModel.dart';
import 'package:wearabouts/features/home/viewmodel/marketPlaceViewModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'features/auth/viewmodel/userViewModel.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await Firebase.initializeApp();
  FirebaseFirestore.instance;
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  analytics.setAnalyticsCollectionEnabled(true);
  FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);
  ClothesRepository clothesRepository = ClothesRepository();
  UsersRepository usersRepository = UsersRepository();
  CampaignsRepository campaignsRepository = CampaignsRepository();
  DonationPlacesRepository donationPlacesRepository =
      DonationPlacesRepository();
  DonationsRepository donationsRepository = DonationsRepository();

  //await populateFirestore();
  runApp(MultiProvider(providers: [
    Provider<FirebaseAnalytics>.value(value: analytics),
    Provider<FirebaseAnalyticsObserver>.value(value: observer),
    ChangeNotifierProvider(
      create: (context) {
        UserViewModel userViewModel = UserViewModel(usersRepository);
        userViewModel.fetchUser('JVILLATET1');
        return userViewModel;
      },
    ),
    ChangeNotifierProvider(
        create: (_) =>
            MarketPlaceViewModel(clothesRepository, usersRepository)),
    ChangeNotifierProvider(create: (_) => FavoritesViewModel()),
    ChangeNotifierProvider(
        create: (_) => DonationViewModel(donationPlacesRepository,
            campaignsRepository, donationsRepository, usersRepository)),
  ], child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "WearAbouts",
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightThemeMode,
        home: const FirstTimePage());
  }
}
