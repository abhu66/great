


import 'package:garuda_cabin_mobile/models/user.dart';

class UserResponse{
  int code;
  String status;
  String message;
  User data;

  UserResponse({this.code,this.status,this.message,this.data});

  factory UserResponse.fromJson(Map<String ,dynamic> map){
    var dataUser = map['data'] as List;
    List<User> users = dataUser.map((i) => User.fromJson(i)).toList();
    print("Rest data : $users");
    return UserResponse(code: map['code'],status: map['status'], message: map['message'],data: users[0]);
  }
}