import 'package:flutter/material.dart';
import 'package:muestreo_parcelas/utils/mixins/field_validate.dart';
import 'package:muestreo_parcelas/utils/text_box.dart';
import 'package:postgres/postgres.dart';

import '../../utils/error_snackbar.dart';
import '../../utils/routes.dart';

class LogIn extends StatefulWidget {   
   const LogIn({Key? key}) : super(key: key);
   @override
   LogInState createState() => LogInState();
 }

 class LogInState extends State<LogIn> with FieldValidate {

   final _usernameController = TextEditingController();
   final _passwordController = TextEditingController();
   late PostgreSQLResult userData;
   @override
  void initState() {    
    super.initState();
    controllers = [
      _usernameController,
      _passwordController
    ];
  }

   @override
   Widget build(BuildContext context) {      
     return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: backgroundImage(),
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 110,
            horizontal: 30
          ),
          child: Card(          
            color: Colors.transparent,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: loginBox(context),
          ),
        ),
      ),
     );
   }

   Stack loginBox(context) {
     return Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              ListTile(
                 contentPadding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                title: loginTitle(),
                subtitle: textBoxes(context),
               ),
            ],
          );
   }

   Widget textBoxes(context) {
     const sizedBox = SizedBox(height: 10);
     return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
       child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    sizedBox,
                    userTextField(),
                    sizedBox,
                    passwordTextField(),
                    sizedBox,
                    loginButton(context),
                    sizedBox,
                    const Text('¿Nuevo usuario?',style: TextStyle(
                      fontSize: 12
                    ),),
                    signInButton(context),
                   ],
                ),
     );
   }
  bool botonPresionado = false;
  Widget loginButton(context) {
    return  FutureBuilder(
      future: botonPresionado ? canLogin() : null, //si el botón se ha presionado, llama al future, si no, pasa null
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
            bool? data = await canLogin(); //agrega await aquí y asigna el resultado a una variable
            if(data) {
              errorSnackBar(context: context, errorMessage: 'Ese usuario no existe. Regístrese si no tiene una cuenta');
              return;
            }
          goHome();
          },
          child: const Text('Iniciar sesión'),
          );
      },
    );
  }


 void goHome(){
  Navigator.pushNamed(context, homeRoute);
 }

   Widget passwordTextField() {
     return ValidatedText.passwordTextBox(
          controller: _passwordController,
      );
   }

   Widget userTextField() {
     return ValidatedText.namedTextBox(      
      autofocus: true,
      controller: _usernameController,
      labelText: 'Nombre de usuario',
    );
   }

   Row loginTitle() {
     return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const[
                   Text('Ingrese su usario'),
                 ],
              );
   }

   BoxDecoration backgroundImage() {
     return const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/background/login.jpg'),
          fit: BoxFit.cover,
        ),
      );
   }
   
    Widget signInButton(context) {
      return TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context,'signin');                      
                  },
                  child: const Text('Regístrate aquí'),
                );
     }
     
    Future<bool> canLogin() async {
    bool check = false;
    final user = await getUser([_usernameController.text, _passwordController]);
    if(user != null) {
      check = user.isNotEmpty;
      userData = user;
    }
    return check;
  }
 }
