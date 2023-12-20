import 'package:flutter/material.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class ValidatedText {
  static Widget _textBox({
    required context,
    required TextEditingController controller,
    required List<String? Function(String?)> validatorList,
    bool autofocus = false,
    String? labelText,
    TextInputType? type,
    bool password = false,
  }) {
    return TextFormField(
      keyboardType: type,
      validator: Validators.compose(validatorList),
      cursorColor: Colors.greenAccent,
      autofocus: autofocus,
      controller: controller,
      obscureText: password,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: (Theme.of(context).brightness == Brightness.dark)
                ? const Color.fromARGB(255, 60, 144, 36)
                : const Color.fromARGB(255, 82, 183, 136),
          ),
        ),
        labelText: labelText,
      ),
    );
  }

  static Widget requiredTextBox(
      {required context,
      bool autofocus = false,
      required TextEditingController controller,
      String? labelText,
      bool password = false,
      TextInputType? type,
      List<String? Function(String?)>? validatorList}) {
    List<String? Function(String?)> list = [
      Validators.required('La componente no puede estar vacía')
    ];

    if (validatorList != null) {
      list.addAll(validatorList);
    }

    return _textBox(
      type: type,
      context: context,
      autofocus: autofocus,
      controller: controller,
      labelText: labelText,
      validatorList: list,
      password: password,
    );
  }

  static Widget passwordTextBox(
      {required context,
      bool autofocus = false,
      required TextEditingController controller,
      String? labelText,
      List<String? Function(String?)>? validatorList}) {
    List<String? Function(String?)> list = [
      Validators.minLength(8, 'La contraseña debe de tener mínimo 8 carácteres')
    ];
    return requiredTextBox(
      context: context,
      controller: controller,
      autofocus: autofocus,
      labelText: labelText ?? 'Contraseña',
      validatorList: list,
      password: true,
    );
  }

  static Widget namedTextBox(
      {required context,
      bool autofocus = false,
      required TextEditingController controller,
      String? labelText,
      List<String? Function(String?)>? validatorList}) {
    List<String? Function(String?)> list = [
      Validators.patternRegExp(
          RegExp(r"^[A-Za-z]+$"), 'Solo se permiten letras en el nombre')
    ];
    return requiredTextBox( 
        type: TextInputType.name,     
        context: context,
        controller: controller,
        autofocus: autofocus,
        labelText: labelText,
        validatorList: list);
  }
}
