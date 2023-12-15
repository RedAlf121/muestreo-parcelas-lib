import 'dart:math';
import 'package:muestreo_parcelas/logic/parcel.dart';

class Polygonal {
  int _id;
  List<Point> _points;
  List<Parcel> _parcellist;

  Polygonal(this._id, this._points, this._parcellist);

  //Getters
  int getId() {
    return _id;
  }

  List<Point> getPoints() {
    return _points;
  }

  List<Parcel> getParcellist() {
    return _parcellist;
  }

  void setParcellist(List<Parcel> parcellist) {
    _parcellist = parcellist;
  }
  // Función que calcula el área de un polígono dado un arreglo de sus vértices
double area(){
  double area = 0;
  int n = _points.length;
  // Se aplica la fórmula del área de Gauss
  for (int i = 0; i < n; i++) {
    int j = (i + 1) % n; // Índice del vértice siguiente
    int k = (i - 1) % n; // Índice del vértice anterior
    // Se suma el producto cruz de los vértices
    area += _points[i].x * (_points[j].y - _points[k].y);
  }
  // Se divide entre dos y se toma el valor absoluto
  area = (area / 2).abs();
  return area;
}

}
