import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:garuda_cabin_mobile/models/master_point.dart';
import 'package:garuda_cabin_mobile/models/user.dart';
import 'package:garuda_cabin_mobile/presenters/master_point_presenter.dart';
import 'package:garuda_cabin_mobile/utils/base_widget.dart';

class RedeemWidget extends StatefulWidget {
  RedeemWidget({Key key, this.user}) : super(key: key);
  final User user;


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _RedeemWidgetState();
  }
}

class _RedeemWidgetState extends State<RedeemWidget> implements MasterPointContract{
  int _selectedIndex = -1;
  bool _isLoading = false;
  MasterPointPresenter _masterPointPresenter;
  List<MasterPoint> listMasterPoints;
  WidgetUtil _widgetUtil = new WidgetUtil();
  String pointItem, idPoint;
  MasterPoint _masterPoint;

  _RedeemWidgetState(){
    _masterPointPresenter = new MasterPointPresenter(this);
  }
  _onSelected(int index,MasterPoint masterPoint) {
    setState((){
      _selectedIndex = index;
      _masterPoint = masterPoint;
    });
  }

  bool _isSelected = false;

  @override
  void initState(){
    _isLoading = true;
    _masterPointPresenter.doGetMasterPoint();
    super.initState();
  }

  @override
  void dispose() async{
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      height: MediaQuery.of(context).size.height - 100,
      margin: EdgeInsets.all(1),
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(16, 10, 16, 1),
            margin: EdgeInsets.only(bottom: 50.0),
            child: Column(
              children: <Widget>[
                Container(
                  height: 1,
                  width: 30.0,
                  color: Colors.grey[300],

                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: 1,
                  width: 30.0,
                  color: Colors.grey[300],
                ),
                SizedBox(
                  height: 10,
                ),
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
                _buildListMasterPoint(),
              ],
            ),
          ),
          new Positioned(
            bottom: 0.0,
            child : Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.all(0.0),
              child : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(
                    width: 200, // works
                    height: 50.0,
                    child: AbsorbPointer(child:RaisedButton(
                      elevation: 0.0,
                      color: _selectedIndex != -1 ? Colors.blue : Color(0xffF3F3FE),
                      child: Center(
                        child: _isLoading ? _loadingIndicator() : Text(
                          'Submit',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          _isLoading = true;
                        });
                        doRedeem();
                      },
                    ),
                      absorbing:_selectedIndex != -1 ? false : true ,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListMasterPoint(){
    return _isLoading == false ? Expanded(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: listMasterPoints.length,
          itemBuilder: (BuildContext context, int index) {
            MasterPoint masterPoin = listMasterPoints[index];
            return Card(
              elevation: 0.0,
              color: _selectedIndex != -1 && _selectedIndex == index
                  ? Color(0xffFD706B)
                  : Color(0xffF3F3FE),
              child: ListTile(
                title: Text(masterPoin.point),
                subtitle: Text(masterPoin.title),
                trailing: _selectedIndex != -1 && _selectedIndex == index
                    ? Icon(Icons.check_circle)
                    : Icon(Icons.check_circle_outline),
                onTap: () {
                  _onSelected(index,masterPoin);
                },
              ),
            );
          }),
    ) : Text("");
  }


  Widget _loadingIndicator() {
    return Container(
        width: 20.0,
        height: 20.0,
        child: (CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            Colors.blue,
          ),
          strokeWidth: 3.0,
        ))
    );
  }

  @override
  void onLoginError(String errorTxt) {
    setState(() {
      _isLoading = false;
    });
    _widgetUtil.showErrorAlert(context,null, 'Failed', errorTxt);
  }

  @override
  void onLoginSuccess(List<MasterPoint> masterPoints) {
    // TODO: implement onLoginSuccess
    setState(() {
      _isLoading = false;
      listMasterPoints = masterPoints;
    });
  }

  @override
  void onRedeemError(String errorTxt) {
    setState(() {
      _isLoading = false;
    });
    _widgetUtil.showErrorAlert(context, null, "Failed", errorTxt);
  }

  @override
  void onRedeemSuccess(String successText) {
    setState(() {
      _isLoading = false;
    });
    _widgetUtil.showSuccessAlert(context, null, "Success", "Your redeem request has been processed");
  }

  void doRedeem(){
    _masterPointPresenter.doRedeemPoint(widget.user,_masterPoint.point,_masterPoint.id_point);
  }
}
