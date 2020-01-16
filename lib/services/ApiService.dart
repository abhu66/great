
import 'dart:async';
import 'dart:convert';

import 'package:garuda_cabin_mobile/models/user.dart';
import 'package:garuda_cabin_mobile/responses/user_response.dart';
import 'package:garuda_cabin_mobile/utils/network_util.dart';


class ApiService{
  static final String BASE_URL            = "http://api-dev.asyst.co.id/great-api/api/v1/"; //PUBLIC
  static final String LOGIN_URL           = BASE_URL + "user/login";
  NetworkUtil  _networkUtil               = new NetworkUtil();
  String API_KEY = "API-KEY";
  String code = '';
  //get User detail
  Future<User> login(String username, String password) async{
    var body = json.encode({"username":username,"password":password});
    return _networkUtil.post(LOGIN_URL, body: body,
      headers: {
      'Content-Type': 'application/json'
    }).then((dynamic res) {
      if(res != null){
        this.code = res['code'].cast<String,int>();
      }
      return new User.map(jsonDecode(jsonEncode(res)));
    });
  }
}