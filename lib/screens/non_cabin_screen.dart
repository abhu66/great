import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:garuda_cabin_mobile/auth.dart';
import 'package:garuda_cabin_mobile/database/database_helper.dart';
import 'package:garuda_cabin_mobile/models/user.dart';
import 'package:garuda_cabin_mobile/presenters/login_presenter.dart';
import 'package:garuda_cabin_mobile/screens/splash_screen.dart';
import 'package:garuda_cabin_mobile/utils/base_widget.dart';
import 'package:garuda_cabin_mobile/widgets/point_widget.dart';

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
  WidgetUtil _widgetUtil = new WidgetUtil();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("GREAT"),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              _widgetUtil.showAlertLogout(context,widget.user);
            },
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
            tooltip: "Logout",
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(0),
        scrollDirection: Axis.vertical,
        child: Container(
          color: Colors.grey.withOpacity(0.1),
          child: Column(
            children: <Widget>[
              Stack(
                overflow: Overflow.visible,
                children: <Widget>[
                  ClipPath(
                    child: Container(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).padding.top),
                      height: 250,
                      decoration: BoxDecoration(
                        gradient:
                        LinearGradient(colors: [Colors.blue, Colors.blue]),
                      ),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 2,
                                    ),
                                  ),
                                  child: FadeInImage.assetNetwork(
                                      height: 40.0,
                                      width: 40.0,
                                      imageScale: 2.0,
                                      placeholder: 'assets/images/user.png',
                                      placeholderScale: 6.0,
                                      image: widget.user.img_url),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Material(
                                      color: Colors.transparent,
                                      child: Text(
                                        widget.user.name,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontFamily: 'Bold',
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Material(
                                      color: Colors.transparent,
                                      child: Text(
                                        widget.user.emp_id,
                                        style: TextStyle(
                                          color: Color(0xffFCDCBE),
                                          fontSize: 15,
                                          fontFamily: 'Regular',
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                   // clipper: CurveShape(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 140),
                    child: PointWidget(user: widget.user,),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 340),
                    child:Container(
                      margin: EdgeInsets.only(top: 20),
                      alignment: Alignment.bottomCenter,
                        child:
                    Image.network('https://ebrief.asyst.co.id/assets/images/asyst-logo.png',scale: 3.0,))
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 480),
                    //child: StoreWidget(),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
