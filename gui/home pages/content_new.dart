import 'package:flutter/material.dart';
import '../../utils/delete_button.dart';
import '../others/themes_aux.dart';

class ContentNew extends StatelessWidget {
  final List<int> indexes;
  final AsyncSnapshot<List> snap;
  final int index;
  final void Function(VoidCallback) state;
  const ContentNew({super.key, required this.indexes, required this.snap, required this.index, required this.state});

  @override
  Widget build(BuildContext context) {
    return _buildContent(context, snap, index);
  }

  Widget _buildContent(
      BuildContext context, AsyncSnapshot<List> snapshot, int index) {
    
    return Padding(
      padding: const EdgeInsets.only(top: 45),
      child: InkWell(
        onTap: () {
          jumpParcelContent(context);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          // Usamos Flexible para asignar una proporción de espacio a cada columna
          children: [
            _buildImage(),
            _buildColumn(context, snap, index),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    return Stack(
      children: const [
        FadeInImage(
          placeholder: AssetImage('assets/icons/MainIcon.png'),
          image: AssetImage('assets/background/ParcelImage.png'),
          fadeInDuration: Duration(milliseconds: 1),
        ),
        Positioned(
          top: 0,
          left: 0,
          child: Text('11/29/2023', //TODO poner la fecha real
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
      BuildContext context, AsyncSnapshot<List> snapshot, int index) {
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
        Text(snapshot.data![index],
            style: TextStyle(
                color: (Theme.of(context).brightness == Brightness.dark)
                    ? Colors.white
                    : Colors.black)),
        // Añadimos otro espacio de 10 pixeles de altura
        const SizedBox(
          height: 10,
        ),
        // Añadimos otro widget Text con el prefijo 'sub' y el dato del snapshot en el índice correspondiente
        Text(
          'sub${snapshot.data![index]}',
          style: TextStyle(
              color: (Theme.of(context).brightness == Brightness.dark)
                  ? Colors.white
                  : Colors.black),
        ),
        // Añadimos otro espacio de 20 pixeles de altura
        const SizedBox(
          height: 20,
        ),
        // Añadimos un widget FloatingActionButton.extended con un icono de información y una etiqueta de 'Detalles'
        FloatingActionButton.extended(
          // Usamos un heroTag único para evitar conflictos con otros botones flotantes
          icon: const Icon(Icons.info_outline_rounded, size: 22),
          heroTag: 'message$index',
          // Usamos la función jumpParcelContent como la función que se ejecutará al presionar el botón
          onPressed: () => jumpParcelContent(context),
          // Usamos un widget Text con el estilo buildTextContextWhite como la etiqueta del botón
          label: Text('Detalles',
              style: buildTextContextWhite(context),
              textAlign: TextAlign.center),
        ),
        const SizedBox(
          height: 20,
        ),
        DeleteButton(
          buttonSize: 22,
          text: Text(
            'Elimnar',
            style: buildTextContextWhite(context),
          ),
          title: 'Eliminando parcela',
          prompt: '¿Está seguro que desea eliminar esa parcela?',
          func: () {
            //Elimno de la bd
            state((){});
          }, //TODO Pendiente eliminar de la BD y eliminar el Card
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  void jumpParcelContent(BuildContext context) {
    //TODO
    //en arguments se deben pasar los id y todos los datos necesarios
    //para llamar de la base de datos con esa data
    print(indexes);
    Navigator.pushNamed(context, 'messages', arguments: []);
  }
}