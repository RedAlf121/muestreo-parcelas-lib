 

import 'package:flutter/material.dart';

void errorSnackBar({required BuildContext context, required String errorMessage}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.redAccent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Text(errorMessage)
      )
    );
  }
  