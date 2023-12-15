
import 'dart:convert';

final _map = _createJsonMap();

Map<String,String> _createJsonMap(){
  final map = jsonDecode('lib/utils/db_data.json');  
  return map['myDB'];
}


String get(String component){
  return _map[component]!;
}