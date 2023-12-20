import 'package:muestreo_parcelas/bd/mixins/logic_instance.dart';

abstract class Crud<T> extends LogicInstance<T>{
  Future<T> insert();//devuelve la instancia creada
  Future<T> delete();//devuelve la instancia eliminada
  Future<T> update(T parameter);//devuelve la instancia modificada
  Future<T> read();//devuelve la instancia leida
}
