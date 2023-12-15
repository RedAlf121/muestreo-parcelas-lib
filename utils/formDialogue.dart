import 'package:flutter/material.dart';
import 'package:muestreo_parcelas/utils/my_dialog.dart';

class FormDialog extends StatefulWidget {
  List<Widget> form;
  String title;
  FormDialog({required this.title,required this.form,super.key});

  @override
  State<FormDialog> createState() => _FormDialogState(title:title,form:form);
}

class _FormDialogState extends State<FormDialog> {
  late List<Widget> form;
  late String title;
  _FormDialogState({required this.form,required title});
  @override
  Widget build(BuildContext context) {
    return MyDialog(
      title: title, 
      prompt: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          children: form,
        ),
      )
    );
  }
}