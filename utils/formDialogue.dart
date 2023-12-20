import 'package:flutter/material.dart';
import 'package:muestreo_parcelas/utils/my_dialog.dart';

class FormDialog extends StatefulWidget {
  List<Widget> form = [];
  String title = '';
  List<Widget>? actions;
  Icon? icon;
  FormDialog({required this.title,required this.form,super.key, this.actions,this.icon});

  @override
  State<FormDialog> createState() => _FormDialogState();
}

class _FormDialogState extends State<FormDialog> {
  _FormDialogState();
  @override
  Widget build(BuildContext context) {
    return MyDialog(
      actions: widget.actions,
      icon: widget.icon ?? const Icon(Icons.edit_note_rounded),
      title: widget.title, 
      prompt: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: SingleChildScrollView(
          child: Column(
            children:widget.form,
          ),
        ),
      )
    );
  }
}