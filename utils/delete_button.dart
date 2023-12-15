import 'package:flutter/material.dart';
import 'package:muestreo_parcelas/gui/others/themes_aux.dart';
import 'package:muestreo_parcelas/utils/my_dialog.dart';
int _deleteIndex = 0;
class DeleteButton extends StatelessWidget {
  final String title;
  
  final double? buttonSize;

  final String prompt;

  final Function func;

  final Text? text;

  const DeleteButton({super.key,required this.title,required this.prompt,required this.func, this.text, this.buttonSize});

  @override
  Widget build(BuildContext context) {        
    return FloatingActionButton.extended(
      heroTag: 'delete${_deleteIndex++}',
      onPressed: () async {
        // Muestra un diálogo de confirmación antes de eliminar
        bool? result = await showDialog(          
          context: context,
          builder: buildDialog,
        );
        if (result != null && result) {
          func();
        }
      },
      icon: Icon(Icons.delete,size: buttonSize,),
      label: text ?? const Text(''),
    );
  }

  Widget buildDialog(BuildContext context) {
      return MyDialog(        
        icon: const Icon(Icons.warning_amber),
        iconColor: Colors.amberAccent,
        title: title,
        prompt: Text(prompt),
        actions: actionList(context),
      );
    }

  List<Widget> actionList(BuildContext context) {
    return <Widget>[
      TextButton(
        child: Text('No', style: buildTextContext(context),),
        onPressed: () {
          Navigator.of(context).pop(false);
        },
      ),
      TextButton(
        child: Text('Sí', style: buildTextContext(context),),
        onPressed: () {
          Navigator.of(context).pop(true);
        },
      ),
    ];
  }
}
