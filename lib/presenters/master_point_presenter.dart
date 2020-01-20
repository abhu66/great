

import 'package:garuda_cabin_mobile/models/master_point.dart';
import 'package:garuda_cabin_mobile/models/user.dart';
import 'package:garuda_cabin_mobile/services/ApiService.dart';

abstract class MasterPointContract{
  void onLoginSuccess(List<MasterPoint> masterPoints);
  void onLoginError(String errorTxt);
  void onRedeemSuccess(String successText);
  void onRedeemError(String errorTxt);
}

class MasterPointPresenter{
  MasterPointContract _view;
  ApiService _apiService = new ApiService();
  MasterPointPresenter(this._view);

  doGetMasterPoint(){
    _apiService.getMasterPoint().then((List<MasterPoint> masterPoints){
      _view.onLoginSuccess(masterPoints);
    }).catchError((err) {
      _view.onLoginError(err.toString());
    });
  }
  doRedeemPoint(User user,String point, String idPoint){
    _apiService.redeemPoint(user, point, idPoint).then((String rs){
      _view.onRedeemSuccess(rs);
    }).catchError((onError){
      _view.onRedeemError(onError.toString());
    });
  }
}