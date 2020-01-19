



import 'package:garuda_cabin_mobile/models/transaction_item.dart';
import 'package:garuda_cabin_mobile/models/user.dart';
import 'package:garuda_cabin_mobile/services/ApiService.dart';

abstract class HistoryScreenContract {
  void onLoadSuccess(List<TransactionItem> transactionList);
  void onLoadError(String errorTxt);
}

class HistoryTransactionPresenter{
  HistoryScreenContract _view;
  ApiService _apiService = new ApiService();
  HistoryTransactionPresenter(this._view);



  doGetHistoryTransactionRedeem(User user, String startDate, String endDate) async {
    _apiService.getHistoryRedeem(user,startDate,endDate).then((List<TransactionItem> transactionList){
      _view.onLoadSuccess(transactionList);
    }).catchError((err) {
      _view.onLoadError(err.toString());
    });
  }
}