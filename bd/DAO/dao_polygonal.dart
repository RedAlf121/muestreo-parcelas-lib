import 'dart:convert';

import 'package:dart_jts/dart_jts.dart' as jts;
import 'package:latlong2/latlong.dart';
import 'package:muestreo_parcelas/bd/mixins/polygonal_report.dart';
import 'package:postgres/src/execution_context.dart';

import '../../logic/polygonal.dart';
import '../mixins/crud.dart';
import '../general_query.dart';

class PolygonalDAO extends GeneralQuery
    implements Crud<Polygonal>, IPolygonalReport {
  @override
  Polygonal? instance;

  PolygonalDAO(this.instance);
  // Setter
  set parcelInstance(Polygonal value) {
    instance = value;
  }

  @override
Future<Polygonal> insert() async {
  // Obtiene los puntos y los convierte al formato 'x y'
  List<String> points = instance!.getPoints().map((point) => '${point.latitude} ${point.longitude}').toList();

  // Asegura que el polígono esté cerrado añadiendo el primer punto al final
  points.add(points.first);

  String pointsString = points.join(', ');

  Map<String, dynamic> map = {
    'points': pointsString,
    'region': instance!.getRegion()
  };

  execute(
    query: 'SELECT FROM func_create_polygonal(@points, @region)',
    parameters: map
  );

  return instance!;
}


  @override
  Future<Polygonal> delete() async {
    Map<String, dynamic> map = {'id': instance!.getId()};
    await execute(query: 'SELECT FROM func_delete_polygonal(@id)', parameters: map,isQuery: false);
    return instance!;
  }

@override
Future<Polygonal> read() async {
  Map<String, dynamic> map = {'id': instance!.getId()};
  Map<String, dynamic> res = await execute(
    query: 'SELECT * FROM func_read_polygonal(@id)', 
    parameters: map
  );

  List<int> bytes = base64Decode(res['coords']);
  jts.WKBReader wk = jts.WKBReader();
  jts.Geometry geom = wk.read(bytes);

  if (geom is jts.Polygon) {
    jts.Polygon polygon = geom;
    List<LatLng> latLngPoints = [];

    // Recorre todos los puntos del anillo exterior del polígono
    for (jts.Coordinate coord in polygon.getExteriorRing().getCoordinates()) {
      latLngPoints.add(LatLng(coord.y, coord.x));
    }

    // Asigna la lista de puntos LatLng a tu instancia
    instance!.points = latLngPoints;
  }

  return instance!;
}



  @override
  Future<Polygonal> update(Polygonal parameter) async {
    Map<String, dynamic> map = {
      'id': instance!.getId(),
      'region': parameter.getRegion()
    };
    await execute(
      query: 'SELECT FROM func_update_polygonal(@id, @region)',
      parameters: map,
      isQuery: false
    );
    instance!.region = map['region'];
    return instance!;
  }
  


@override
Future<Map<String, dynamic>> flowerInventroy() async {
  return await execute(
    query: 'SELECT * FROM func_flower_inventroy(@id_polygonal)',
    parameters: {
      'id_polygonal' : instance!.getId(),
    }
  );
}

@override
Future<Map<String, dynamic>> parcelPoints() async {
  return await execute(
    query: 'SELECT * FROM func_parcel_points(@id_polygonal)',
    parameters: {
      'id_polygonal' : instance!.getId(),
    }
  );
}


  
}