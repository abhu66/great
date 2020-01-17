


import 'package:garuda_cabin_mobile/database/database_helper.dart';

enum AuthState{LOGGED_IN, LOGGED_OUT}

abstract class AuthStateListener {
  void onAuthStateChanged(AuthState state);
}

class AuthStateProvider {
  static final AuthStateProvider _instance = new AuthStateProvider.internal();
  List<AuthStateListener> _subscribers;
  factory AuthStateProvider () => _instance;
  AuthStateProvider.internal(){
    _subscribers = new List<AuthStateListener>();
    initState();
  }

  void initState() async{
      var db = new DatabaseHelper();
      var isLoggedIn = await db.isLoggedIn();
      if(isLoggedIn)
        notify(AuthState.LOGGED_IN);
      else
        notify(AuthState.LOGGED_OUT);
  }

  void subscribe(AuthStateListener listener){
    _subscribers.add(listener);
  }

  void dispose(AuthStateListener listener){
    for(var i in _subscribers){
      if(i == listener){
        _subscribers.remove(i);
      }
    }
  }

  void notify(AuthState state) async{
    _subscribers.forEach((AuthStateListener s) => s.onAuthStateChanged(state));
  }
}