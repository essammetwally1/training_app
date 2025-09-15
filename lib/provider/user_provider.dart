import 'package:flutter/material.dart';
import 'package:training_app/models/user_model.dart';

class UserProvider with ChangeNotifier {
  UserModel? currentUser;
  void upDateUser(UserModel user) {
    currentUser = user;
    notifyListeners();
  }
}
