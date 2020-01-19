


import 'dart:convert';

class MasterPoint {
  String id_point;
  String title;
  String point;


  MasterPoint({this.id_point,this.title,this.point});

  MasterPoint.map(dynamic obj) {
    this.id_point  = obj["id_point"];
    this.title    = obj["title"];
    this.point    = obj['point'];
  }

  String get _idPoint => id_point;
  String get _title   => title;
  String get _point   => point;

  Map<String, dynamic> toMap(){
    var map = new Map<String, dynamic>();
    map['id_point'] = id_point;
    map['title']     = title;
    map['point']    = point;
    return map;
  }

  factory MasterPoint.fromJson(Map<String, dynamic> map){
    return MasterPoint(
      id_point: map['id_point'],
      title: map['title'],
      point: map['point'],
    );
  }

  List<MasterPoint> taskFromJson(List<dynamic> jsonData){
    return List<MasterPoint>.from(jsonData.map((item) => MasterPoint.fromJson(item)));
  }
}