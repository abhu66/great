





import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:garuda_cabin_mobile/models/transaction_item.dart';
import 'package:garuda_cabin_mobile/models/user.dart';
import 'package:garuda_cabin_mobile/presenters/history_presenter.dart';
import 'package:garuda_cabin_mobile/utils/base_widget.dart';
import 'package:grouped_list/grouped_list.dart';

class GreatHistoryListWidget extends StatefulWidget{

  GreatHistoryListWidget({Key key, this.user,this.listTransaction}) : super(key:key);
  final User user;
  final List<TransactionItem> listTransaction;
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _GreatHistoryListState();
  }
}

class _GreatHistoryListState extends State<GreatHistoryListWidget>{
  final ScrollController _scrollController = new ScrollController();
  WidgetUtil _widgetUtil = new WidgetUtil();

  List data = [
    {"nama":"absadsdfsdfsdfsdfsdfsdu","tanggal":"12-12-2019","points":"1000","status":"redeem"},
    {"nama":"abu","tanggal":"12-12-2019","points":"1400","status":"redeem"},
    {"nama":"abu","tanggal":"14-12-2019","points":"1500","status":"refund"},
    {"nama":"abu","tanggal":"13-12-2019","points":"2000","status":"redeem"},
    {"nama":"abu","tanggal":"11-12-2019","points":"1500","status":"reject"},
    {"nama":"abu","tanggal":"11-12-2019","points":"1100","status":"redeem"},
    {"nama":"abu","tanggal":"11-12-2019","points":"2000","status":"redeem"},
    {"nama":"abu","tanggal":"11-12-2019","points":"1200","status":"redeem"},
    {"nama":"abu","tanggal":"11-12-2019","points":"100","status":"redeem"},
    {"nama":"abu","tanggal":"11-12-2019","points":"5000","status":"redeem"},
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child :_buildGroupListHistory(widget.listTransaction),
    );
  }



  Widget _buildGroupListHistory(List<TransactionItem> allHistory){
    print("Dataa a "+allHistory.length.toString());

    return GroupedListView(
        elements: allHistory,
        groupBy: (elements) => elements.date.toString().substring(0,10),
        groupSeparatorBuilder: _buildGroupSeparator,
        sort: false,
        controller: _scrollController,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context,elements) {
          return Container(
            color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      child: ListTile(
                        isThreeLine: false,
                          title:  Material(
                            color: Colors.transparent,
                            child: Text(
                              'Transaction',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Regular',
                                fontSize: 18,
                              ),
                            ),
                          ),
                          subtitle: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Material(
                                    color: Colors.transparent,
                                    child: Text(
                                      elements.title,
                                      style: TextStyle(
                                        fontFamily: 'Regular',
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Text("Status : ${elements.refund}"),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Text("Points : ${elements.point}"),
                                ],
                              ),
                              ],
                          ),
                          onTap: () {
                            _widgetUtil.showRemarks(context, "Remark", elements.remark != "" ? elements.remark : "No Remark");
                          },
                      ),
                    ),
                  ],
            ),
          );
        }
    );
  }
  Widget _buildGroupSeparator(dynamic groupByValue) {
    return Container(
      color : Colors.grey[200],
      margin: EdgeInsets.only(top:0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Material(
            color: Colors.transparent,
            child: Text(
              '$groupByValue',
              style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
                fontFamily: 'Regular',
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
      padding: EdgeInsets.all(10.0),
    );
  }

}