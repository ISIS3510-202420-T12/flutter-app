import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wearabouts/core/repositories/model/campaign.dart';
import 'package:wearabouts/features/donation/view/widgets/mapPlaceSearchBar.dart';
import 'package:wearabouts/features/donation/viewModel/donationViewModel.dart';
import 'package:wearabouts/features/home/view/widgets/contextAppBar.dart';
import 'package:wearabouts/services/networkChecker/networkService.dart';

import '../../../../core/theme/app_pallete.dart';

class DonationMapPage extends StatefulWidget {
  const DonationMapPage({super.key});

  @override
  State<DonationMapPage> createState() => _DonationMapPageState();
}

class _DonationMapPageState extends State<DonationMapPage> {
  GoogleMapController? _mapController;
  bool isConnected = true;

  @override
  void initState() {
    super.initState();
    checkInternetConnection();
    Provider.of<DonationViewModel>(context, listen: false).fetchLocation();
  }

  Future<void> checkInternetConnection() async {
    final networkService = NetworkService();
    isConnected = await networkService.hasInternetConnection();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    int selectedMarkerIndex = 0;
    final CarouselSliderController carouselController =
        CarouselSliderController();

    return Scaffold(
      appBar: const ContextAppBar(),
      body: isConnected
          ? SingleChildScrollView(
              child: Column(
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Pallete.color3, Pallete.color2]),
                    ),
                    child: const SizedBox(height: 10, width: double.infinity),
                  ),
                  SizedBox(height: 5),
                  const Text("Donation Map",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: MapPlaceSearchBar(),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 420,
                    child: Consumer<DonationViewModel>(
                      builder: (context, viewModel, child) {
                        if (viewModel.locationData == null) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        List<Marker> placesMarkers = viewModel.donationPlaces
                            .asMap()
                            .entries
                            .map((entry) {
                          int index = entry.key;
                          var place = entry.value;
                          return Marker(
                            markerId: MarkerId(place.id),
                            icon: BitmapDescriptor.defaultMarkerWithHue(
                                BitmapDescriptor.hueBlue),
                            position: LatLng(place.lattitude, place.longitude),
                            onTap: () {
                              selectedMarkerIndex = index;

                              Provider.of<FirebaseAnalytics>(context,
                                      listen: false)
                                  .logEvent(
                                      name: 'select_donation_place',
                                      parameters: {
                                    'place_name': place.name,
                                  });

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
                        }).toList();
                        return GoogleMap(
                          onMapCreated: (GoogleMapController controller) {
                            _mapController = controller;
                          },
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
                  const Text("Donation Places",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(1, 2),
                                )
                              ],
                            ),
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
                                  ),
                                  Text(place.description,
                                      style: TextStyle(fontSize: 9))
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                        options: CarouselOptions(
                          height: 290,
                          initialPage: selectedMarkerIndex,
                          onPageChanged: (index, reason) {
                            selectedMarkerIndex = index;
                            if (_mapController != null) {
                              _mapController!.animateCamera(
                                CameraUpdate.newLatLng(
                                  LatLng(
                                      viewModel.donationPlaces[index].lattitude,
                                      viewModel
                                          .donationPlaces[index].longitude),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    );
                  }).toList(),
                  options: CarouselOptions(
                    height: 290,
                    initialPage: selectedMarkerIndex,
                    onPageChanged: (index, reason) {
                      selectedMarkerIndex = index;
                      if (_mapController != null) {
                        _mapController!.animateCamera(
                          CameraUpdate.newLatLng(
                            LatLng(viewModel.donationPlaces[index].lattitude,
                                viewModel.donationPlaces[index].longitude),
                          ),
                        );
                      }

                      Provider.of<FirebaseAnalytics>(context, listen: false)
                          .logEvent(name: 'select_donation_place', parameters: {
                        'place_name': viewModel.donationPlaces[index].name,
                      });
                    },
                  ),
                ],
              ),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.wifi_off, size: 50, color: Colors.red),
                  const SizedBox(height: 10),
                  const Text(
                      "No internet connection. Please connect to the internet to view the donation map."),
                ],
              ),
            ),
    );
  }
}
