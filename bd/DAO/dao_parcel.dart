import 'dart:convert';
import 'dart:math' as math;

import 'package:dart_jts/dart_jts.dart' as jts;
import 'package:muestreo_parcelas/bd/mixins/parcel_report.dart';
import '../../logic/parcel.dart';
import '../mixins/crud.dart';
import '../general_query.dart';

class ParcelDAO extends GeneralQuery implements Crud<Parcel>, IParcelReport {
  @override
  Parcel? instance;

  ParcelDAO(this.instance);
  // Setter
  set parcelInstance(Parcel value) {
    instance = value;
  }

  @override
  Future<Parcel> delete() async {
    Map<String, dynamic> map = {
      'id_polygonal': instance!.idPolygonal,
      'id_sample': instance!.idSample,
    };
    execute(
        query: 'SELECT FROM func_delete_parcel(@id_polygonal, @id_sample)',
        parameters: map);
    return instance!;
  }

  @override
  Future<Parcel> read() async {
    Map<String, dynamic> map = {
      'id_polygonal': instance!.idPolygonal,
      'id_sample': instance!.idSample,
    };
    Map<String, dynamic> res = await execute(
      query: 'SELECT * FROM func_read_parcel(@id_polygonal, @id_sample)',
      parameters: map
    );
    instance!.date = res['date'];
    instance!.idUser = res['id_user'];
    List<int> bytes = base64Decode(res['coords']);
    jts.WKBReader wk = jts.WKBReader();
    jts.Geometry geom = wk.read(bytes);

    if (geom is jts.Polygon) {
      jts.Polygon polygon = geom;
      // Suponiendo que el polígono es un rectángulo, puedes obtener los puntos extremos
      jts.Point lowerLeft = polygon.getExteriorRing().getPointN(0);
      jts.Point upperRight = polygon.getExteriorRing().getPointN(2);
      instance!.coords = math.Rectangle.fromPoints(math.Point(lowerLeft.getX(), lowerLeft.getY()), math.Point(upperRight.getX(), upperRight.getY()));
    } 
    return instance!;
  }

  @override 
  
  Future<Parcel> update(Parcel parameter) async {    
    throw UnimplementedError();//implementación a futuro de momento no es necesaria
  }

  @override
  Future<Parcel> insert() async {
    execute(
      query:
        'SELECT FROM func_create_parcel(@id_polygonal, @user_id, ST_MAKE_POINT(@point1::geography),ST_MAKE_POINT(@point1::geography))',
      parameters: {
        'id_polygonal' : instance!.idPolygonal,
        'user_id' : instance!.idUser,
        'point1' : '(${instance!.coords.topLeft.x},${instance!.coords.topLeft.y})',
        'point2' : '(${instance!.coords.bottomRight.x},${instance!.coords.bottomRight.y})'
      },
      isQuery: true
    );
    return instance!;
  }

    @override
Future<Map<String, dynamic>> countByStatrum() async {
  return await execute(
    query: 'SELECT * FROM func_species_count(@id_polygonal,@id_parcel)',
    parameters: {
      'id_polygonal' : instance!.idPolygonal,
      'id_parcel' : instance!.idSample
    }
  );
}
  
  @override
  Future<Map<String,dynamic>> treeDistance() async {
    return await execute(
      query: 'SELECT * FROM func_tree_distance(@id_polygonal,@id_parcel)',
      parameters: {
        'id_polygonal' : instance!.idPolygonal,
        'id_parcel' : instance!.idSample
      }
    );
  }
}
