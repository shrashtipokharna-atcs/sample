import 'package:rxdart/rxdart.dart';
import 'package:test_app/bloc/validators.dart';

class RegisterBloc with Validators {
  final _name = BehaviorSubject<String>();
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();
  final _phoneNumber = BehaviorSubject<String>();
  final _confirmPassword = BehaviorSubject<String>();

  //Getters
  Stream<String> get name  => _name.stream.transform(nameValidator);
  Stream<String> get email  => _email.stream.transform(emailValidator);
  Stream<String> get password => _password.stream.transform(passwordValidator);
  Stream<String> get phoneNumber  => _phoneNumber.stream.transform(phoneValidator);
  Stream<String> get confirmPassword  => _confirmPassword.stream.transform(confirmPasswordValidator);

  Stream<bool> get isValid => Rx.combineLatest5(name, email, phoneNumber,
      password, confirmPassword, (name, email, phone, pass, confPass) => true);

  ///`To match the password`
  Stream<bool> get passwordMatch =>
      Rx.combineLatest2(password, confirmPassword, (pass, confPass) {
        if (pass != confPass) {
          return false;
        } else {
          return true;
        }
      });

  //Setters
  Function(String) get changeName => _name.sink.add;
  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePhoneNumber => _phoneNumber.sink.add;
  Function(String) get changePassword => _password.sink.add;
  Function(String) get changeConfirmPassword => _confirmPassword.sink.add;

  void submit() {
    if (password != confirmPassword) {
      _confirmPassword.sink.addError("Password doesn't match");
    } else {
      
      print(_name);
      print(_email);
      print(_phoneNumber);
      print(_password);
      print(_confirmPassword);
    }
  }

  


  void dispose(){
    _name.close();
    _email.close();
    _phoneNumber.close();
    _password.close();
    _confirmPassword.close();
  }
  
  
}