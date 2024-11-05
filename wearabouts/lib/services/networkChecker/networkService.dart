import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkService {
  final Connectivity _connectivity = Connectivity();

  // Método para verificar si hay conexión a internet
  Future<bool> hasInternetConnection() async {
    var connectivityResult = await _connectivity.checkConnectivity();
    return connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi;
  }

  // Método para escuchar cambios en el estado de la conexión
  Stream<ConnectivityResult> get connectivityStream =>
      _connectivity.onConnectivityChanged;
}
