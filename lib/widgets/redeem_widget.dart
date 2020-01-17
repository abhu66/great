


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:garuda_cabin_mobile/models/user.dart';


class RedeemWidget extends StatefulWidget{
  RedeemWidget({Key key, this.user}) : super(key:key);

  final User user;
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _RedeemWidgetState();
  }
}

class _RedeemWidgetState extends State<RedeemWidget> {
  int _selectedIndex = 0;
  var data = [
    {"nama":"aksjdaksjdasd"},
    {"nama":"aksjdaksjdasd"},
    {"nama":"aksjdaksjdasd"},
    {"nama":"aksjdaksjdasd"},
    {"nama":"aksjdaksjdasd"},
    {"nama":"aksjdaksjdasd"},
    {"nama":"aksjdaksjdasd"},
    {"nama":"aksjdaksjdasd"},
    {"nama":"aksjdaksjdasd"},
    {"nama":"aksjdaksjdasd"}];

  _onSelected(int index) {
    setState(() => _selectedIndex = index);
  }


  bool _isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500.0,
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.all(1),
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
                  'Select Your Redeem Type',
                  style: TextStyle(
                    color: Color(0xff64676F),
                    fontFamily: 'Regular',
                    fontSize: 16,
                  ),
                ),
              ),
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
          Expanded(
            child:ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  elevation: 0.0,
                  color: Color(0xffF3F3FE),
                  child:
                  ListTile(
                    title: Text(data[index]['nama']),
                    trailing: _selectedIndex != null && _selectedIndex == index
                        ? Icon(Icons.check_circle) : Icon(Icons.check_circle_outline),
                    onTap: (){
                      _onSelected(index);
                    },
                  ),
                );
                }
            ),
            ),
          Card(
            margin: EdgeInsets.all(0.0),
            elevation: 0.0,
            color: Colors.blue,
            child:
            ListTile(
              title: Center(child : Text('Submit',style: TextStyle(color: Colors.white),)),
              onTap: (){
              },
            ),
          ),
        ],
      ),
    );
  }
}