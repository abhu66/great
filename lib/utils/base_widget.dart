



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:garuda_cabin_mobile/auth.dart';
import 'package:garuda_cabin_mobile/database/database_helper.dart';
import 'package:garuda_cabin_mobile/models/user.dart';
import 'package:garuda_cabin_mobile/screens/home_screen.dart';
import 'package:garuda_cabin_mobile/screens/splash_screen.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class WidgetUtil {

  static WidgetUtil _instance = new WidgetUtil.internal();
  WidgetUtil.internal();
  factory WidgetUtil () => _instance;

  //default style
  static var alertStyle = AlertStyle(
    animationType: AnimationType.fromTop,
    isCloseButton: false,
    isOverlayTapDismiss: false,
    descStyle: TextStyle(fontWeight: FontWeight.bold),
    animationDuration: Duration(milliseconds: 400),
    alertBorder: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
      side: BorderSide(
        color: Colors.grey,
      ),
    ),
    titleStyle: TextStyle(
      color: Colors.red,
    ),
  );

  showErrorAlert(BuildContext context,AlertStyle style,dynamic title, dynamic description){
    Alert(
      context: context,
      type: AlertType.error,
      style: style == null ? alertStyle : style,
      title: title,
      desc:  description,
      buttons: [
        DialogButton(
          child: Text(
            "Ok",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
          width: 120,
        )
      ],
    ).show();
  }
  showSuccessLoginAlert(BuildContext context,AlertStyle style,dynamic title, dynamic description, User user){
    Alert(
      context: context,
      type: AlertType.success,
      style: style == null ? alertStyle : style,
      title: title,
      desc:  description,
      buttons: [
        DialogButton(
          child: Text(
            "Ok",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            onClickButtonAlert(context,user);
          },
          width: 120,
        )
      ],
    ).show();
  }

  showAlertLogout(BuildContext context, User user){
    Alert(
      context: context,
      type: AlertType.warning,
      title: "Logout",
      style: alertStyle,
      desc: "Are you sure want to exit app ?",
      buttons: [
        DialogButton(
          child: Text(
            "Yes",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.of(context).context;
            onClickAlertLogout(context,user);
          },
          color: Color.fromRGBO(0, 179, 134, 1.0),
        ),
        DialogButton(
          child: Text(
            "No",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
          gradient: LinearGradient(colors: [
            Color.fromRGBO(116, 116, 191, 1.0),
            Color.fromRGBO(52, 138, 199, 1.0)
          ]),
        )
      ],
    ).show();
  }

  void onClickAlertLogout(BuildContext context, User user) async{
    var db = new DatabaseHelper();
    var authStateProvider = new AuthStateProvider();
    await db.deleteUser(user);
    authStateProvider.notify(AuthState.LOGGED_OUT);
    Navigator.of(context).pop();
    Navigator.of(context).pushReplacement(
        new MaterialPageRoute(settings: const RouteSettings(name: '/'),
            builder: (context) => new SplashScreen()
        )
    );
  }

  void onClickButtonAlert(BuildContext context,User user){
    Navigator.of(context).pop();
    Navigator.of(context).pushReplacement(
        new MaterialPageRoute(settings: const RouteSettings(name: '/home'),
            builder: (context) => new HomeScreen(user: user,)
        )
    );
  }
}

