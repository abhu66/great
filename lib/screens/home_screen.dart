





import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:garuda_cabin_mobile/models/user.dart';
import 'package:garuda_cabin_mobile/screens/non_cabin_screen.dart';

class HomeScreen extends StatelessWidget{
  HomeScreen({Key key, this.user}) : super(key:key);
  final User user;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Colors.blue,
        body: Stack(
          children: <Widget>[
            new Positioned(
                bottom: -25,
                left: -70,
                height: 100.0,
                right: -100.0,
                child: _bottomLogo(context)
            ),
            new Positioned(
              top:-10 ,
              left: -5.0,
              height: 200.0,
              right: -5.0,
              child:  _topImage(context),
            ),
            Center(child:Container(
              padding: EdgeInsets.fromLTRB(30, 100, 30, 0.0),
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  // _formLogin(),
                  Text("Select Category App : ",style: TextStyle(color: Colors.white),),
                  _buildButtonLogin(context),
                  _logo(),
                  SizedBox(
                    height: 100.0,
                  ),
                ],
              ),
            ),
            ),
          ],
        ),
    );
  }

  Widget _topImage(BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(0.0),
      height: 80.0,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage("assets/images/cabin_mobile_header_img-3x.png",),
        ),
      ),
    );
  }

  Widget _bottomLogo(BuildContext context) {
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

  Widget _buildButtonLogin(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SizedBox(height: 10,),
        SizedBox(
          height: 35.0,
          child: RaisedButton(
            elevation: 0.0,
            color: Color(0xffF3F3FE),
            child: Center(
              child: Text(
                'Cabin',
                style: TextStyle(color: Colors.blue),
              ),
            ),
            onPressed: () {},
          ),
            //absorbing:_selectedIndex != -1 ? false : true
        ),
        SizedBox(height: 10,),
        SizedBox(
          height: 35.0,
          child: RaisedButton(
            elevation: 0.0,
            color: Color(0xffF3F3FE),
            child: Center(
              child: Text(
                'Non Cabin',
                style: TextStyle(color: Colors.blue),
              ),
            ),
            onPressed: () {
                Navigator.of(context).pushReplacement(
                    new MaterialPageRoute(settings: const RouteSettings(name: '/great'),
                        builder: (context) => new Great(user: user,)
                    )
                );
            },
          ),
        ),
      ],
    );
  }
}