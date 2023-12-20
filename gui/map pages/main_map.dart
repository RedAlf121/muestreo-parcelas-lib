import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:muestreo_parcelas/gui/map%20pages/postition_controller.dart';
import 'package:muestreo_parcelas/gui/map%20pages/storage.dart';
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
  //TODO hacer los metodos de insertar cada una de estas, utilizar paquetes externos de ser necesarios

  //TODO hacer los metodos de cargar las parcelas, plantas y poligonales
  //TODO utilizar Dialogs para la modificacion de atributos y tambien usarlo como menu de opciones para decidir
  //si quieres modificar o exportar sus datos a excel ahi se puede aprovechar
  //para los reportes
  late PositionController posControl;
  late MarkerStorage markStorage;
  @override
  void initState() {
    super.initState();
    markStorage = MarkerStorage(context, setState);
    posControl = PositionController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createAppBar(context: context, text: const Text('Mapa')),
      body: _createBody(),
      floatingActionButton: markStorage.createFloatingButtons(context),
    );
  }

  Widget _createBody() {
    return _createMap();
  }

  Widget _createMap() {
    return FlutterMap(  

      mapController: posControl.controller,
      options: MapOptions(
          onMapReady: ()async{
              await posControl.getCurrentLocation(markStorage.editing);
          },
          onTap: ((tapPosition, point) {
            if (markStorage.editing) {
              markStorage.addAuxiliarPoint(point);
              setState(() {});
            }
          }),
          center: posControl.myPosition,
          minZoom: 5,
          maxZoom: 25,
          zoom: 18),
      children: [
        apiMap(),
        posControl.userCurrentPosition(),
        auxiliarMarkers(markStorage.auxiliarPoints),
        polygonLayers(Types.polygonal),
        polygonLayers(Types.parcel),
        auxiliarMarkers(markStorage.markersLayer[Types.plant]!.cast<Marker>()),
        auxiliarMarkers(markStorage.editPoints),
      ],
    );
  }

  PolygonLayer polygonLayers(Types type) {
    return PolygonLayer(
      polygons: markStorage.markersLayer[type]!.cast<Polygon>(),
    );
  }

  MarkerLayer auxiliarMarkers(List<Marker> marks) {
    return MarkerLayer(
      markers: marks,
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
}
