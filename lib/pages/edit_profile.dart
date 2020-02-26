import 'dart:io';

import 'package:extra/entity/profile.dart';
import 'package:extra/pages/list_extra.dart';
import 'package:extra/utils/Sizes.dart';

import 'package:extra/utils/colors.dart';
import 'package:extra/utils/consts.dart';
import 'package:extra/utils/utils.dart';
import 'package:extra/utils/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nice_button/nice_button.dart';

class ProfileEdit extends StatefulWidget {
  @override
  _ProfileEditState createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {

  File _image;
  var _name = TextEditingController();
  var _email = TextEditingController();
  var _phone = TextEditingController();
  var _profession = TextEditingController();
  var _city = TextEditingController();
  var _state = TextEditingController();
  var _description = TextEditingController();
  var _formKey = GlobalKey<FormState>();

  bool isSelectedAll = true;
  bool isSelectedCity = false;
  bool isSelectedState = false;

  @override
  build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.PROFILE),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: IconButton(
                icon: Icon(Icons.playlist_add_check),
                onPressed: () {
                  Utils().push(context, ListExtras());
                }),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _header(),
                _radioButtons(),
                _textFields(),
                _submitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  _entryField(String title, String hint, TextEditingController controller,
      FormFieldValidator<String> validator,
      {bool isDesc = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
              controller: controller,
              validator: validator,
              maxLength: isDesc ? 300 : 150,
              maxLines: isDesc ? 10 : 1,
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

  _submitButton() {
    return Center(
      child: NiceButton(
        width: Sizes.MY_WIDHT_CARD,
        elevation: 4,
        text: Strings.SAVE,
        gradientColors: [MyColors.PRIMARY_COLOR, MyColors.ACCENT_COLOR],
        onPressed: () {
          if (_formKey.currentState.validate()) {
            if (_image == null || _image.toString().isEmpty) {
              Utils().basicAlert(context, Strings.OK_I_UNDERSTAND, Strings.OPS, Strings.WHERE_THE_IMAGE);
            } else {
              Profile(
                  name: _name.text,
                  email: _email.text,
                  phone: _phone.text,
                  city: _city.text,
                  state: _state.text,
                  mainFunction: _profession.text,
                  description: _description.text,
                  limit: 1,
                  isReported: false,
                  month: DateTime.now().month.toString(),
                  urlPhoto: _image.toString());
              print("OK CADASTRA");
            }
          } else {
            return null;
          }
        },
      ),
    );
  }

  _textFields() {
    print("${_email.text.isEmpty} <==");
    return Column(
      children: <Widget>[
        _entryField(Strings.NAME, Strings.HINT_NAME, _name, _validate),
        _entryField(Strings.EMAIL, Strings.HINT_EMAIL, _email,
            (str) => Utils().validations(Consts.TYPE_EMAIL, str)),
        _entryField(Strings.PHONE, Strings.HINT_PHONE, _phone, _validate),
        _entryField(Strings.PROFESSIONAL, Strings.HINT_PROFESSIONAL, _profession,
            _validate),
        _entryField(Strings.CITY, Strings.HINT_CITY, _city, _validate),
        _entryField(Strings.STATE, Strings.HINT_STATE, _state, _validate),
        _entryField(
          Strings.DESCRIPTION,
          Strings.HINT_DESCRIPTION,
          _description,
          _validate,
          isDesc: true,
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  String _validate(str) => Utils().validations(Consts.TYPE_TEXT, str);

  void _alert(context) {
    Utils().basicAlert(
        context, Strings.OK_I_UNDERSTAND, Strings.LIMIT, Strings.WARNING);
  }

  _radioButtons() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: Text(Strings.FILTER,
                style: GoogleFonts.portLligatSans(
                  textStyle: Theme.of(context).textTheme.display1,
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                )),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              InkWell(
                child: _itemChoice(Strings.ALL, 1),
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  setState(() {
                    isSelectedAll = true;
                    isSelectedCity = false;
                    isSelectedState = false;
                  });
                },
              ),
              InkWell(
                child: _itemChoice(Strings.CITY, 2),
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  setState(() {
                    isSelectedAll = false;
                    isSelectedCity = true;
                    isSelectedState = false;
                  });
                },
              ),
              InkWell(
                child: _itemChoice(Strings.STATE, 3),
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  setState(() {
                    isSelectedAll = false;
                    isSelectedCity = false;
                    isSelectedState = true;
                  });
                },
              ),
            ],
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }

  _header() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Stack(
              children: <Widget>[
                _image == null
                    ? Image.asset(
                        "assets/images/avatar.png",
                        width: 120,
                        height: 120,
                      )
                    : Image.file(
                        _image,
                        width: 120,
                        height: 120,
                      ),
                Container(
                  margin: EdgeInsets.only(top: 85, left: 75),
                  child: FloatingActionButton(
                    onPressed: () {
                      _getImage();
                    },
                    child: Icon(Icons.camera_alt),
                    mini: true,
                  ),
                )
              ],
            ),
            InkWell(
              onTap: () {
                _alert(context);
              },
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Text(Strings.LIMIT),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Divider(
          color: Colors.black38,
        ),
      ],
    );
  }

  _itemChoice(String name, int type) {
    bool isSelected = false;
    switch (type) {
      case 1:
        if (isSelectedAll) isSelected = isSelectedAll;
        break;
      case 2:
        if (isSelectedCity) isSelected = isSelectedCity;
        break;
      case 3:
        if (isSelectedState) isSelected = isSelectedState;
        break;
    }

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? MyColors.PRIMARY_COLOR : Colors.transparent,
          border: Border.all(
            color: Colors.black,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        height: 45,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(name,
              style: GoogleFonts.portLligatSans(
                textStyle: Theme.of(context).textTheme.display1,
                fontSize: 25,
                fontWeight: FontWeight.w700,
                color: isSelected ? Colors.white : Colors.black,
              )),
        ),
      ),
    );
  }
}
