import 'package:flutter/material.dart';

abstract class GeneralForm extends StatelessWidget {
  List<int> indexes;
  List<Widget> components;
  GeneralForm({super.key, required this.indexes,required this.components});
  void sendData();
}