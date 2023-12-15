import 'package:flutter/material.dart';
import 'package:muestreo_parcelas/gui/others/themes_aux.dart';
import 'package:muestreo_parcelas/utils/mixins/loading_mixin.dart';

import '../../utils/delete_button.dart';

class NewsPage extends StatelessWidget with LoadingFuture {
  const NewsPage({Key? key}) : super(key: key);

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
              _buildContent(context, snapshot, index),              
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
                Text('Informacion de la parcela',
                    style: buildTextContextWhite(context)),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ));
  }

  Widget _buildContent(
      BuildContext context, AsyncSnapshot<List<String>> snapshot, int index) {
    // Usamos LayoutBuilder para obtener las restricciones del widget padre
    return LayoutBuilder(builder: (context, constraints) {
      // Usamos OrientationBuilder para obtener la orientación de la pantalla
      return OrientationBuilder(builder: (context, orientation) {
        // Si la orientación es horizontal y el ancho máximo es mayor que 600, usamos un layout de dos columnas
        if (orientation == Orientation.landscape && constraints.maxWidth > 600) {
          return Padding(
            padding: const EdgeInsets.only(top: 45),
            child: InkWell(
              onTap: () => jumpParcelContent(context),
              child: Row(
                // Usamos Flexible para asignar una proporción de espacio a cada columna
                children: [
                  Flexible(
                    flex: 2,
                    child: _buildImage(),
                  ),
                  Flexible(
                    flex: 3,
                    child: _buildColumn(context, snapshot, index),
                  ),
                ],
              ),
            ),
          );
        } else {
          // Si la orientación es vertical o el ancho máximo es menor o igual que 600, usamos un layout de una columna
          return Padding(
            padding: const EdgeInsets.only(top:45),
            child: InkWell(
              onTap: () => jumpParcelContent(context),
              child: Column(
                children: [
                  ListTile(
                      title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildImage(),
                      const SizedBox(
                        width: 10,
                      ),
                      _buildColumn(context, snapshot, index),
                    ],
                  )),
                ],
              ),
            ),
          );
        }
      });
    });
  }

  Widget _buildImage() {
    return Stack(
      children: const[
        FadeInImage(
          placeholder: AssetImage('assets/icons/MainIcon.png'),
          image: AssetImage('assets/background/ParcelImage.png'),
          fadeInDuration: Duration(milliseconds: 1),
        ),
        Positioned(
          top: 0,
          left: 0,
          child: Text('11/29/2023',
              style: TextStyle(
                backgroundColor: Color.fromARGB(91, 0, 0, 0),
                color: Colors.white,
              )),
        ),
      ],
    );
  }

  // Añadimos el tipo de retorno Widget y los parámetros context, snapshot e index
Widget _buildColumn(
    BuildContext context, AsyncSnapshot<List<String>> snapshot, int index) {
  // Devolvemos un widget Column con los siguientes hijos
  return Column(
    // Alineamos los hijos al centro del eje transversal
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      // Añadimos un espacio de 10 pixeles de altura
      const SizedBox(
        height: 10,
      ),
      // Añadimos un widget Text con el dato del snapshot en el índice correspondiente
      Text(snapshot.data![index]),
      // Añadimos otro espacio de 10 pixeles de altura
      const SizedBox(
        height: 10,
      ),
      // Añadimos otro widget Text con el prefijo 'sub' y el dato del snapshot en el índice correspondiente
      Text('sub${snapshot.data![index]}'),
      // Añadimos otro espacio de 20 pixeles de altura
      const SizedBox(
        height: 20,
      ),
      // Añadimos un widget FloatingActionButton.extended con un icono de información y una etiqueta de 'Detalles'
      FloatingActionButton.extended(        
        // Usamos un heroTag único para evitar conflictos con otros botones flotantes
        icon: const Icon(Icons.info_outline_rounded,size: 22),
        heroTag: 'message$index',                
        // Usamos la función jumpParcelContent como la función que se ejecutará al presionar el botón
        onPressed: () => jumpParcelContent(context),
        // Usamos un widget Text con el estilo buildTextContextWhite como la etiqueta del botón        
        label: Text('Detalles', style: buildTextContextWhite(context),textAlign: TextAlign.center),        
      ),
      const SizedBox(
        height: 20,
      ),
      DeleteButton(
        buttonSize: 22,
        text: Text('Elimnar',style: buildTextContextWhite(context),),
        title: 'Eliminando parcela',
        prompt: '¿Está seguro que desea eliminar esa parcela?',
        func: (){},//TODO Pendiente eliminar de la BD y eliminar el Card
      )
    ],
  );
}


  void jumpParcelContent(context) {
    //TODO
    //en arguments se deben pasar los id y todos los datos necesarios 
    //para llamar de la base de datos con esa data
    Navigator.pushNamed(context, 'messages',arguments: []);
  }
  Future<List<String>> createFuture() {
    return Future.delayed(const Duration(seconds: 1), () {
      return List<String>.generate(10, (index) => 'Item $index');
    });
  }
}
