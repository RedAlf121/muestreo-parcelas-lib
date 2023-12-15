import 'package:flutter/material.dart';

import '../gui/others/themes_aux.dart';

class MyDialog extends StatelessWidget {
  
  final RoundedRectangleBorder? borderShape;
  final Color? iconColor;
  final Icon? icon;
  final String title;
  final Widget prompt;
  final List<Widget>? actions;

  
  const MyDialog({super.key,required this.title,required this.prompt,this.icon,this.iconColor,this.actions, this.borderShape});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(        
        shape: _choose(borderShape,defaultBorderShape) as ShapeBorder?,
        icon: _choose(icon,defaultIcon) as Icon,
        iconColor: iconColor,
        title: Text(title),
        content: prompt,
        actions: _choose(actions,()=>defaultTextButton(context)) as List<Widget>,
      );
  }
  
  Object? _choose(Object? value, Object Function() defaultValue){
    return (value != null)? value : defaultValue();
  }

  RoundedRectangleBorder defaultBorderShape() => RoundedRectangleBorder(borderRadius: BorderRadius.circular(30));

  Icon defaultIcon(){
    return const Icon(Icons.info_outline);
  }

  List<Widget> defaultTextButton(context){
    return [
      TextButton(
        child: Text('Aceptar', style: buildTextContext(context),),
        onPressed: () => Navigator.of(context).pop(true),
      )
    ];
  }
}