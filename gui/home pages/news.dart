import 'dart:math';

import 'package:flutter/material.dart';
import 'package:muestreo_parcelas/gui/home%20pages/content_new.dart';
import 'package:muestreo_parcelas/gui/others/themes_aux.dart';
import 'package:muestreo_parcelas/utils/IndexWidget.dart';
import 'package:muestreo_parcelas/utils/mixins/loading_mixin.dart';

import '../../utils/delete_button.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> with LoadingFuture {
  @override
  Widget build(BuildContext context) {
    // Usamos MediaQuery para obtener el ancho de la pantalla
    final screenWidth = MediaQuery.of(context).size.width;
    // Usamos un valor relativo para el padding horizontal, en este caso el 10% del ancho de la pantalla
    final horizontalPadding = screenWidth * 0.03;
    return FutureBuilder<List<String>>(
      future: createFuture(),
      builder: (context, snapshot) => buildContent(
          context: context,
          snapshot: snapshot,
          contentWidget: Container(
              // Usamos el padding horizontal calculado y un padding vertical fijo de 20
              padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding, vertical: 20),
              child: _createListView(snapshot))),
    );
  }

  ListView _createListView(AsyncSnapshot<List<String>> snapshot) {
    return ListView.builder(
      itemCount: snapshot.data?.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        return Container(
            // Usamos un padding fijo de 10 para el bottom
            padding: const EdgeInsets.only(bottom: 10),
            child: _createCard(context, snapshot, index));
      },
    );
  }

  Widget _createCard(context, AsyncSnapshot<List<String>> snapshot, int index) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        borderOnForeground: true,
        child: Center(
          child: Stack(
            children: [
              _buildTopContainer(context),
              ContentNew(snap: snapshot, index: index, indexes: [Random().nextInt(10)],state: setState),
            ],
          ),
        ));
  }

  Widget _buildTopContainer(BuildContext context) {
    return Positioned(
        top: 0,
        left: 0,
        right: 0,
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          child: Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 52, 161, 108),
            ),
            child: Column(
              children: [
                const SizedBox(height: 10),
                SelectableText('Informacion de la parcela',
                    style: buildTextContextWhite(context)),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ));
  }

  Future<List<String>> createFuture() {
    return Future.delayed(const Duration(seconds: 1), () {
      return List<String>.generate(10, (index) => 'Item $index');
    });
  }
}
