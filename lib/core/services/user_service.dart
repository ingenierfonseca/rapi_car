import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class UserService {
  final _userController = BehaviorSubject<String>();
  
  Stream get userStream => _userController.stream;
  String get user => '';
  
  void addUserStream({@required String user}) async {
    _userController.add(user);
  }

  void logout() async {
    //await _userRepository.logout();
    //_userController.add(null);
  }
}