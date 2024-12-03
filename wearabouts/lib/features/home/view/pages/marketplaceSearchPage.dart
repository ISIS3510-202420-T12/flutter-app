import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wearabouts/features/home/view/pages/marketplaceSearchResultPage.dart';
import 'package:wearabouts/features/home/viewmodel/marketPlaceViewModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MarketplaceSearchPage extends StatefulWidget {
  const MarketplaceSearchPage({super.key});

  @override
  _MarketplaceSearchPageState createState() => _MarketplaceSearchPageState();
}

class _MarketplaceSearchPageState extends State<MarketplaceSearchPage> {
  List<String> recentSearches = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadRecentSearches();  // Cargar historial de búsqueda al iniciar
  }

  // Método para cargar el historial de búsqueda desde SharedPreferences
  Future<void> _loadRecentSearches() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      recentSearches = prefs.getStringList('recentSearches') ?? [];
    });
  }

  // Método para limpiar el historial de búsqueda
  void clearSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      recentSearches.clear();
    });
    await prefs.remove('recentSearches'); // Eliminar los datos de SharedPreferences
  }

  // Método para agregar una nueva búsqueda a la lista
  void addSearch(String searchQuery) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      if (!recentSearches.contains(searchQuery)) {
        recentSearches.insert(0, searchQuery);
      }
    });
    await prefs.setStringList('recentSearches', recentSearches);  // Guardar en SharedPreferences
  }

  // Método para manejar el envío de una búsqueda
  void handleSearch(String searchQuery) {
    if (searchQuery.isNotEmpty) {
      addSearch(searchQuery);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MarketplaceSearchResultPage(searchTerm: searchQuery),
        ),
      ).then((_) {
        searchController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: TextField(
          controller: searchController,
          decoration: const InputDecoration(
            hintText: 'Search',
            border: InputBorder.none,
          ),
          textInputAction: TextInputAction.search, // Mostrar botón de búsqueda en el teclado
          onSubmitted: handleSearch, 
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Divider
            const Divider(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Recent Searches',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: clearSearchHistory,
                  child: const Text(
                    'Clear',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),

            Expanded(
              child: ListView.builder(
                itemCount: recentSearches.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(recentSearches[index]),
                    onTap: () {
                      handleSearch(recentSearches[index]); 
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}