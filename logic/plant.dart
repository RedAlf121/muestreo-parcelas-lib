import 'dart:math';
import 'package:latlong2/latlong.dart';
import 'package:muestreo_parcelas/logic/plant_comment.dart';

class Plant {
  String _stratum;
  double _height;
  double _shaftheight;
  LatLng _position;
  double _ewdiameter;
  double _nsdiameter;
  String _specie;
  List<PlantComment> _plantcommentlist;
  Plant(this._stratum, this._height, this._shaftheight, this._position,
      this._ewdiameter, this._nsdiameter, this._specie, this._plantcommentlist);

  //Getters
  String get stratum {
    return _stratum;
  }

  double get height {
    return _height;
  }

  double get shaftHeight {
    return _shaftheight;
  }

  LatLng get position {
    return _position;
  }

  double get ewdiamter {
    return _ewdiameter;
  }

  double getNsdiameter() {
    return _nsdiameter;
  }

  String getSpecie() {
    return _specie;
  }

  List<PlantComment> getPlantcommentlist() {
    return _plantcommentlist;
  }

  //Setters

  void setStratum(String stratum) {
    _stratum = stratum;
  }

  void setHeight(double height) {
    _height = height;
  }

  void setShaftHeight(double shaftheight) {
    _shaftheight = shaftheight;
  }

  void set position(LatLng pos) {
    _position = pos;
  }

  set ewdiamter(double ewdiameter) {
    _ewdiameter = ewdiameter;
  }

  set nsdiameter(double nsdiameter) {
    _nsdiameter = nsdiameter;
  }

  set specie(String specie) {
    _specie = specie;
  }

  set plantCommentList(List<PlantComment> list) {
    _plantcommentlist = list;
  }

}
