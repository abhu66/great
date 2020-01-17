
import 'dart:async';
import 'dart:convert';

import 'package:garuda_cabin_mobile/models/user.dart';
import 'package:garuda_cabin_mobile/utils/network_util.dart';


class ApiService{
  static final String BASE_URL            = "http://api-dev.asyst.co.id/great-api/api/v1/"; //PUBLIC
  static final String LOGIN_URL           = BASE_URL + "user/login";
  static final String GET_MASTER_POINT    = BASE_URL + "point/getMasterPoint";
  NetworkUtil  _networkUtil               = new NetworkUtil();
  String API_KEY = "API-KEY";
  String code = '';
  //get User detail
  Future<User> login(String username, String password) async{
    var body = json.encode({"username":username,"password":password});
    Map headers = <String, String>{
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    return _networkUtil.post(LOGIN_URL, body: body,headers: headers).then((dynamic res) {
      print(res.toString());
      if(res['code'] != 200){
       return throw new Exception(res["message"]);
      }
      else {
        return new User.map(res['data']);
      }
    });
  }
}