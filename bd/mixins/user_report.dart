import 'package:postgres/postgres.dart';

import '../../logic/user.dart';

abstract class IUserReport{
  Future<User> loginUser();
  Future<void> signInUser();
}