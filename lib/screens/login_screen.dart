import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:garuda_cabin_mobile/models/user.dart';
import 'package:garuda_cabin_mobile/presenters/login_presenter.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> implements LoginScreenContract{
  final formKey = new GlobalKey<FormState>();
  bool _isLoading = false;
  LoginScreenPresenter _presenter;
  User _user;
  String _username, _password;


  _LoginScreenState(){
    _presenter = new LoginScreenPresenter(this);
  }

  void _loginProcess(){
    final form = formKey.currentState;
    if(form.validate()) {
      setState(() => _isLoading = true);
      form.save();
      _presenter.doLogin(_username, _password);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return Scaffold(
        backgroundColor: Colors.blue,
        body: Stack(
          children: <Widget>[
            new Positioned(
                bottom: -25,
                left: -70,
                height: 100.0,
                right: -100.0,
                child: _bottomLogo()),
            Container(
              padding: EdgeInsets.fromLTRB(30, 30, 30, 0.0),
              child: ListView(
                children: <Widget>[
                  _iconLogin(),
                  _formLogin(),
                  _buildButtonLogin(context),
                  _logo(),
                  SizedBox(
                    height: 100.0,
                  ),
                ],
              ),
            ),

          ],
        )
    );
  }

  Widget _iconLogin() {
    return Container(
      padding: EdgeInsets.all(30.0),
      child: Image.asset(
        "assets/images/garuda_indonesia_3x.png",
        width: 50.0,
        height: 50.0,
      ),
    );
  }

  Widget _formLogin() {
    return Column(
      children: <Widget>[
        new Form(
          key: formKey,
          child: new Column(
            children: <Widget>[
              new TextFormField(
                cursorColor: Colors.white,
                style: TextStyle(color: Colors.white,),
                onSaved: (val) => _username = val,
                validator: (val) {
                  return val.length < 1 ? "Username is required !" : null;
                },
                decoration: InputDecoration(
                  errorStyle: TextStyle(color: Colors.white),
                  icon: Icon(
                    Icons.account_circle,
                    color: Colors.white,
                  ),
                  labelText: 'Username',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: new UnderlineInputBorder(
                      borderSide: new BorderSide(color: Colors.white)),
                  focusedBorder: new UnderlineInputBorder(
                      borderSide: new BorderSide(color: Colors.red)),
                ),
              ),
              new TextFormField(
                style: TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                onSaved: (val) => _password = val,
                validator: (val) {
                  return val.length < 1 ? "Password is required" : null;
                },
                obscureText: true,
                decoration: InputDecoration(
                  errorStyle: TextStyle(color: Colors.white),
                  icon: Icon(Icons.lock, color: Colors.white),
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: new UnderlineInputBorder(
                      borderSide: new BorderSide(color: Colors.white)),
                  focusedBorder: new UnderlineInputBorder(
                      borderSide: new BorderSide(color: Colors.red)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildButtonLogin(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 20.0),
        ),
        InkWell(
          onTap: () {
            //_loginProcess();
          }, //
          child: Container(
            width: double.infinity,
            child: RaisedButton(
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(5.0),
                  side: BorderSide(color: Colors.transparent)),
              onPressed: () {
                _loginProcess();
              },
              color: Colors.white,
              textColor: Colors.blue,
              child: _isLoading ? CircularProgressIndicator() :
                  Text("Log in".toUpperCase(), style: TextStyle(fontSize: 14)),
            ),
          ),
        )
      ],
    );
  }

  Widget _logo() {
    return Container(
      padding: EdgeInsets.fromLTRB(40.0,50,10.0,50),
      child:
        Row(
        mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child:Image.asset('assets/images/image_115_3x.png'),
            ),
            Flexible(
              child:Image.asset('assets/images/image_116_3x.png'),
            ),
          ],
        ),
    );
  }

  Widget _bottomLogo() {
    return Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(0.0),
        height: 80.0,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage("assets/images/image_3x.png",),
          ),
        ),
    );
  }

  @override
  void onLoginError(String errorTxt) {
    setState(() => _isLoading = false);
    print("Error data : "+errorTxt);
  }

  @override
  void onLoginSuccess(User user) {
    setState(() => _isLoading = false);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: new Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              new Text("Login Success"),
            ],
          ),
        );
      },
    );
  }
}
