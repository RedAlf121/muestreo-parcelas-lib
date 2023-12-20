import 'package:muestreo_parcelas/logic/user.dart';

import 'comment.dart';

class UserObserver extends User {
  List<Comment> _userComments = [];

  UserObserver(
      {int? id,
      String? userName,
      String? firstName,
      String? lastName,
      String? password})
      : super(
            id: id,
            userName: userName,
            firstName: firstName,
            lastName: lastName,
            password: password);
}
