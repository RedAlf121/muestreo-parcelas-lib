import '../../logic/polygonal.dart';
import '../mixins/crud.dart';
import '../general_query.dart';

class PolygonalDAO extends GeneralQuery with Crud<Polygonal> {
  Polygonal? _parcelInstance;

  // Setter
  set parcelInstance(Polygonal value) {
    _parcelInstance = value;
  }
  @override
  Future<int> insert(String query, bool isQuery) {
    return Future.value(0);
  }
  
  @override
  Future<Polygonal> delete(String query, bool isQuery, int index) {
    // TODO: implement delete
    throw UnimplementedError();
  }
  
  @override
  Future<Polygonal> read(String query, bool isQuery, int index) {
    // TODO: implement read
    throw UnimplementedError();
  }
  
  @override
  Future<void> update(String query, bool isQuery, int index, Polygonal parameter) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
