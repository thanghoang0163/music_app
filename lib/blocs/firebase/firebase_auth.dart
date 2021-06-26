import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';


class FireBaseAuth
{
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void SignUp(String name, String email, String password, Function onSuccess, Function(String) onRegisterError ){
    _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password).then((user){
      //success
      //_createUser(user.toString(), name, onSuccess, onRegisterError);
      print(user);
    }).catchError((err){
      _onSignUpErr(err.code, onRegisterError);
      //TODO
    });
  }
  _createUser(String userId, String name, Function onSuccess, Function(String) onRegisterError){
    var user = {
      "name": name,
    };
    var ref = FirebaseDatabase.instance.reference().child("users");
    ref.child(userId).set(user).then((user){
    //success
      onSuccess();
    }).catchError((err){
      //TODO
      onRegisterError("Sign up fail, please try again");
    });
  }
  
  void SignIn(String email, String password, Function onSuccess, Function(String) onSignInError){
    _firebaseAuth.signInWithEmailAndPassword(email: email, password: password).then((user){
      print("Sign in success");
      onSuccess();
    }).catchError((err){
      onSignInError("Sign in failed, please try again");
    });
  }

  void _onSignUpErr(String code, Function(String) onRegisterError){
    switch (code){
      case "ERROR_INVALID_EMAIL":
      case "ERROR_INVALID_CREDENTIAL":
        onRegisterError("Invalid Email");
        break;
      case "ERROR_EMAIL_ALREADY_IN_USE":
        onRegisterError("Email has existed");
        break;
      case "ERROR_WEAK_PASSWORD":
        onRegisterError("The password is not strong enough");
        break;
      default:
        onRegisterError("Sign up fail, please try again");
        break;
    }
  }
}