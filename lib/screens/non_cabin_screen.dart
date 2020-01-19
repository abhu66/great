import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:garuda_cabin_mobile/auth.dart';
import 'package:garuda_cabin_mobile/database/database_helper.dart';
import 'package:garuda_cabin_mobile/models/user.dart';
import 'package:garuda_cabin_mobile/presenters/login_presenter.dart';
import 'package:garuda_cabin_mobile/screens/splash_screen.dart';
import 'package:garuda_cabin_mobile/utils/base_widget.dart';
import 'package:garuda_cabin_mobile/utils/size_config.dart';
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

  Future<bool> _onBackPressed() {
    return _widgetUtil.showAlertLogout(context, widget.user) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    SizeConfig().init(context);
    return new WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          title: Text("GREAT",style: TextStyle(fontSize: 18.0),),
          elevation: 0.0,
          actions: <Widget>[
            IconButton(
              onPressed: () {
                _widgetUtil.showAlertLogout(context, widget.user);
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
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.all(0),
          scrollDirection: Axis.vertical,
          child: Container(
            child: Column(
                  children: <Widget>[
                    Stack(
                      overflow: Overflow.visible,
                      children: <Widget>[
                        ClipPath(
                          child: Container(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).padding.top),
                            height: 200,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [Colors.blue, Colors.blue]),
                            ),
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(16, 5, 16, 16),
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
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                          padding: EdgeInsets.only(top: 100),
                          child: PointWidget(
                            user: widget.user,
                          ),
                        ),
                      ],
                    ),
                  Container(
                        width: MediaQuery.of(context).size.width,
                        alignment:  Alignment.bottomCenter,
                        margin: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                        child : Image.network(
                          'https://ebrief.asyst.co.id/assets/images/asyst-logo.png',
                          scale: 3.0,
                        ),
                    ),
                  ],
                ),
          ),
        ),
      ),
    );
  }
}
