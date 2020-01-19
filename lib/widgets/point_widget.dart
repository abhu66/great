


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:garuda_cabin_mobile/activitys/great_history.dart';
import 'package:garuda_cabin_mobile/models/master_point.dart';
import 'package:garuda_cabin_mobile/models/user.dart';
import 'package:garuda_cabin_mobile/presenters/master_point_presenter.dart';
import 'package:garuda_cabin_mobile/services/ApiService.dart';
import 'package:garuda_cabin_mobile/widgets/redeem_widget.dart';

class PointWidget extends StatefulWidget {

  PointWidget({Key key, this.user}) : super(key:key);
  final User user;

  @override
  _PointWidgetState createState() => _PointWidgetState();
}

class _PointWidgetState extends State<PointWidget> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Material(
                color: Colors.transparent,
                child: Text(
                  'Total Point',
                  style: TextStyle(
                    color: Color(0xff64676F),
                    fontFamily: 'Regular',
                    fontSize: 16,
                  ),
                ),
              ),
              Material(
                color: Colors.transparent,
                child: Text(
                  widget.user.total_point,
                  style: TextStyle(
                    color: Color(0xff464855),
                    fontFamily: 'Regular',
                    fontSize: 16,
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            height: 1,
            width: MediaQuery.of(context).size.width,
            color: Colors.grey[300],
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xffF3F3FE),
                    ),
                    child : IconButton(
                        icon : Icon(Icons.history),
                        color: Color(0xff415EF6),
                        onPressed: (){
                          Navigator.of(context).push(
                              new MaterialPageRoute(
                                builder: (context) => new GreatHistoryActivity(user: widget.user,)
                              )
                          );
                        },
                      ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: Text(
                      'History',
                      style: TextStyle(
                        color: Colors.black54,
                        fontFamily: 'Regular',
                        fontSize: 14,
                      ),
                    ),
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xffEEFBFA),
                    ),
                    child: IconButton(
                      icon : Icon(Icons.redeem),
                      color: Color(0xff415EF6),
                      onPressed: (){
                        openBottomSheet(context);
                      },
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: Text(
                      'Redeem',
                      style: TextStyle(
                        color: Colors.black54,
                        fontFamily: 'Regular',
                        fontSize: 14,
                      ),
                    ),
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xffFFF3F3),
                    ),
                    child: Icon(
                      Icons.info,
                      color: Color(0xffFD706B),
                      size: 32,
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: Text(
                      'Info',
                      style: TextStyle(
                        color: Colors.black54,
                        fontFamily: 'Regular',
                        fontSize: 14,
                      ),
                    ),
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xffFFF3F3),
                    ),
                    child: Icon(
                      Icons.mode_comment,
                      color: Color(0xffFD706B),
                      size: 32,
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: Text(
                      'FAQ',
                      style: TextStyle(
                        color: Colors.black54,
                        fontFamily: 'Regular',
                        fontSize: 14,
                      ),
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
  openBottomSheet(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0)),
        ),
        builder: (BuildContext context) =>  Wrap(children: [RedeemWidget(user: widget.user)]));
  }
}