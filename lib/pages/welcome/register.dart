import 'package:extra/api/api_response.dart';
import 'package:extra/bloc/register_bloc.dart';
import 'package:extra/pages/home.dart';
import 'package:extra/pages/welcome/welcome.dart';
import 'package:extra/utils/colors.dart';
import 'package:extra/utils/consts.dart';
import 'package:extra/utils/strings.dart';
import 'package:extra/utils/utils.dart';
import 'package:extra/widgets/back.dart';
import 'package:extra/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:nice_button/nice_button.dart';

class Register extends StatefulWidget {

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool isCheck = false;
  bool isLoading = false;

  TextEditingController _login = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _repPassword = TextEditingController();
  var _formKey = GlobalKey<FormState>();

  WelcomeBloc bloc = WelcomeBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: isLoading ? Loading() : _body()));
  }

  _body() {
    return ListView(
      shrinkWrap: true,
      children: [
        Back(Welcome(), Strings.NEW_USER),
        Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: _textFields(),
          ),
        ),
        Center(
          child: CheckboxListTile(
            title: const Text(
              Strings.ACCEPT_TERMS,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            value: isCheck,
            onChanged: (bool value) {
              setState(() {
                isCheck = value;
              });
            },
            secondary: const Icon(Icons.library_books),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        NiceButton(
          width: double.infinity,
          gradientColors: [MyColors.PRIMARY_COLOR, MyColors.ACCENT_COLOR],
          text: Strings.CREATE,
          onPressed: () async {
            _updateUI(true);
            if (_formKey.currentState.validate()) {
              if (isCheck) {
                ApiResponse response =
                    await bloc.doCreateUser(_login.text, _password.text);
                if (response.ok) {
                    Utils().allDataProfileOk();
                  _alert(Strings.OK_I_UNDERSTAND, Strings.OK,
                      Strings.CREATE_SUCCESS_USER,
                      isBack: true, page: Home());
                } else {
                  _alert(Strings.OK_I_UNDERSTAND, Strings.OK,
                      "${Strings.ERROR_ACTION} ${Utils().errorFirebase(response.msg)}");
                }
              } else {
                _alert(Strings.OK_I_UNDERSTAND, Strings.OPS,
                    Strings.ACCEPT_TERMS_WARNING);
              }
            } else {
              _updateUI(false);
              return null;

            }
            _updateUI(false);
          },
        ),

      ],
    );
  }

  _alert(String btn, String title, String content,
      {bool isBack = false, Widget page}) {
    if (isBack)
      Utils()
          .basicAlert(context, btn, title, content, isBack: isBack, page: page);
    else
      Utils().basicAlert(context, btn, title, content);
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
                  filled: true))
        ],
      ),
    );
  }

  _textFields() {
    return Column(
      children: <Widget>[
        _entryField(
          Strings.EMAIL,
          Strings.HINT_EMAIL,
          _login,
          _validateEmail,
        ),
        _entryField(
          Strings.PASSWORD,
          Strings.HINT_PASSWORD,
          _password,
          _validate,
          isPass: true,
        ),
        _entryField(
          Strings.REP_PASS,
          Strings.HINT_REP_PASS,
          _repPassword,
          _validatePass,
          isPass: true,
        ),
        //_entryField("Senha", isPassword: true),
      ],
    );
  }

  String _validate(str) => Utils().validations(Consts.TYPE_TEXT, str);

  String _validateEmail(str) => Utils().validations(Consts.TYPE_EMAIL, str);

  String _validatePass(str) {
    if (str.isEmpty) return Strings.REQUIRED;
    if (str != _password.text) {
      return Strings.NO_MATCH_PASSWORD;
    } else {
      return null;
    }
  }

  

  void _updateUI(bool isChange) {
    setState(() {
      isLoading = isChange;
    });
  }
}
