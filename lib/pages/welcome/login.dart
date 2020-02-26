import 'dart:collection';

import 'package:extra/api/api_response.dart';
import 'package:extra/bloc/register_bloc.dart';
import 'package:extra/service/firebase_service.dart';
import 'package:extra/utils/colors.dart';
import 'package:extra/utils/consts.dart';
import 'package:extra/utils/strings.dart';
import 'package:extra/utils/utils.dart';
import 'package:extra/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:nice_button/nice_button.dart';

class Login extends StatefulWidget {
  bool isScroable;

  Login({this.isScroable = false});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _login = TextEditingController();
  TextEditingController _password = TextEditingController();
  var _formKey = GlobalKey<FormState>();

  TextEditingController _passwordReset = TextEditingController();
  var _formKeyForgetPass = GlobalKey<FormState>();
  WelcomeBloc bloc = WelcomeBloc();
  bool isLoading = false;
  bool isLoadingResetPass = false;
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: isLoading ? Loading() : _body(),
      ),
    );
  }

  _body() {
    return ListView(
      shrinkWrap: true,
      children: [
        _showBack(),
        Utils().title(context, Strings.LOGIN),
        Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: _textFields(),
          ),
        ),
        NiceButton(
          onPressed: () {
            if (_formKey.currentState.validate()) {
              print("OK");
            } else {
              return null;
            }
          },
          width: double.infinity,
          gradientColors: [MyColors.PRIMARY_COLOR, MyColors.ACCENT_COLOR],
          text: Strings.ACCESS,
        ),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }

  _entryField(String title, String hint, TextEditingController controller,
      FormFieldValidator<String> validator,
      {bool isPass = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: controller,
            validator: validator,
            obscureText: isPass,
            decoration: InputDecoration(
                hintText: hint,
                labelText: title,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                fillColor: Color(0xfff),
                filled: true),
          )
        ],
      ),
    );
  }

  String _validate(str) => Utils().validations(Consts.TYPE_TEXT, str);

  String _validateEmail(str) => Utils().validations(Consts.TYPE_EMAIL, str);

  _textFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        _entryField(Strings.EMAIL, Strings.HINT_EMAIL, _login, _validateEmail),
        _entryField(
            Strings.PASSWORD, Strings.HINT_PASSWORD, _password, _validate,
            isPass: true),
        InkWell(
          onTap: () {
            _inputDialog(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(Strings.FORGET_PASSWORD),
          ),
        ),

        //_entryField("Senha", isPassword: true),
      ],
    );
  }

  _showBack() {
    return Row(
      children: <Widget>[
        widget.isScroable
            ? Container()
            : FlatButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: MyColors.PRIMARY_COLOR,
                ),
                label: Text(
                  Strings.BACK,
                  style: TextStyle(
                    color: MyColors.PRIMARY_COLOR,
                  ),
                ),
              ),
      ],
    );
  }

  Future<String> _inputDialog(BuildContext context) async {
    return showDialog<String>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return isLoadingResetPass
            ? Loading(
                hasSizeTitle: true,
                sizeTitle1: 10,
                sizeTitle2: 10,
                sizeTitle3: 10,
                sizeLoading: 20,
                sizeHeight: 150,
                sizeWidth: 180,
              )
            : AlertDialog(
                title: Text(Strings.FORGET_PASSWORD),
                content: Row(
                  children: <Widget>[
                    Expanded(
                        child: Form(
                      child: TextFormField(
                        controller: _passwordReset,
                        validator: _validateEmail,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            hintText: Strings.EMAIL,
                            labelText: Strings.HINT_EMAIL,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            filled: true),
                      ),
                      key: _formKeyForgetPass,
                    ))
                  ],
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text(
                      Strings.CANCEL,
                      style: TextStyle(color: MyColors.PRIMARY_COLOR),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  FlatButton(
                    child: Text(
                      Strings.SEND,
                      style: TextStyle(color: MyColors.PRIMARY_COLOR),
                    ),
                    onPressed: () async {
                      _loadingWait();
                      if (_formKeyForgetPass.currentState.validate()) {
                        ApiResponse response =
                            await bloc.doResetLogin(_passwordReset.text);
                        if (response.ok) {
                          _close();
                          Utils().basicAlert(context, Strings.OK,
                              Strings.FORGET_PASSWORD, Strings.FORGET_TEXT);
                        } else {
                          _close();

                          Utils().basicAlert(context, Strings.OK, Strings.OPS,
                              Utils().errorFirebase(response.msg));
                        }
                      } else {
                        return null;
                      }
                    },
                  ),
                ],
              );
      },
    );
  }

  _close() {
    Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
  }

  _loadingWait() {
    showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  key: _keyLoader,
                  backgroundColor: Colors.white,
                  children: <Widget>[
                    Center(
                        child: Loading(
                      hasSizeTitle: true,
                      sizeTitle1: 10,
                      sizeTitle2: 10,
                      sizeTitle3: 10,
                      sizeLoading: 20,
                      sizeHeight: 190,
                      sizeWidth: 180,
                    ))
                  ]));
        });
  }
}
