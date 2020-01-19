


import 'dart:convert';

class TransactionItem {
  String refund;
  String date;
  String id_point;
  String title;
  String point;
  String category;
  String remark;


  TransactionItem({this.refund,this.date,this.id_point,this.title,this.point,this.category,this.remark});

  TransactionItem.map(dynamic obj) {
    this.refund   = obj['refund'];
    this.date     = obj["date"];
    this.id_point = obj['id_point'];
    this.title    = obj["title"];
    this.point    = obj['point'];
    this.category = obj['category'];
    this.remark   = obj['remark'];
  }

  Map<String, dynamic> toMap(){
    var map = new Map<String, dynamic>();
    map['refund']   = refund;
    map['date']     = date;
    map['id_point'] = id_point;
    map['title']    = title;
    map['point']    = point;
    map['category'] = category;
    map['remark']   = remark;

    return map;
  }

  factory TransactionItem.fromJson(Map<String, dynamic> map){
    return TransactionItem(
      refund: map['refund'],
      date: map['date'],
      id_point: map['id_point'],
      title: map['title'],
      point: map['point'],
      category: map['category'],
      remark: map['remark'],
    );
  }

  List<TransactionItem> taskFromJson(List<dynamic> jsonData){
    return List<TransactionItem>.from(jsonData.map((item) => TransactionItem.fromJson(item)));
  }
}