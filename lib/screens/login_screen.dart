import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:garuda_cabin_mobile/auth.dart';
import 'package:garuda_cabin_mobile/database/database_helper.dart';
import 'package:garuda_cabin_mobile/models/user.dart';
import 'package:garuda_cabin_mobile/presenters/login_presenter.dart';
import 'package:garuda_cabin_mobile/utils/base_widget.dart';
import 'package:progress_indicators/progress_indicators.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> implements LoginScreenContract,AuthStateListener{
  final formKey = new GlobalKey<FormState>();
  bool _isLoading = false;
  GlobalKey _scaffoldKey = new GlobalKey();
  LoginScreenPresenter _presenter;
  User _user;
  String _username, _password;
  Function onTapButtonAlertAction;
  WidgetUtil _widgetUtil = new WidgetUtil();
  bool _obscureText = true;


  _LoginScreenState(){
    _presenter = new LoginScreenPresenter(this);
    var authStateProvider = new AuthStateProvider();
    authStateProvider.subscribe(this);
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

//    SystemChrome.setPreferredOrientations([
//      DeviceOrientation.portraitUp,
//    ]);
    return Scaffold(
        key : _scaffoldKey,
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
                  AbsorbPointer(child:_buildButtonLogin(context),
                  absorbing: _isLoading ? true : false,),
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
                obscureText:_obscureText,

                decoration: InputDecoration(
                  suffixIcon: new GestureDetector(
                    onTap: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    child:
                    new Icon(_obscureText ? Icons.visibility : Icons.visibility_off , color:Colors.white),
                  ),
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
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SizedBox(height: 15,),
        SizedBox(
          height: 35.0,
          child: RaisedButton(
            elevation: 0.0,
            color: Color(0xffF3F3FE),
            child: Center(
              child: _isLoading == true ? _loadingIndicator() : Text(
                'Login',
                style: TextStyle(color: Colors.blue),
              ),
            ),
            onPressed: () {
              _loginProcess();
            },
          ),
        ),
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

  Widget _loadingIndicator() {
    return Container(
        width: 20.0,
        height: 20.0,
        child:
//        JumpingDotsProgressIndicator(
//          fontSize: 20.0,
//        ),
        (CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            Colors.blue,
          ),
          strokeWidth: 2.0,
        ))
    );
  }

  @override
  void onLoginError(String errorTxt) {
    setState((){
      _isLoading = false;
      _widgetUtil.showErrorAlert(context,
          null,
          "Login Failed",errorTxt);
    });
    print("Error data : "+errorTxt);
  }

  @override
  void onLoginSuccess(User user) async{
    setState(() => _isLoading = false);
    var db = new DatabaseHelper();
    await db.saveUser(user);
    _user = await db.getUser();
    var authStateProvider = new AuthStateProvider();
    authStateProvider.notify(AuthState.LOGGED_IN);
    _widgetUtil.showSuccessLoginAlert(context,
        null,
        "Login Success" ,
        _user.name,
        _user
    );
  }

  @override
  void onAuthStateChanged(AuthState state) async{
    if(state == AuthState.LOGGED_IN) {
      var db = new DatabaseHelper();
      _user = await db.getUser();
    }
  }

}
