import 'package:flutter/gestures.dart';
import 'package:music_app/blocs/auth_bloc.dart';
import 'package:music_app/login_page.dart';
import 'package:flutter/material.dart';
import 'package:music_app/dialog/loading_dialog.dart';
import 'package:music_app/dialog/msg_dilog.dart';


class RegisterPage extends StatefulWidget {
  //const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  AuthBloc authBloc = new AuthBloc();

  TextEditingController _nameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  @override
  void dispose(){
    authBloc.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(30, 50, 30, 0),
        constraints: BoxConstraints.expand(),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Text(
                  "Enjoy your music",
                  style: TextStyle(fontSize: 22,
                      fontFamily: 'DMSerif',
                      color: Colors.black),
                ),
              ),
              Text(
                "Sign up with simple steps",
                style: TextStyle(fontSize: 16,
                    fontFamily: 'DMSerif',
                    color: Colors.black),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 50, 0, 20),
                child: StreamBuilder(
                  stream: authBloc.nameStream,
                  builder: (context, snapshot) => TextField(
                    style: TextStyle(fontSize: 18, color: Colors.black),
                    decoration: InputDecoration(
                        labelText: "Name",
                        prefixIcon: Container(
                          width: 50,
                          child: Icon(Icons.person_outline_rounded),
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 1),
                            borderRadius: BorderRadius.all(Radius.circular(6))
                        )
                    ),
                  ),
                )
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: StreamBuilder(
                  stream: authBloc.emailStream,
                  builder: (context, snapshot) => TextField(
                    style: TextStyle(fontSize: 18, color: Colors.black),
                    decoration: InputDecoration(
                        labelText: "Email",
                        prefixIcon: Container(
                          width: 50, child: Icon(Icons.mail_outline_rounded),
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 1),
                            borderRadius: BorderRadius.all(Radius.circular(6))
                        )
                    ),
                  ),
                )
              ),
              StreamBuilder(
                stream: authBloc.passwordStream,
                builder: (context, snapshot) => TextField(
                  style: TextStyle(fontSize: 18, color: Colors.black),
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    prefixIcon: Container(
                      width: 50, child: Icon(Icons.lock_outline_rounded),
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(6))
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
                child: SizedBox(width: double.infinity, height: 52,
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                    color: Colors.grey,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6))
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
                child: RichText(
                  text: TextSpan(
                      text: "Already a user? ",
                      style: TextStyle(fontSize: 16, color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => LoginPage())
                              );
                            },
                          text: "Login now",
                          style: TextStyle(fontSize: 16, color: Colors.blue),
                        )
                      ]
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _onSignUpClicked(){
    var isValid = authBloc.isValid(_nameController.text,
      _emailController.text,
      _passwordController.text);
    if(isValid){
      //create user
      //loading dialog
      LoadingDialog.showLoadingDialog(context, 'Loading...');
      authBloc.SignUp(_nameController.text, _emailController.text, _passwordController.text, () {
        LoadingDialog.hideLoadingDialog(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      }, (msg) {
        LoadingDialog.hideLoadingDialog(context);
        MsgDialog.showMsgDialog(context, "Sign In", msg);
      });
    }
  }
}
