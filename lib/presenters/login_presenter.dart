
import 'package:garuda_cabin_mobile/models/user.dart';
import 'package:garuda_cabin_mobile/services/ApiService.dart';

abstract class LoginScreenContract{
  void onLoginSuccess(User user);
  void onLoginError(String errorTxt);
}

class LoginScreenPresenter{
  LoginScreenContract _view;
  ApiService _apiService = new ApiService();
  LoginScreenPresenter(this._view);

  doLogin(String username, String password){
    _apiService.login(username, password).then((User user){
      _view.onLoginSuccess(user);
    }).catchError((err) {
      _view.onLoginError(err.toString());
    });
  }
}