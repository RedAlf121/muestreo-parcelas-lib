import 'dart:math';

import 'package:flutter/material.dart';
import 'package:animated_floating_buttons/animated_floating_buttons.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:muestreo_parcelas/gui/map%20pages/custom_slider.dart';
import 'package:muestreo_parcelas/gui/map%20pages/info_form.dart';
import 'package:muestreo_parcelas/gui/map%20pages/parcel_form.dart';
import 'package:muestreo_parcelas/gui/map%20pages/plant_form.dart';
import 'package:muestreo_parcelas/utils/text_box.dart';

import '../../utils/IndexWidget.dart';
import 'general_form.dart';
import 'polygonal_form.dart';

enum Types { plant, parcel, polygonal }

// Definir una clase con el nombre que quieras
class MarkerStorage {
  // Usar el guión bajo (_) para hacer los atributos privados
  bool _editing = false;

  late Widget _cancelButton;
  late Widget _creationButton;
  late void Function(VoidCallback fn) _state;
  Types? _selectedMarker;

  Map<Types, Widget> _markers = {};

  final Map<Types, List> _markersLayer = {
    Types.plant: [],
    Types.parcel: [],
    Types.polygonal: [],
  };

  List<Widget> _adminButtons = [];
  List<Marker> auxiliarPoints = [];
  List<Marker> editPoints = [];

  // Usar el constructor para inicializar los atributos
  MarkerStorage(context, void Function(VoidCallback fn) setState) {
    _state = setState;
    _adminButtons = _createAdminButtons(context);
    _markers = _default_button_markers;
    _creationButton = _createAddButtons(context);
    _cancelButton = _createCancelButton(context);
  }

  FloatingActionButton _createCancelButton(context) {
    return FloatingActionButton(
      heroTag: 'cancel',
      onPressed: () {
        _state(() {
          auxiliarPoints.clear();
          _restore(context);
        });
      },
      backgroundColor: const Color.fromARGB(255, 206, 15, 28),
      child: const Icon(Icons.cancel_outlined),
    );
  }

  // Usar los métodos get y set para acceder y modificar los atributos
  // Los métodos get y set son públicos por defecto

  set editing(bool value) => _editing = value;
  set selectedMarker(Types? value) => _selectedMarker = value;
  set markers(Map<Types, Widget> value) => _markers = value;
  bool get editing => _editing;
  Types? get selectedMarker => _selectedMarker;
  Map<Types, Widget> get markers => _markers;
  Map<Types, List> get markersLayer => _markersLayer;

  // Los demás métodos y atributos se mantienen igual
  IconButton _plantButton() {
    return IconButton(
      // Widget que se mostrará como icono
      icon: const Icon(Icons.local_florist), // Icono de planta
      color: Colors.pink, // Color del icono
      onPressed: () {
        // Acción al presionar el icono
        // Mostrar un diálogo con opciones para la planta
      },
    );
  }

  IconButton _parcelButton() {
    return IconButton(
      // Widget que se mostrará como icono
      icon: const Icon(Icons.crop_square), // Icono de parcela
      color: Colors.green, // Color del icono
      onPressed: () {
        // Acción al presionar el icono
        // Mostrar un diálogo con opciones para la parcela
      },
    );
  }

  IconButton _polygonButton() {
    return IconButton(
      // Widget que se mostrará como icono
      icon: const Icon(Icons.hexagon_outlined),
      color: Colors.blue, // Color del icono
      onPressed: () {
        // Acción al presionar el icono
        // Mostrar un diálogo con opciones para la poligonal
      },
    );
  }

  Map<Types, Widget> get _default_button_markers {
    return {
      // Crear un Marker para una poligonal
      Types.polygonal: _polygonButton(),
      // Crear un Marker para una parcela
      Types.parcel: _parcelButton(),
      // Crear un Marker para una planta
      Types.plant: _plantButton()
    };
  }

  Row createFloatingButtons(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          heroTag: 'location',
          onPressed: () => _state(() {}),
          child: const Icon(Icons.gps_not_fixed_outlined),
        ),
        (editing)
            ? _cancelButton
            : const SizedBox.square(
                dimension: 5,
              ),
        _creationButton,
      ],
    );
  }

  AnimatedFloatingActionButton _createAddButtons(BuildContext context) {
    return AnimatedFloatingActionButton(
      colorStartAnimation: const Color.fromARGB(255, 82, 183, 136),
      animatedIconData: AnimatedIcons.add_event,
      fabButtons: _adminButtons,
    );
  }

  void _selectMarker(context, Types selection) {
    _editing = true;
    _selectedMarker = selection;
    _creationButton = _createCheckButton(context);
  }

  List<Widget> _createAdminButtons(context) {
    return [
      FloatingActionButton(
        heroTag: 'polygonal',
        onPressed: () {
          _state(() {
            _selectMarker(context, Types.polygonal);
          });
        },
        child: const Icon(Icons.hexagon_outlined),
      ),
      FloatingActionButton(
        heroTag: 'sample',
        onPressed: () {
          _state(() {
            _selectMarker(context, Types.parcel);
          });
        },
        child: const Icon(Icons.crop_square),
      )
    ];
  }

  void addAuxiliarPoint(LatLng position) {
    Marker tapMarker = Marker(
      point: position,
      builder: (context) => markers[selectedMarker]!,
    );
    auxiliarPoints.add(tapMarker);
  }

  Widget _createCheckButton(context) {
    return FloatingActionButton(
      onPressed: () {
        _state(() {
          Icon pointIcon = (auxiliarPoints.first.builder(context) as IconButton)
              .icon as Icon;
          addShape(pointIcon);
          _restore(context);
        });
      },
      child: const Icon(Icons.check_circle_outline_rounded),
    );
  }

  void addShape(Icon pointIcon) {
    //Buscamos el primero que coincida en el icono, si estoy usando iconos de parcelas que aparezca de mis llaves en el mapa de botones
    Icon markIcon;
    Types typeMark = markers.keys.firstWhere((element) {
      markIcon = (markers[element] as IconButton).icon as Icon;
      return pointIcon.icon == markIcon.icon;
    });
    switch (typeMark) {
      case Types.polygonal:
        markersLayer[typeMark]!.add(Polygon(
            borderStrokeWidth: 10,
            borderColor: Colors.blueAccent,
            points: auxiliarPoints
                .map((e) => e.point)
                .toList())); //convertimos la lista auxiliar en un poligono y lo añadimos al mapa correspondiente
        break;
      case Types.parcel:
        markersLayer[typeMark]!.add(Polygon(
            borderStrokeWidth: 10,
            borderColor: Colors.greenAccent,
            points: [
              auxiliarPoints.first.point, //x1,y1
              LatLng(auxiliarPoints.last.point.latitude,
                  auxiliarPoints.first.point.longitude), //x2,y1
              auxiliarPoints.last.point, //x2,y2
              LatLng(auxiliarPoints.first.point.latitude,
                  auxiliarPoints.last.point.longitude), //x1,y2
            ]));
        break;
      default:
        markersLayer[typeMark]!.add(auxiliarPoints.first);
        break;
    }
    //Insertar a la base de datos
    editPoints.add(Marker(
      point: auxiliarPoints.first.point,
      builder: (context) {
        final selectedForm = selectForm(typeMark, context);
        return IndexWidget(
          indexes: [Random().nextInt(10)],
          form: [InfoForm(form: selectedForm, indexes: [],exportButtons: _createExportButtons(selectedForm),)],
          editing: typeMark.name,
          child: pointIcon,
          actions: [
            TextButton(onPressed: ()=>Navigator.of(context).pop(), child: const Text('Cancelar')),
            TextButton(onPressed: (){selectedForm.sendData();}, child: const Text('Aceptar')),
          ],
        );
      },
    ));
  }

  void _restore(context) {
    auxiliarPoints.clear();
    _creationButton = _createAddButtons(context);
    editing = false;
  }

  GeneralForm selectForm(Types typeMark, context) {
    GeneralForm form;
    List<Widget> fields;
    switch (typeMark) {
      case Types.polygonal:
        fields = [
          ValidatedText.namedTextBox(            
            context: context, 
            controller: TextEditingController(),
            labelText: 'Región'
          )
        ];
        form = PolygonalForm(
          indexes: [],
          components: fields,
        );
        break;
      case Types.parcel:
        fields = _parcelFields(context);
        form = ParcelForm(
          indexes: [],
          components: fields,
        );
        break;
      default:
        fields = _createPlantButtons();
        form = PlantForm(
          indexes: [],
          components: fields,
        );
    }
    return form;
  }

  List<Widget> _parcelFields(context) {
    const sizedBox = SizedBox(height: 30,);
    return [
      sizedBox,
      CustomSlider(
        min: 1,
        max: 100,
        divisions: 99,
        label: 'Contenido de materia orgánica',
      ),

      sizedBox,

      CustomSlider(
        min: 0,
        max: 25,
        divisions: 5,
        label: 'Pedregosidad',
      ),

      sizedBox,

      DropdownButtonFormField(
        onChanged: (value) {},
        items: ['50', '40', '30', '20', '10'].map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        decoration: const InputDecoration(
          labelText: 'Profundidad del suelo',
          border: OutlineInputBorder(),
        ),
      ),

      sizedBox,    

      CustomSlider(
        min: 0,
        max: 100,
        divisions: 20,
        label: 'Erosión',
      ),
      
      sizedBox,

      CustomSlider(
        min: 0,
        max: 100,
        divisions: 20,
        label: 'Pendiente',
      ),

      sizedBox,


      CustomSlider(
        min: 0,
        max: 800,
        divisions: 160,
        label: 'Precipitaciones',
      ),

      sizedBox,


      CustomSlider(
        min: 0,
        max: 100,
        divisions: 20,
        label: 'Cobertura vegetal',
      ),

      sizedBox,


      DropdownButtonFormField(
        onChanged: (value) {},
        items: ['bueno', 'regular', 'malo'].map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        decoration: const InputDecoration(
          labelText: 'Estado de vegetación',
          border: OutlineInputBorder(),
        ),
      ),

      sizedBox,

      
      DropdownButtonFormField(
        onChanged: (value) {},
        items:
            ['con problemas', 'aceptable', 'sin problemas'].map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        decoration: const InputDecoration(
          labelText: 'Relación con futura plantación',
          border: OutlineInputBorder(),
        ),
      ),
    ];
  }
  
  List<Widget>? _createExportButtons(GeneralForm selectedForm) {
    List<Widget>? list;
    if(selectedForm is PolygonalForm){
      list = [
        FloatingActionButton.extended(
          icon: Icon(Icons.inventory_2_outlined),
          heroTag: 'Inventario Floristico',
          onPressed: (){},
          label: Text('Inventario Floristico'),
        ),
        SizedBox(height: 10,),
        FloatingActionButton.extended(
          icon: Icon(Icons.scoreboard_outlined),
          heroTag: 'Puntaje por Parcela',
          onPressed: (){},
          label: Text('Puntaje por Parcela'),
        ),        
      ];
    }else if(selectedForm is ParcelForm){
      list = [
        FloatingActionButton.extended(
          heroTag: 'Conteo por especies',
          onPressed: (){},
          label: Text('Conteo por especies'),
          icon: Icon(Icons.type_specimen_outlined),
        ),
        SizedBox(height: 10,),
        FloatingActionButton.extended(
          icon: Icon(Icons.polyline_outlined),
          heroTag: 'Distancia de cada árbol',
          onPressed: (){},
          label: Text('Distancia de cada árbol'),
        )
      ];
    }
    return list;
  }
  
  List<Widget> _createPlantButtons() {
    const sizedBox = SizedBox(height: 30,);
    return [
      sizedBox,
      CustomSlider(
        min: 1,
        max: 100,
        divisions: 99,
        label: 'Contenido de materia orgánica',
      ),

      sizedBox,

      CustomSlider(
        min: 0,
        max: 25,
        divisions: 5,
        label: 'Pedregosidad',
      ),

      sizedBox,

      DropdownButtonFormField(
        onChanged: (value) {},
        items: ['50', '40', '30', '20', '10'].map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        decoration: const InputDecoration(
          labelText: 'Profundidad del suelo',
          border: OutlineInputBorder(),
        ),
      ),

      sizedBox,    

      CustomSlider(
        min: 0,
        max: 100,
        divisions: 20,
        label: 'Erosión',
      ),
      
      sizedBox,

      CustomSlider(
        min: 0,
        max: 100,
        divisions: 20,
        label: 'Pendiente',
      ),

      sizedBox,


      CustomSlider(
        min: 0,
        max: 800,
        divisions: 160,
        label: 'Precipitaciones',
      ),

      sizedBox,


      InputDecorator(
        decoration: InputDecoration(          
          contentPadding: EdgeInsets.symmetric(vertical: 5.0),
          labelText: 'Contenido de materia orgánica',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20)
          ),
        ),
        child: Slider(
          value: 0,
          min: 0,
          max: 100,
          divisions: 20,
          label: 'Cobertura vegetal',
          onChanged: (double value) {},
          activeColor: Colors.green,
          inactiveColor: Colors.green.withOpacity(0.3),
        ),
      ),

      SizedBox(height: 10,),


      DropdownButtonFormField(
        onChanged: (value) {},
        items: ['bueno', 'regular', 'malo'].map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        decoration: const InputDecoration(
          labelText: 'Estado de vegetación',
          border: OutlineInputBorder(),
        ),
      ),

      SizedBox(height: 10,),

      
      DropdownButtonFormField(
        onChanged: (value) {},
        items:
            ['con problemas', 'aceptable', 'sin problemas'].map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        decoration: const InputDecoration(
          labelText: 'Relación con futura plantación',
          border: OutlineInputBorder(),
        ),
      ),
    ];
  }



}
