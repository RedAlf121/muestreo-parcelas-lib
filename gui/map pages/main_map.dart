import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:muestreo_parcelas/utils/mixins/named_app_bar_mixin.dart';

// ignore: constant_identifier_names
const MAPBOX_ACCESS_TOKEN =
    'pk.eyJ1IjoicGl0bWFjIiwiYSI6ImNsY3BpeWxuczJhOTEzbnBlaW5vcnNwNzMifQ.ncTzM4bW-jpq-hUFutnR1g';

class MainMapPage extends StatefulWidget {
  const MainMapPage({super.key});

  @override
  State<MainMapPage> createState() => _MainMapPageState();
}

class _MainMapPageState extends State<MainMapPage> with NamedAppBar {
  LatLng? myPosition;
  
  //TODO hacer los metodos de insertar cada una de estas, utilizar paquetes externos de ser necesarios
  final Map<String,Widget> _markers = {
  // Crear un Marker para una poligonal

      'polygon' : IconButton( // Widget que se mostrará como icono
        icon: const Icon(Icons.hexagon_outlined),
        color: Colors.blue, // Color del icono
        onPressed: () { // Acción al presionar el icono
          // Mostrar un diálogo con opciones para la poligonal
        },
       ),
  
  // Crear un Marker para una parcela
      'parcel' : IconButton( // Widget que se mostrará como icono
        icon: const Icon(Icons.crop_square), // Icono de parcela
        color: Colors.green, // Color del icono
        onPressed: () { // Acción al presionar el icono
          // Mostrar un diálogo con opciones para la parcela
        },
      ),
  // Crear un Marker para una planta
      'plant' : IconButton( // Widget que se mostrará como icono
        icon: const Icon(Icons.local_florist), // Icono de planta
        color: Colors.pink, // Color del icono
        onPressed: () { // Acción al presionar el icono
          // Mostrar un diálogo con opciones para la planta
        },
      )
};

  String? selectedMarker;
  //TODO hacer los metodos de cargar las parcelas, plantas y poligonales
  //TODO utilizar Dialogs para la modificacion de atributos y tambien usarlo como menu de opciones para decidir 
  //si quieres modificar o exportar sus datos a excel ahi se puede aprovechar 
  //para los reportes


 @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createAppBar(context: context,text: const Text('Mapa')),
      body: myPosition == null
          ? const CircularProgressIndicator()
          : FlutterMap(
              options: MapOptions(
                  center: myPosition, minZoom: 5, maxZoom: 25, zoom: 18),
              nonRotatedChildren: [
                apiMap(),
                userCurrentPosition(),

              ],
            ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
           FloatingActionButton(
            onPressed: (){},
            child: const Icon(Icons.gps_not_fixed_outlined),
           ),
            FloatingActionButton(
            onPressed: (){},
            child: const Icon(Icons.add),
           ),
        ],
      ),
    );
  }

   TileLayer apiMap() {
     return TileLayer(
                urlTemplate:
                    'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
                additionalOptions: const {
                  'accessToken': MAPBOX_ACCESS_TOKEN,
                  'id': 'mapbox/streets-v12'
                },
              );
   }

   MarkerLayer userCurrentPosition() {
     return MarkerLayer(
                markers: [
                  userPointer(),
                ],
              );
   }

   Marker userPointer() {
     return Marker(
                    point: myPosition!,
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


  void getCurrentLocation() async {
    Position position = await determinePosition();
    setState(() {
      myPosition = LatLng(position.latitude, position.longitude);
      print(myPosition);
    });
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