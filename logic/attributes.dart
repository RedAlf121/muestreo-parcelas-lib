
class Attributes {
  String _attribute;
  String _characteristic;
  int _value;

  Attributes(this._attribute, this._characteristic, this._value);

  //Getters
  String get attribute => _attribute;

  String get characteristic => _characteristic;

  int get value => _value;

  //Setters
  set attribute(String attribute) {
    _attribute = attribute;
  }

  set characteristic(String characteristic) {
    _characteristic = characteristic;
  }

  set value(int value) {
    _value = value;
  }  
 
}
