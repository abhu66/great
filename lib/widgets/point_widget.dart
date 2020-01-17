


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:garuda_cabin_mobile/models/user.dart';
import 'package:garuda_cabin_mobile/widgets/redeem_widget.dart';

class PointWidget extends StatelessWidget {

  PointWidget({Key key, this.user}) : super(key:key);
  final User user;
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
                  user.total_point,
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
                    child: GestureDetector(
                      child: Icon(
                        Icons.history,
                        color: Color(0xff415EF6),
                      ),
                      onTap: () {
                        openBottomSheet(context);
                      },
                    )
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
                    child: Icon(
                      Icons.redeem,
                      color: Color(0xff67E4D3),
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
        builder: (BuildContext context) =>  Wrap(children: [RedeemWidget(user: user,)]));
    }
}