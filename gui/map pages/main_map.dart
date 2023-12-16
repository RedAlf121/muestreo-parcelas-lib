import 'package:animated_floating_buttons/animated_floating_buttons.dart';
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
  MapController? _controller;
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
    super.initState();
    _controller = MapController();
    getCurrentLocation();    
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createAppBar(context: context,text: const Text('Mapa')),      
      body: FutureBuilder(
        future: getCurrentLocation(),
        builder: (context, snapshot) {
          Widget actual = Container();
          switch(snapshot.connectionState){
            case ConnectionState.done: 
              actual = _createMap(); 
              break;
            case ConnectionState.waiting: 
              actual = const Center(
                child: CircularProgressIndicator(
                  color: Colors.greenAccent,
                )
              );
              break;
            default: actual = Container();    
          }              
          return actual;
        },
      ),
      floatingActionButton: _createFloatingButtons(context),
    );
  }

   Row _createFloatingButtons(BuildContext context) {
     return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          heroTag: 'location',
          onPressed: () async {              
            await getCurrentLocation();
            setState((){});              
          },
          child: const Icon(Icons.gps_not_fixed_outlined),
        ),
        const SizedBox.square(dimension: 5,),          
        _createAddButtons(context),
      ],
    );
   }

   AnimatedFloatingActionButton _createAddButtons(BuildContext context) {
     return AnimatedFloatingActionButton(  
        colorStartAnimation: (Theme.of(context).brightness == Brightness.dark)? const Color.fromARGB(255, 60, 144, 36) : const Color.fromARGB(255, 82, 183, 136),
        animatedIconData: AnimatedIcons.add_event,
        fabButtons: [
          FloatingActionButton(
            heroTag: 'polygonal',
            onPressed: (){

            },
            child: const Icon(Icons.hexagon_outlined),
          ),
          FloatingActionButton(
            heroTag: 'sample',
            onPressed: (){

            },
            child: const Icon(Icons.crop_square),
          )
        ], 
      );
   }

   FlutterMap _createMap() {
     return FlutterMap(
            mapController: _controller,
            options: MapOptions(
                center: myPosition, minZoom: 5, maxZoom: 25, zoom: 18),
            nonRotatedChildren: [
              apiMap(),
              userCurrentPosition(),

            ],
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


  Future<void> getCurrentLocation() async {
    Position position = await determinePosition();
    myPosition = LatLng(position.latitude, position.longitude);
    _controller!.fitBounds(LatLngBounds(myPosition, myPosition));  
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