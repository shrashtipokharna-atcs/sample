import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';
import 'package:test_app/bloc/validators.dart';

class LoginBloc with Validators {
  final _loginEmail = BehaviorSubject<String>();
  final _loginPassword = BehaviorSubject<String>();

  //Getters
  Stream<String> get loginEmail  => _loginEmail.stream.transform(emailValidator);
  Stream<String> get loginPassword => _loginPassword.stream.transform(loginPasswordValidator);

  Stream<bool> get isValid => Rx.combineLatest2(loginEmail, loginPassword, (loginEmail, pass) => true);

  //Setters
  Function(String) get changeLoginEmail => _loginEmail.sink.add;
  Function(String) get changeLoginPassword => _loginPassword.sink.add;
   
   void submit() {
    print(_loginEmail.value);
    print(_loginPassword.value);
  }
    
  


  void dispose(){
    _loginEmail.close();
    _loginPassword.close();
  }
  
  
}