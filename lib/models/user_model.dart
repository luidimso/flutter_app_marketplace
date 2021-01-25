import 'package:scoped_model/scoped_model.dart';

class User extends Model {
  bool isLoading = false;

  void signup() {

  }

  void signin() async {
    isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 3));
    isLoading = false;
    notifyListeners();
  }

  void recoverPassword() {

  }
}