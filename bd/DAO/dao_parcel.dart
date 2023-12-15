import '../../logic/parcel.dart';
import '../mixins/crud.dart';
import '../general_query.dart';

class ParcelDAO extends GeneralQuery with Crud<Parcel> {
  
  Parcel? _parcelInstance;

  // Setter
  set parcelInstance(Parcel value) {
    _parcelInstance = value;
  }
  
  @override
  Future<Parcel> delete(String query, bool isQuery, int index) {
    // TODO: implement delete
    throw UnimplementedError();
  }
  
  @override
  Future<Parcel> read(String query, bool isQuery, int index) {
    // TODO: implement read
    throw UnimplementedError();
  }
  
  @override
  Future<void> update(String query, bool isQuery, int index, Parcel parameter) {
    // TODO: implement update
    throw UnimplementedError();
  }
  
  @override
  Future<void> insert(String query, bool isQuery) {
    // TODO: implement insert
    throw UnimplementedError();
  }
}
