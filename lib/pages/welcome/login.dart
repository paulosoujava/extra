import 'package:extra/utils/consts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:nice_button/nice_button.dart';

class Login extends StatefulWidget {
  bool isGoogleLogin = false;
  bool isScroable;

  Login({this.isScroable = false});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  _entryField(String title, String hint, {bool isPass = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
              obscureText: isPass,
              decoration: InputDecoration(
                  hintText: hint,
                  labelText: title,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  fillColor: Color(0xfff),
                  filled: true))
        ],
      ),
    );
  }

  _textFields() {
    return Column(
      children: <Widget>[
        _entryField("Email ", "digite seu email"),
        _entryField("Senha ", "digite sua senha", isPass: true),
        //_entryField("Senha", isPassword: true),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body:Center(
            child: ListView(
              shrinkWrap: true,
              children: [
                Row(
                  children: <Widget>[
                    widget.isScroable
                        ? Container()
                        : FlatButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back_ios, color: Consts.PRIMARY_COLOR,),
                      label: Text("Voltar", style: TextStyle(color: Consts.PRIMARY_COLOR,),),
                    ),
                  ],

                ),

                Consts().title(context, "Login"),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: _textFields(),
                ),
                NiceButton(
                  width: double.infinity,
                  gradientColors: [
                    Consts.PRIMARY_COLOR,
                    Consts.ACCENT_COLOR
                  ],
                  text: "Cadastrar",
                ),
                SizedBox(height: 30,),
              ],

            )

        )
    );
  }
}
