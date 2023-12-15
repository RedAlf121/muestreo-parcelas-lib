

import 'package:flutter/material.dart';

mixin LoadingFuture{
  Widget buildContent({required BuildContext context, required AsyncSnapshot<dynamic> snapshot, required Widget contentWidget}) {
      late Widget content;
      if (snapshot.connectionState == ConnectionState.waiting) {
        content = const Center(
            child: CircularProgressIndicator(
          color: Colors.greenAccent,
        ));
      } else {
        if (snapshot.hasError) {
          content = Center(child: Text('Error: ${snapshot.error}'));
        } else {
          content = contentWidget;
        }
      }
      return content;
    }
}