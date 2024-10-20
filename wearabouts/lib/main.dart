import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wearabouts/core/repositories/clothesRepository.dart';
import 'package:wearabouts/core/repositories/usersRepository.dart';
import 'package:wearabouts/core/theme/theme.dart';
import 'package:wearabouts/features/auth/view/pages/firstTimePage.dart';
import 'package:provider/provider.dart';
import 'package:wearabouts/features/favorites/viewModel/favoritesViewModel.dart';
import 'package:wearabouts/features/home/viewmodel/marketPlaceViewModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseFirestore.instance;

  ClothesRepository clothesRepository = ClothesRepository();
  UsersRepository usersRepository = UsersRepository();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
        create: (_) => MarketPlaceViewModel(clothesRepository)),
    ChangeNotifierProvider(create: (_) => FavoritesViewModel())
  ], child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "WearAbouts",
        theme: AppTheme.lightThemeMode,
        home: const FirstTimePage());
  }
}
