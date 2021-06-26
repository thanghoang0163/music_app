import 'dart:async';
import 'package:music_app/blocs/firebase/firebase_auth.dart';

class AuthBloc{
  var _firebaseAuth = FireBaseAuth();
  StreamController _nameController = new StreamController();
  StreamController _emailController = new StreamController();
  StreamController _passwordController = new StreamController();

  Stream get nameStream => _nameController.stream;
  Stream get emailStream => _emailController.stream;
  Stream get passwordStream => _passwordController.stream;

  bool isValid(String name, String email, String password){
    if(name == null || name.length == 0)
      {
        _nameController.sink.addError("Nhập tên");
        return false;
      }
    _nameController.sink.add("");

    if(email == null || email.length == 0)
      {
        _emailController.sink.addError("Nhập email");
        return false;
      }
    _emailController.sink.add("");
    
    if(password == null || password.length < 6)
      {
        _passwordController.sink.addError("Mật khẩu phải trên 5 kí tự");
        return false;
      }
    _passwordController.sink.add("");

    return true;
  }

  void SignUp(String name, String email, String password, Function onSuccess, Function(String) onRegisterError){
    _firebaseAuth.SignUp(name, email, password, onSuccess, onRegisterError);
  }

  void SignIn(String email, String password, Function onSuccess, Function(String) onSignInError){
    _firebaseAuth.SignIn(email, password, onSuccess, onSignInError);
  }

  void dispose(){
    _nameController.close();
    _emailController.close();
    _passwordController.close();
  }
  
}