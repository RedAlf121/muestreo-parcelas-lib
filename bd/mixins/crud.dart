
mixin Crud<T> {  
  Future<void> insert(String query, bool isQuery);
  Future<T> delete(String query, bool isQuery, int index);
  Future<void> update(String query, bool isQuery, int index, T parameter);
  Future<T> read(String query, bool isQuery, int index);
}
