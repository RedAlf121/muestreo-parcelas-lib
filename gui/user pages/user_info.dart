import 'package:flutter/material.dart';
import 'package:muestreo_parcelas/gui/others/themes_aux.dart';
import 'package:muestreo_parcelas/utils/mixins/field_validate.dart';
import 'package:muestreo_parcelas/utils/mixins/loading_mixin.dart';
import '../../utils/formDialogue.dart';
import '../../utils/mixins/named_app_bar_mixin.dart';
import '../../utils/text_box.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({super.key});

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> with NamedAppBar, LoadingFuture, FieldValidate {
  final _firstNameController = TextEditingController();

  final _lastNameController = TextEditingController();  

  final _usernameController = TextEditingController();

  final _passwordController = TextEditingController();

  final softBorder = RoundedRectangleBorder(borderRadius: BorderRadius.circular(30));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createAppBar(
          context: context,
          text: Text(
            'Usuario',
            style: buildTextContext(context),
          )),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        children: [
          FutureBuilder(
            builder: (context, snapshot) => buildContent(
              context: context, 
              snapshot: snapshot, 
              contentWidget: _createUserProfileCard(context)
            ),
          )
        ],
      ),
    );
  }

  _createUserProfileCard(context) {
    const separation = SizedBox(
      height: 20,
    );
    
    return Card(
      shape: softBorder,
      child: Container(
        padding: const EdgeInsets.only(bottom: 180),
        decoration: background(),
        child: foreground(context, separation),
      ),
    );
  }

  Widget foreground(context, SizedBox separation) {
    double? iconSize = 20;
    Color? iconColor = Colors.white;
    return Stack(
      children: [
        Positioned(
          top:0,
          left:15,
          child: Card(
            color: Colors.black,          
            elevation: 0,
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(left: Radius.circular(20))),            
            child: Row(              
              children: [
                const SizedBox(width: 10,),
                (isAdmin())? Text('Administrador', style: buildTextContextWhite(context)) : Text('Observador', style: buildTextContextWhite(context)),
                const SizedBox(width: 10,),
                (isAdmin())? Icon(Icons.shield_outlined, color: iconColor, size: iconSize,) : Icon(Icons.remove_red_eye_outlined, color: iconColor, size: iconSize,)
              ],
            ),
          ),
        ),
        Positioned(
          top:0,
          right:0,
          child: Material(
            color: Colors.transparent,
            child: IconButton(
              onPressed: (){
                showDialog(
                  context: context, 
                  builder: buildFormDialog
                );
              }, 
              icon: const Icon(Icons.edit),
              color: Colors.white,
              iconSize: 40,
              splashRadius: 30,
            ),
          )
        ),
        Container(
          padding: const EdgeInsets.only(top: 35),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [userAvatar(), userInfo(context, separation)],
          ),
        ),
      ],
    );
  }

  BoxDecoration background() {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        image: const DecorationImage(
          image: AssetImage('assets/background/msg1024952269-168440.jpg'),
          fit: BoxFit.fill,
        ));
  }

  Widget userAvatar() {
    return Stack(
      children: const[
        CircleAvatar(
          minRadius: 50,
          child: FadeInImage(
            image: AssetImage('assets/background/user.png'),
            placeholder: AssetImage('assets/background/user.png'),
          ),
        ),        
      ],
    );
  }

  Widget userInfo(context, SizedBox separation) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Column(
        children: [
          Text(
            'Aqui va el nombre del usuario',
            style: buildTextContextWhite(context),
          ),
          separation,
          Text(
            'Nombre',
            style: buildTextContextWhite(context),
          ),
          separation,
          Text(
            'Apellidos',
            style: buildTextContextWhite(context),
          ),
        ],
      ),
    );
  }

  bool isAdmin() {
    //TODO verificar si es admin o no
    return true;
  }

  Widget buildFormDialog(BuildContext context) {
    const sizedBox = SizedBox(height: 10);
    return FormDialog(    
      title: 'Editar usuario', 
      form: [
        ValidatedText.namedTextBox(
            context: context,            
            controller: _firstNameController,
            labelText: 'Nombre',
          ),
          sizedBox,        
          ValidatedText.namedTextBox(
            context: context,
            controller: _lastNameController,
            labelText: 'Apellidos',
          ),
          sizedBox,
          ValidatedText.requiredTextBox(
            context: context,
            controller: _usernameController,
            labelText: 'Nombre de Usuario',
          ),
          sizedBox,
          ValidatedText.passwordTextBox(
            context: context,
            controller: _passwordController,
            labelText: 'Contraseña',            
          ),
      ],
      );
  }
}
