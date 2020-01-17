import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:garuda_cabin_mobile/models/user.dart';

class Great extends StatefulWidget {
  Great({Key key, this.user}) : super(key: key);

  final User user;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _GreatState();
  }
}

class _GreatState extends State<Great> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("GREAT"),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
            tooltip: "Logout",
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
//          new Positioned(
//              bottom: -25,
//              left: -70,
//              height: 100.0,
//              right: -100.0,
//              child: _bottomLogo()),
          Container(
            padding: EdgeInsets.fromLTRB(100, 10, 100, 0.0),
            child: ListView(
              children: <Widget>[
                _userProfileImage(),
                Center(child:Text(widget.user.name,style: TextStyle(color: Colors.blue, fontSize: 20.0),)),
                SizedBox(height: 20,),
                Center(child:Text(widget.user.emp_id,style: TextStyle(color: Colors.black, fontSize: 20.0))),

                //_formLogin(),
               //
                //_logo(),
                SizedBox(
                  height: 100.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _userProfileImage() {
    return Container(
      padding: EdgeInsets.all(30.0),
      child: FadeInImage.assetNetwork(
          height: 150.0,
          width: 50,
          fit: BoxFit.cover,
          placeholder: 'assets/images/user.png',
          image: widget.user.img_url),
    );
  }

  Widget _userProfile(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20.0),
      child: new Wrap(
        children: <Widget>[
          new ListTile(
            leading: FadeInImage.assetNetwork(
                height: 80.0,
                width: 60.0,
                fit: BoxFit.fill,
                placeholder: 'assets/images/user.png',
                image: widget.user.img_url),

            title: new Text(
              widget.user.name,
              style: new TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            subtitle: new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text(widget.user.emp_id,
                      style: new TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.normal)),
                  new Text(widget.user.email,
                      style: new TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.normal)),
                ]),
            //trailing: ,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _boxMenu(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 5, 10, 50),
      child: new Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: new Column(
            children: <Widget>[
              new ListTile(
                leading: FadeInImage.assetNetwork(
                    height: 100.0,
                    width: 60.0,
                    fit: BoxFit.fill,
                    placeholder: 'assets/images/user.png',
                    image: widget.user.img_url),
                title: new Text(
                  widget.user.name,
                  style: new TextStyle(
                      fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                subtitle: new Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text(widget.user.emp_id,
                        style: new TextStyle(
                            fontSize: 13.0, fontWeight: FontWeight.normal)),
                    new Text(widget.user.email,
                        style: new TextStyle(
                            fontSize: 13.0, fontWeight: FontWeight.normal)),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
