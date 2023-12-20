
import 'package:flutter/material.dart';

import 'formDialogue.dart';
import 'my_dialog.dart';

class IndexFormDialog extends FormDialog{
  List<int> indexes;
  IndexFormDialog({super.key, required super.title, required super.form, required this.indexes, List<Widget>? actions});
   @override
  State<FormDialog> createState() => IndexFormDialogState();  

}

class IndexFormDialogState extends State<IndexFormDialog>{
  
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
            children: widget.form,
          ),
        ),
      )
    );
  }

}