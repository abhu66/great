
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:garuda_cabin_mobile/models/master_point.dart';
import 'package:garuda_cabin_mobile/models/transaction_item.dart';
import 'package:garuda_cabin_mobile/models/user.dart';
import 'package:garuda_cabin_mobile/utils/network_util.dart';


class ApiService{
  static final String BASE_URL            = "http://api-dev.asyst.co.id/great-api/api/v1/"; //PUBLIC
  static final String LOGIN_URL           = BASE_URL + "user/login";
  static final String GET_MASTER_POINT    = BASE_URL + "point/getMasterPoint";
  static final String GET_TRANSACTION_LIST= BASE_URL + "employee/getTransactionList";
  static final String REDEEM_POINT        = BASE_URL + "/point/redeemPoint";
  static final String GET_TOTAL_POINT     = BASE_URL + "/user/getTotalPoint";

  NetworkUtil  _networkUtil               = new NetworkUtil();
  String API_KEY = "API-KEY";
  MasterPoint masterPoint = new MasterPoint();
  TransactionItem transactionItem = new TransactionItem();
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

  Future<List<MasterPoint>> getMasterPoint() async {
    return _networkUtil.get(GET_MASTER_POINT).then((dynamic res) {
      print(res["status"]['responsedesc']);
      if (res['status']['responsecode'] != 200) {
        return throw new Exception(res["status"]['responsedesc']);
      }
      else {
        return masterPoint.taskFromJson(res['result']);
      }
    });
  }

  Future<List<TransactionItem>> getHistoryRedeem(User user, String startDate, String endDate) async {

    var body = json.encode(
        {
          "identity" : {
            "reqtxnid" : "ea9e5895-29c9-4f98-97ef-fcb4ba96e56c",
            "reqdate" : DateTime.now().toString(),
          },
          "crew_id": "",
          "paging": {
            "page": 1,
            "limit": 20
          },
          "parameter": {
            "sort" : {
              "nopeg" : "",
              "date" : "DESC",
              "id_point" : "",
              "title" : "",
              "point" : "",
              "category" : ""
            },
            "column" : [
              "nopeg",
              "date",
              "id_point",
              "title",
              "point",
              "category"
            ],
            "criteria" : {
              "nopeg" : user.emp_id,
              "startdate" : startDate,
              "enddate" : endDate,
              "id_point" : "",
              "title" : "",
              "point" : "",
              "category" : ""
            }
          }
        }
    );

    Map headers = <String, String>{
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${user.token}'
    };
    return _networkUtil.post(GET_TRANSACTION_LIST,body: body,headers: headers).then((dynamic res) {
      print(user.token);
      print(res['status']);
      if (res['status']['responsecode'] != 200) {
        return throw new Exception(res["status"]['responsedesc']);
      }
      else {
        return transactionItem.taskFromJson(res['result']);
      }
    });
  }

  Future<String> redeemPoint(User user,String point, String idPoint)async {
    var body = json.encode(
      {
        "identity" : {
        "reqtxnid" : "ea9e5895-29c9-4f98-97ef-fcb4ba96e56c", // temp hardcoded
        "reqdate" : DateTime.now().toString(), // current date & time
        },
        "parameter" : {
          "data" : {
            "nopeg" : user.emp_id,
            "point" : point,
            "id_point" : idPoint,
          }
        }
      }
    );
    Map headers = <String, String>{
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${user.token}'
    };

    return _networkUtil.post(REDEEM_POINT,body: body,headers: headers)
        .then((dynamic res){
      print(user.token);
      print(res['status']);
      if (res['status']['responsecode'] != 200) {
        return throw new Exception(res["status"]['responsedesc']);
      }
      else {
        return (res['status']['responsecode'].toString());
      }
    });
  }

  Future<String> getTotalPoint(User user) async {
    var body = json.encode(
        {
          "identity" : {
            "reqtxnid" : "ea9e5895-29c9-4f98-97ef-fcb4ba96e56c", // temp hardcoded
            "reqdate" : DateTime.now().toString(), // current date & time
          },
          "parameter" : {
            "data" : {
              "nopeg" : user.emp_id,
            }
          }
        }
    );
    Map headers = <String, String>{
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${user.token}'
    };

    return _networkUtil.post(GET_TOTAL_POINT,body: body,headers: headers)
        .then((dynamic res){
      print(user.token);
      print(res['status']);
      if (res['status']['responsecode'] != 200) {
        return throw new Exception(res["status"]['responsedesc']);
      }
      else {
        return (res['result']['last_total'].toString());
      }
    });
  }
}