import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:extra/bloc/edit_profile_bloc.dart';
import 'package:extra/entity/extra_job.dart';
import 'package:extra/entity/profile.dart';
import 'package:extra/pages/list_extra.dart';
import 'package:extra/utils/colors.dart';
import 'package:extra/utils/consts.dart';
import 'package:extra/utils/event_bus.dart';
import 'package:extra/utils/sizes.dart';
import 'package:extra/utils/strings.dart';
import 'package:extra/utils/utils.dart';
import 'package:extra/widgets/image_network.dart';
import 'package:extra/widgets/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nice_button/nice_button.dart';

class CrudProfile extends StatefulWidget {
  @override
  _CrudProfileState createState() => _CrudProfileState();
}

class _CrudProfileState extends State<CrudProfile> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  EditProfileBloc bloc = EditProfileBloc();
  File _image;
  var _name = TextEditingController();
  var _email = TextEditingController();
  var _phone = TextEditingController();
  var _profession = TextEditingController();
  var _city = TextEditingController();
  var _state = TextEditingController();
  var _description = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  Profile p;
  bool isLoading = true;

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(Strings.PROFILE),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: IconButton(
                icon: Icon(Icons.playlist_add_check),
                onPressed: () {
                  Utils().pushNoReplacement(context, ListExtras());
                }),
          )
        ],
      ),
      body: isLoading
          ? Loading()
          : Container(
              height: double.infinity,
              child: SingleChildScrollView(
                child: Center(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          _space(),
                          _headerPhoto(),
                          _space(),

                          _listTile(
                              Icon(Icons.supervised_user_circle),
                              Strings.NAME,
                              (_checkNull() || p.name == null)
                                  ? Strings.HINT_NAME
                                  : p.name, () {
                            _bottom(Strings.NAME, 1, 20, _name, _validate,
                                TextInputType.text);
                          }),
                          _listTile(
                              Icon(Icons.email),
                              Strings.EMAIL,
                              (_checkNull() || p.email == null)
                                  ? Strings.HINT_EMAIL
                                  : p.email, () {
                            _bottom(
                                Strings.EMAIL,
                                1,
                                25,
                                _email,
                                (str) =>
                                    Utils().validations(Consts.TYPE_EMAIL, str),
                                TextInputType.emailAddress);
                          }),
                          _listTile(
                              Icon(Icons.phone),
                              Strings.PHONE,
                              (_checkNull() || p.phone == null)
                                  ? Strings.HINT_PHONE
                                  : p.phone, () {
                            _bottom(Strings.PHONE, 1, 14, _phone, _validate,
                                TextInputType.number);
                          }),
                          _listTile(
                              Icon(Icons.school),
                              Strings.PROFESSIONAL,
                              (_checkNull() || p.mainFunction == null)
                                  ? Strings.HINT_PROFESSIONAL
                                  : p.mainFunction, () {
                            _bottom(Strings.PROFESSIONAL, 2, 45, _profession,
                                _validate, TextInputType.text,
                                height: 240);
                          }),
                          _listTile(
                              Icon(Icons.place),
                              Strings.CITY,
                              (_checkNull() || p.city == null)
                                  ? Strings.HINT_CITY
                                  : p.city, () {
                            _bottom(Strings.CITY, 1, 25, _city, _validate,
                                TextInputType.text);
                          }),
                          _listTile(
                              Icon(Icons.place),
                              Strings.STATE,
                              (_checkNull() || p.state == null)
                                  ? Strings.HINT_STATE
                                  : p.state, () {
                            _bottom(Strings.STATE, 1, 2, _state, _validate,
                                TextInputType.text);
                          }),
                          _listTile(
                              Icon(Icons.description),
                              Strings.DESCRIPTION,
                              (_checkNull() || p.description == null)
                                  ? Strings.HINT_DESCRIPTION
                                  : p.description, () {
                            _bottom(Strings.DESCRIPTION, 5, 114, _description,
                                _validate, TextInputType.text,
                                height: 270);
                          }),
                          //END INPUTS
                          _space()
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  //SPACES BETWEEN INPUTS
  _space() {
    return SizedBox(
      height: 20,
    );
  }

//INPTUTS DATA PROFILE
  _checkNull() => (p == null);

  _listTile(Icon leading, String title, String subtitle, Function fnc) {
    return ListTile(
      onTap: () => fnc(),
      leading: leading,
      trailing: Icon(Icons.edit),
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }

  //MODAL BOTTOM SHEET
  _bottom(
      String title,
      int maxLines,
      int maxLength,
      TextEditingController controller,
      FormFieldValidator<String> validator,
      TextInputType keyboardType,
      {double height = 200}) {
    scaffoldKey.currentState.showBodyScrim(true, 0.4);
    scaffoldKey.currentState
        .showBottomSheet((context) => Container(
            height: height,
            child: Card(
              margin: EdgeInsets.all(0),
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ListTile(
                      trailing: Icon(Icons.insert_emoticon),
                      title: Text(title),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10, right: 10, top: 0),
                      child: Form(
                        key: _formKey,
                        child: TextFormField(
                          maxLines: maxLines,
                          maxLength: maxLength,
                          controller: controller,
                          validator: validator,
                          keyboardType: keyboardType,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            Strings.CANCEL,
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                        FlatButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              Navigator.pop(context);
                              String txt = controller.text;
                              //******************************
                              //REVER FILTRO MAIS TARDE
                              p.filter = Strings.ALL;
                              //******************************

                              switch (title) {
                                case Strings.NAME:
                                  p.name = txt;
                                  break;
                                case Strings.EMAIL:
                                  p.email = txt;
                                  break;
                                case Strings.PHONE:
                                  p.phone = txt;
                                  break;
                                case Strings.CITY:
                                  p.city = txt;
                                  break;
                                case Strings.STATE:
                                  p.state = txt;
                                  break;
                                case Strings.PROFESSIONAL:
                                  p.mainFunction = txt;
                                  break;
                                case Strings.DESCRIPTION:
                                  p.description = txt;
                                  break;
                              }
                              setState(() {
                                p.save();
                                _sendBus();
                              });
                            } else {
                              return null;
                            }
                          },
                          child: Text(
                            Strings.SAVE,
                            style: TextStyle(color: Colors.blue),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )))
        .closed
        .whenComplete(() {
      setState(() {
        scaffoldKey.currentState.showBodyScrim(false, 0.0);
      });
    });
  }

//VALIDATE STRINGS INPUTS EMPTY
  String _validate(str) => Utils().validations(Consts.TYPE_TEXT, str);

//LOAD DATA
  loadData() async {
    p = await Profile.get();
    if (p != null) {
      print(p);
      setState(() {
        _name.text = p.name;
        _email.text = p.email;
        _phone.text = p.phone;
        _profession.text = p.mainFunction;
        _city.text = p.city;
        _state.text = p.state;
        _description.text = p.description;
        ;
      });
    } else {
      p = Profile();
    }
    setState(() {
      isLoading = false;
    });
  }

  //IMAGE CONTAINER
  _headerPhoto() {
    return Stack(
      children: <Widget>[
        Container(
          width: 150.0,
          height: 150.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: _witchImage(),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.all(Radius.circular(90.0)),
            border: Border.all(
              color: MyColors.PRIMARY_COLOR,
              width: 1.0,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 90, top: 110),
          child: NiceButton(
            radius: 50,
            width: 50,
            mini: true,
            icon: Icons.photo_camera,
            background: MyColors.PRIMARY_COLOR,
            onPressed: () {
              _getImage();
            },
          ),
        ),
      ],
    );
  }

  _witchImage() {
    print(p);
    if (_image != null) return FileImage(_image);
    if (p == null || p.pathPhoto == null)
      return AssetImage(
        "assets/images/avatar.png",
      );
    else {
      return FileImage(File(Utils().replace(p.pathPhoto)));
    }
  }

  _getImage() async {
    Profile p = await Profile.get();
    print(p);
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
      p.pathPhoto = image.toString();
      p.save();
      _sendBus();
    });
    if (_image != null) bloc.uploadFile(image);
  }

  _sendBus() {
    EventBus.get(context).sendEvent(ExtraJob(actionEvent: Consts.EVENT_JOB));
  }
}
