import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class PositionController {
  // Declarar las propiedades de la clase
  LatLng? _myPosition;
  late MapController _controller;

  // Definir un constructor que inicialice el controlador y obtenga la ubicación actual
  PositionController() {
    _controller = MapController();
    getCurrentLocation(true);
  }
  set myPosition(LatLng? pos)=>_myPosition=pos;
  LatLng? get myPosition => _myPosition;
  MapController? get controller => _controller;

  // Definir los métodos de la clase
  MarkerLayer userCurrentPosition() {
    return MarkerLayer(markers: [userPointer(),],);
  }

  Marker userPointer() {
    return Marker(
      point: myPosition ?? LatLng(0,0),
      builder: (context) {
        return Container(
          child: const Icon(
            Icons.person_pin,
            color: Colors.blueAccent,
            size: 40,
          ),
        );
      },
    );
  }
  //La posicion siempre se va a actualizar pero la camara no se va a mover hasta que no se termine de editar
  Future<void> getCurrentLocation(bool moveCamera) async {
    Position position = await determinePosition();
    myPosition = LatLng(position.latitude, position.longitude);
    _controller.move(myPosition!,15);
  }

  Future<Position> determinePosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('error');
      }
    }
    return await Geolocator.getCurrentPosition();
  }
}
