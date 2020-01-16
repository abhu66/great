


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

  factory User.fromJson(Map<String, dynamic> map){
    return User(
      username:  map['username'],
      name: map['name'],
      email: map['email'],
      emp_id: map['emp_id'],
      position: map['position'],
      img_url: map['img_url'],
      total_point: map['total_point'],
      token: map['token'],
    );
  }

  User.fromMap(Map<String, dynamic> map) {
    username    =  map['username'];
    name        = map['name'];
    email       = map['email'] ;
    emp_id      = map['emp_id'] ;
    position    = map['position']  ;
    img_url     = map['img_url']   ;
    total_point = map['total_point'] ;
    token       = map['token'];
  }

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

  Map<String, dynamic> toMap(){
    var map = new Map<String, dynamic>();
    map['username'] = username;
    map['nama']     = name;
    map['email']    = email;
    map['emp_id']   = emp_id;
    map['position'] = position;
    map['img_url']  = img_url;
    map['total_point'] = total_point;
    map['token']    = token;

    return map;
  }

}