


import 'dart:convert';

class User {
  String username;
  String name;
  String email;
  String emp_id;
  String position;
  String img_url;
  String total_point;
  String token;

  User({this.username,this.name,this.email,this.emp_id,this.position,this.img_url,this.total_point,this.token});


  User.map(dynamic obj) {
    this.username = obj["username"];
    this.name = obj["name"];
    this.email = obj['email'];
    this.emp_id = obj['emp_id'];
    this.position = obj['position'];
    this.img_url = obj['img_url'];
    this.total_point = obj['total_point'];
    this.token       = obj['token'];
  }

  String get _username => username;
  String get _name     => name;
  String get _email    => email;
  String get _emp_id   => emp_id;
  String get _position  => position;
  String get _img_url   => img_url;
  String get _total_point => total_point;
  String get _token => token;

  Map<String, dynamic> toMap(){
    var map = new Map<String, dynamic>();
    map['username'] = username;
    map['name']     = name;
    map['email']    = email;
    map['emp_id']   = emp_id;
    map['position'] = position;
    map['img_url']  = img_url;
    map['total_point'] = total_point;
    map['token']    = token;
    return map;
  }
}