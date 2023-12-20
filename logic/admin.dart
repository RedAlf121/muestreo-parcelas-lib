import 'user.dart';

class UserAdmin extends User {
  UserAdmin(
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
