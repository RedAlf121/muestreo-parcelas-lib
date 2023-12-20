
import 'package:muestreo_parcelas/bd/mixins/sampling_reports.dart';

import '../general_query.dart';

class SamplingDAO extends GeneralQuery implements SamplingReports{
  @override
  Future<Map<String, dynamic>> allParcels()async => await execute(query: 'SELECT * FROM func_all_parcels');

  @override
  Future<Map<String, dynamic>> allPlants()async => await execute(query: 'SELECT * FROM func_all_plants');

  @override
  Future<Map<String, dynamic>> allPolygonals()async => await execute(query: 'SELECT * FROM func_all_polygonals');

}