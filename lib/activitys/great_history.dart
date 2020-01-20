import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:garuda_cabin_mobile/models/transaction_item.dart';
import 'package:garuda_cabin_mobile/models/user.dart';
import 'package:garuda_cabin_mobile/presenters/history_presenter.dart';
import 'package:garuda_cabin_mobile/utils/base_widget.dart';
import 'package:garuda_cabin_mobile/widgets/great_history_list.dart';

class GreatHistoryActivity extends StatefulWidget {
  GreatHistoryActivity({Key key, this.user}) : super(key: key);
  final User user;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _GreatHistoryState();
  }
}

class _GreatHistoryState extends State<GreatHistoryActivity>
    implements HistoryScreenContract {
  WidgetUtil _widgetUtil = new WidgetUtil();
  bool _isVisible = false;
  TextEditingController _controllerText = new TextEditingController();
  double marginTop = 50.0;
  GlobalKey _scaffoldKey = new GlobalKey();

  HistoryTransactionPresenter _historyTransactionPresenter;
  List<TransactionItem> lisTransactions;
  String startDate = "", endDate = "";

  _GreatHistoryState() {
    _historyTransactionPresenter = new HistoryTransactionPresenter(this);
  }
  bool _isLoading = false;

  @override
  void initState() {
    _controllerText.addListener(() {});
    _isLoading = true;
    _historyTransactionPresenter.doGetHistoryTransactionRedeem(
        widget.user,
        new DateTime.now().toString().substring(0, 10),
        new DateTime.now().toString().substring(0, 10));
    super.initState();
  }

  @override
  void dispose() async {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("History"),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.date_range,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                _isVisible == true ? _isVisible = false : _isVisible = true;
              });
            },
          )
        ],
      ),
      body: Container(
          child: Stack(
        children: <Widget>[
          Visibility(
              child: Container(
                color: Colors.blue,
                padding: EdgeInsets.all(10.0),
                height: 50.0,
                child: Container(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      child: _widgetUtil.showDatePicker(context, true),
                    ),
                    Flexible(
                      child: _widgetUtil.showDatePicker(context, false),
                    ),
                    Flexible(
                      child: RaisedButton(
                        elevation: 0.0,
                        child: Text(
                          "Search",
                          style: TextStyle(color: Colors.blue),
                        ),
                        color: Color(0xffEEFBFA),
                        onPressed: () {
                          setState(() {
                            startDate = _widgetUtil.getStartDate();
                            endDate   = _widgetUtil.getEndDate();
                          });
                          print("Data 1 " + startDate);
                          print("Data 2 " + endDate);
                          fetchHistory(startDate, endDate);
                        },
                      ),
                    ),
                  ],
                )),
              ),
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              visible: _isVisible),
          Container(
            margin: _isVisible
                ? EdgeInsets.only(top: 50.0)
                : EdgeInsets.only(top: 0.0),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (ScrollNotification scrollInfo){
                      return loadData(scrollInfo);
                    },
                    child: lisTransactions == null || lisTransactions.isEmpty
                        ? Container(
                      alignment: Alignment(0.0, 0.0),
                      child: emptyTransaction(),
                    ) : RefreshIndicator(
                      onRefresh: _handleRefresh,
                      child: new GreatHistoryListWidget(
                        user: widget.user,
                        listTransaction: lisTransactions,
                      ),
                    )
                  ),
                ),
                Container(
                  height: _isLoading ? 50.0 : 0,
                  color: Colors.transparent,
                  child: Center(
                    child: new CircularProgressIndicator(),
                  ),
                ),
              ],
            )
          )
        ],
      )),
    );
  }

  Future<Null> _handleRefresh() async {
    _historyTransactionPresenter.doGetHistoryTransactionRedeem(
        widget.user, startDate, endDate);
    return null;
  }

  void fetchHistory(String strDate, String enDate) {
    setState(() {
      _isLoading = true;
      _historyTransactionPresenter.doGetHistoryTransactionRedeem(
          widget.user, strDate, enDate);
    });
  }

  @override
  void onLoadError(String errorTxt) {
    // TODO: implement
    setState(() {
      _isLoading = false;
    });
    if (lisTransactions != null) lisTransactions.clear();
  }

  @override
  void onLoadSuccess(List<TransactionItem> transactionList) {
    // TODO: implement onLoadSuccess
    setState(() {
      _isLoading = false;
      lisTransactions = transactionList;
    });
  }

  Widget emptyTransaction() {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 200.0),
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xffF3F3FE),
          ),
          child: Icon(
            Icons.history,
            color: Color(0xff415EF6),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Material(
          color: Colors.transparent,
          child: Text(
            'No Data History',
            style: TextStyle(
              color: Colors.black54,
              fontFamily: 'Regular',
              fontSize: 14,
            ),
          ),
        )
      ],
    );
  }


  loadData(ScrollNotification scrollInfo){
     if(!_isLoading && scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent){
        setState(() {
          _isLoading = true;
          _historyTransactionPresenter.doGetHistoryTransactionRedeem(
              widget.user,
              startDate,endDate);
        });
      }
  }
}
