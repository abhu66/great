import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:garuda_cabin_mobile/auth.dart';
import 'package:garuda_cabin_mobile/database/database_helper.dart';
import 'package:garuda_cabin_mobile/models/user.dart';
import 'package:garuda_cabin_mobile/screens/home_screen.dart';
import 'package:garuda_cabin_mobile/screens/splash_screen.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class WidgetUtil {
  static WidgetUtil _instance = new WidgetUtil.internal();
  WidgetUtil.internal();
  factory WidgetUtil() => _instance;
  ProgressDialog pr;
  TextEditingController _startDateController = new TextEditingController();
  TextEditingController _endDateController = new TextEditingController();

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

  showErrorAlert(BuildContext context, AlertStyle style, dynamic title,
      dynamic description) {
    Alert(
      context: context,
      type: AlertType.error,
      style: style == null ? alertStyle : style,
      title: title,
      desc: description,
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

  showSuccessLoginAlert(BuildContext context, AlertStyle style, dynamic title,
      dynamic description, User user) {
    Alert(
      context: context,
      type: AlertType.success,
      style: style == null ? alertStyle : style,
      title: title,
      desc: description,
      buttons: [
        DialogButton(
          child: Text(
            "Ok",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            onClickButtonAlert(context, user);
          },
          width: 120,
        )
      ],
    ).show();
  }

  showAlertLogout(BuildContext context, User user) {
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
            onClickAlertLogout(context, user);
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

  void onClickAlertLogout(BuildContext context, User user) async {
    var db = new DatabaseHelper();
    var authStateProvider = new AuthStateProvider();
    await db.deleteUser(user);
    authStateProvider.notify(AuthState.LOGGED_OUT);
    Navigator.of(context).pop();
    Navigator.of(context).pushReplacement(new MaterialPageRoute(
        settings: const RouteSettings(name: '/'),
        builder: (context) => new SplashScreen()));
  }

  void onClickButtonAlert(BuildContext context, User user) {
    Navigator.of(context).pop();
    Navigator.of(context).pushReplacement(new MaterialPageRoute(
        settings: const RouteSettings(name: '/home'),
        builder: (context) => new HomeScreen(
              user: user,
            )));
  }

  showProgressIndicator(BuildContext context, AlertStyle style) {
    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);
    pr.style(message: 'Loading...');
  }

  showPickerDateRange(BuildContext context) {
    print("canceltext: ${PickerLocalizations.of(context).cancelText}");

    Picker ps = new Picker(
        hideHeader: true,
        adapter: new DateTimePickerAdapter(
            type: PickerDateTimeType.kYMD, isNumberMonth: true),
        onConfirm: (Picker picker, List value) {
          print((picker.adapter as DateTimePickerAdapter).value);
        });

    Picker pe = new Picker(
        hideHeader: true,
        adapter: new DateTimePickerAdapter(type: PickerDateTimeType.kYMD),
        onConfirm: (Picker picker, List value) {
          print((picker.adapter as DateTimePickerAdapter).value);
        });

    List<Widget> actions = [
      FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: new Text(PickerLocalizations.of(context).cancelText)),
      FlatButton(
          onPressed: () {
            Navigator.pop(context);
            ps.onConfirm(ps, ps.selecteds);
            pe.onConfirm(pe, pe.selecteds);
          },
          child: new Text(PickerLocalizations.of(context).confirmText))
    ];

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: Text("Select Date Range"),
            actions: actions,
            content: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text("Begin:"),
                  ps.makePicker(),
                  Text("End:"),
                  pe.makePicker(),
                ],
              ),
            ),
          );
        });
  }

  showDatePicker(BuildContext context, bool _isStartDate) {
    String _date = "";
    return TextFormField(
      style: TextStyle(color: Colors.white, fontSize: 8.0),
      readOnly: true,
      enableInteractiveSelection: false,
      controller: _isStartDate ? _startDateController : _endDateController,
      onTap: () {
        DatePicker.showDatePicker(context,
            showTitleActions: true,
            minTime: DateTime(2017, 1, 1),
            maxTime: DateTime(2050, 1, 1), onChanged: (date) {
          print('change $date');
          print(DateTime.now().toString());
        }, onConfirm: (date) {
          print('confirm $date');
          _date = '$date'.substring(0, 11);
          _isStartDate
              ? _startDateController.text = _date
              : _endDateController.text = _date;
          print('sss ' + _startDateController.value.text);
        }, currentTime: DateTime.now(), locale: LocaleType.en);
      },
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          suffixIcon: Icon(
            Icons.date_range,
            color: Colors.white,
          ),
          labelText: _isStartDate ? "Start Date" : "End Date",
          contentPadding: EdgeInsets.all(10.0),
          labelStyle: TextStyle(color: Colors.white),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white))),
    );
  }

  getStartDate() {
    return _startDateController.text;
  }

  getEndDate() {
    return _endDateController.text;
  }
}
