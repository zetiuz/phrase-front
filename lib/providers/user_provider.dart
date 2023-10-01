import 'package:flutter/foundation.dart';
import 'package:phrase/models/user.dart';

class UserProvider with ChangeNotifier {
  User _user = new User(
      userId: 0,
      name: '',
      email: '',
      phone: '',
      type: '',
      token: '',
      renewalToken: '');

  User get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }
}
