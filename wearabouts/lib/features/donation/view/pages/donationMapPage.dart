import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

import 'package:wearabouts/features/donation/view/widgets/searchBar.dart';
import 'package:wearabouts/features/donation/viewModel/donationViewModel.dart';
import 'package:wearabouts/features/home/view/widgets/contextAppBar.dart';

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
    return Scaffold(
      appBar: const ContextAppBar(),
      body: Column(
        children: [
          SizedBox(
            height: 500,
            child: Consumer<DonationViewModel>(
              builder: (context, viewModel, child) {
                if (viewModel.locationData == null) {
                  // Muestra un indicador de carga mientras se obtiene la ubicación
                  return const Center(child: CircularProgressIndicator());
                }
                // Una vez que se obtiene la ubicación, se muestra el mapa
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
                        markerId: MarkerId("Me"),
                        icon: BitmapDescriptor.defaultMarker,
                        position: LatLng(
                          viewModel.locationData!.latitude!,
                          viewModel.locationData!.longitude!,
                        ))
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
