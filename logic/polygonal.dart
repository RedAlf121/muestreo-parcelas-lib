import 'package:latlong2/latlong.dart';
import 'package:muestreo_parcelas/logic/parcel.dart';

class Polygonal {
  int? id;
  List<LatLng>? points = [];
  final List<Parcel> parcellist = [];
  String? region;

  Polygonal({this.id, this.points,this.region});

  //Setters
  void setId(int id) {
    this.id = id;
  }
  Parcel findParcel(int id){
    return parcellist.firstWhere((element) => element.idSample == id);
  }
  void addParcel(Parcel parcel) => parcellist.add(parcel);

  //Getters
  int getId() {
    return id!;
  }

  String getRegion() {
    return region!;
  }

  List<LatLng> getPoints() {
    return points!;
  }

  List<Parcel> getParcellist() {
    return parcellist;
  }

  // Función que calcula el área de un polígono dado un arreglo de sus vértices
  double area() {
    double area = 0;
    int n = points!.length;
    // Se aplica la fórmula del área de Gauss
    for (int i = 0; i < n; i++) {
      int j = (i + 1) % n; // Índice del vértice siguiente
      int k = (i - 1) % n; // Índice del vértice anterior
      // Se suma el producto cruz de los vértices
      area += points![i].latitude *
          (points![j].longitude - points![k].longitude);
    }
    // Se divide entre dos y se toma el valor absoluto
    area = (area / 2).abs();
    return area;
  }
}
