import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:provider/provider.dart';
import 'package:wearabouts/core/repositories/model/campaign.dart';
import 'package:wearabouts/features/donation/view/widgets/mapPlaceSearchBar.dart';

import 'package:wearabouts/features/donation/viewModel/donationViewModel.dart';
import 'package:wearabouts/features/home/view/widgets/contextAppBar.dart';

import '../../../../core/theme/app_pallete.dart';

class DonationMapPage extends StatefulWidget {
  const DonationMapPage({super.key});

  @override
  State<DonationMapPage> createState() => _DonationMapPageState();
}

class _DonationMapPageState extends State<DonationMapPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<DonationViewModel>(context, listen: false).fetchLocation();
  }

  @override
  Widget build(BuildContext context) {
    int selectedMarkerIndex = 0;
    final CarouselSliderController carouselController =
        CarouselSliderController();
    return Scaffold(
      appBar: const ContextAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                gradient:
                    LinearGradient(colors: [Pallete.color3, Pallete.color2]),
              ),
              child: const SizedBox(height: 10, width: double.infinity),
            ),
            SizedBox(
              height: 5,
            ),
            const Text("Donation Map",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 5,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: MapPlaceSearchBar(),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(),
              height: 420,
              child: Consumer<DonationViewModel>(
                builder: (context, viewModel, child) {
                  if (viewModel.locationData == null) {
                    // Muestra un indicador de carga mientras se obtiene la ubicación
                    return const Center(child: CircularProgressIndicator());
                  }
                  // Una vez que se obtiene la ubicación, se muestra el mapa
                  List<Marker> placesMarkers = viewModel.donationPlaces
                      .asMap()
                      .entries
                      .map((entry) {
                        int index = entry.key; // índice del elemento
                        var place = entry.value; // elemento en sí (place)
                        try {
                          return Marker(
                            markerId: MarkerId(place.id),
                            icon: BitmapDescriptor.defaultMarkerWithHue(
                              BitmapDescriptor.hueBlue,
                            ),
                            position: LatLng(
                              place.lattitude,
                              place.longitude,
                            ),
                            onTap: () {
                              selectedMarkerIndex = index;

                              try {
                                // Intenta mover el carrusel a la página especificada
                                carouselController.animateToPage(
                                  index,
                                  duration: Duration(milliseconds: 40),
                                );
                              } catch (e) {
                                // En caso de que ocurra una excepción, muestra un mensaje de error o realiza un log
                                print("Error moving the carrousel: $e");

                                ;
                              }
                            },
                          );
                        } catch (e) {
                          // En caso de error, se imprime un mensaje y se devuelve null
                          print(
                              "Error loading marker for place ${place.id}: $e");
                          return null;
                        }
                      })
                      .where((marker) => marker != null)
                      .cast<Marker>()
                      .toList();
                  return GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                        viewModel.locationData!.latitude!,
                        viewModel.locationData!.longitude!,
                      ),
                      zoom: 13,
                    ),
                    markers: {
                      Marker(
                          markerId: const MarkerId("Me"),
                          icon: BitmapDescriptor.defaultMarker,
                          position: LatLng(
                            viewModel.locationData!.latitude!,
                            viewModel.locationData!.longitude!,
                          )),
                      ...placesMarkers
                    },
                  );
                },
              ),
            ),
            const Text(
              "Donation Places",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Consumer<DonationViewModel>(
              builder: (context, viewModel, child) {
                if (viewModel.donationPlaces.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }

                return CarouselSlider(
                  items: viewModel.donationPlaces.map((place) {
                    return Container(
                      width: 330,
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                          color: Pallete.color2,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black
                                  .withOpacity(0.2), // Color de la sombra
                              spreadRadius: 5, // Cuánto se extiende la sombra
                              blurRadius: 7, // Cuánto se difumina la sombra
                              offset: const Offset(
                                  1, 2), // Desplazamiento de la sombra (x, y)
                            )
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 300,
                                height: 180,
                                color: Pallete.color0,
                                child: Image.network(
                                  place.image,
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ),
                            Text(
                              place.name,
                              style: TextStyle(
                                  color: Pallete.whiteColor,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 16),
                            )
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                  options: CarouselOptions(
                    height: 280,
                    initialPage: selectedMarkerIndex,
                    onPageChanged: (index, reason) {
                      selectedMarkerIndex = index;
                    },
                  ),
                  carouselController: carouselController,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
