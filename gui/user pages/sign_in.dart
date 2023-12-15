
import 'package:flutter/material.dart';
import 'package:muestreo_parcelas/utils/text_box.dart';
import '../../utils/error_snackbar.dart';
import '../../utils/mixins/field_validate.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  SignInState createState() => SignInState();
}

class SignInState extends State<SignIn> with FieldValidate {
  
  //TODO agregar tambien una componente para escoger si es admin o no
  bool canBeAdmin = false;
  //Para implementaciones futuras se debe de agregar una pantalla para el administrador para validar cuentas
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();  
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();  
  @override
  void initState() {
    super.initState();
    controllers = [
      _firstNameController,
      _lastNameController,
      _usernameController,
      _passwordController
    ];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: backgroundImage(),
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 60),            
            child: Card(
              color: Colors.white24,
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: singInForm(context),
            ),
          ),
        ),
      ),
    );
  }

  ListTile singInForm(context){
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      title: signInTitle(),
      subtitle: signInBoxes(context),
    );
  }

  Widget signInBoxes(context) {
    const sizedBox = SizedBox(height: 10);
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: ListView(
        padding: const EdgeInsets.only(bottom: 40),
        children: <Widget>[                  
          sizedBox,
          ValidatedText.namedTextBox(
            controller: _firstNameController,
            labelText: 'Nombre',
          ),
          sizedBox,        
          ValidatedText.namedTextBox(
            controller: _lastNameController,
            labelText: 'Apellidos',
          ),
          sizedBox,
          ValidatedText.requiredTextBox(
            controller: _usernameController,
            labelText: 'Nombre de Usuario',
          ),
          sizedBox,
          ValidatedText.passwordTextBox(
            controller: _passwordController,
            labelText: 'Contraseña',
          ),
          CheckboxListTile(
            secondary: Icon(Icons.add_moderator_outlined),
            title: Text('Administrador'),
            value: canBeAdmin, 
            onChanged: (value){
              setState((){
                canBeAdmin = value!;
              });                            
            },
            checkboxShape: CircleBorder(),
          ),
          signInButton(context),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Atrás'),
          ),
        ],
      ),
    );
  }
  bool botonPresionado = false;
  Widget signInButton(context) {
    return  FutureBuilder(
      future: botonPresionado ? userTaked() : null, //si el botón se ha presionado, llama al future, si no, pasa null
      builder: (context, snapshot) {
          return TextButton(
            onPressed: () async { //agrega async aquí
              setState(() {
                botonPresionado = true; //cambia el estado de la variable a true cuando se presiona el botón
            });
            if (!passAll()) {              
              errorSnackBar(context: context, errorMessage: 'Hay campos por rellenar');
              return;
            }
            bool? data = await userTaked(); //agrega await aquí y asigna el resultado a una variable
            if(data) {
              errorSnackBar(context: context, errorMessage: 'El usuario ya existe');
              return;
            }
          goBack();
          },
          child: const Text('Registrarse'),
          );
      },
    );
  }


 void goBack(){
  Navigator.pop(context);
 }

  Row signInTitle() {
    return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const[
                  Text('Registre sus datos'),
                ],
              );
  }

  BoxDecoration backgroundImage() {
    return const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/background/signin.jpg'),
          fit: BoxFit.cover,
        ),
      );
  }
  
  Future<bool> userTaked() async {
    bool check = false;
    final user = await getUser([_usernameController.text]);
    if(user != null) {
      check = user.isNotEmpty;
    }
    return check;
  }
}