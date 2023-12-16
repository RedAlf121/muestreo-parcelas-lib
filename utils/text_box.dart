import 'package:flutter/material.dart';
import 'package:wc_form_validators/wc_form_validators.dart';


class ValidatedText{
  static Widget _textBox({
    bool autofocus = false,
    required TextEditingController controller,
    String? labelText,
    required List<String? Function(String?)> validatorList,
    bool password = false,
    }) {
    return TextFormField(
      validator: Validators.compose(
          validatorList
      ),
      cursorColor: Colors.greenAccent,
      autofocus: autofocus,
      controller: controller,
      obscureText: password,
      decoration: InputDecoration(        
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        labelText: labelText,
      ),
    );
  }
  

  static Widget requiredTextBox({
    bool autofocus = false,
    required TextEditingController controller,
    String? labelText,
    bool password = false,
    List<String? Function(String?)>? validatorList
  }){

    List<String? Function(String?)> list = [Validators.required('La componente no puede estar vacía')];

    if(validatorList != null) {
      list.addAll(validatorList);
    }

    return _textBox(
      autofocus: autofocus,
      controller: controller,
      labelText: labelText, 
      validatorList: list,  
      password: password,
    );
  }

  static Widget passwordTextBox({
    bool autofocus = false,
    required TextEditingController controller,
    String? labelText,
    List<String? Function(String?)>? validatorList
  }){
    List<String? Function(String?)> list =[Validators.minLength(8, 'La contraseña debe de tener mínimo 8 carácteres')];
    return requiredTextBox(
      controller: controller,
      autofocus: autofocus,
      labelText: labelText ?? 'Contraseña',
      validatorList: list,
      password: true,
    );
  }

  static Widget namedTextBox({
    bool autofocus = false,
    required TextEditingController controller,
    String? labelText,
    List<String? Function(String?)>? validatorList
  }){
    List<String? Function(String?)> list =[Validators.patternRegExp(RegExp(r"^[A-Za-z]+$"), 'Solo se permiten letras en el nombre')];
    return requiredTextBox(
      controller: controller,
      autofocus: autofocus,
      labelText: labelText,
      validatorList: list
    );
  }

}