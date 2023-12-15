import 'package:geocore/geocore.dart';
import 'package:muestreo_parcelas/logic/attributes.dart';
import 'package:muestreo_parcelas/logic/plant.dart';
import 'sample_comment.dart';
import 'dart:math';

class Parcel {
  late double _size;
  late DateTime _date;
  late Rectangle<double> _coords;
  late List<Plant>? _plantlist = [];
  late List<SampleComment>? _samplecommentlist = [];
  late List<Attributes>? _attributeslist = [];

  Parcel(
      this._date,
      this._coords,
      this._plantlist,
      this._samplecommentlist,
      this._attributeslist
  ){
    size = _calculateArea(coords); //calcular area usando el atributo coords
  }

  // Getters
  double get size => _size;
  DateTime get date => _date;
  Rectangle<double> get coords => _coords;
  List<Plant>? get plantlist => _plantlist;
  List<SampleComment>? get samplecommentlist => _samplecommentlist;
  List<Attributes>? get attributeslist => _attributeslist;

  // Setters
  set size(double value) {
    _size = value;
  }

  set date(DateTime value) {
    _date = value;
  }

  set coords(Rectangle<double> value) {
    _coords = value;
  }

  set plantlist(List<Plant>? value) {
    _plantlist = value;
  }

  set samplecommentlist(List<SampleComment>? value) {
    _samplecommentlist = value;
  }
  set attributeslist(List<Attributes>? value) {
    _attributeslist = value;
  }
  double _calculateArea(Rectangle<double> coords) {
    double width = _coords.width;
    double height = _coords.height;
    return width*height;
  }
}