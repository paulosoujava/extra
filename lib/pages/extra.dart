import 'package:extra/entity/extra_job.dart';
import 'package:extra/entity/profile.dart';
import 'package:extra/utils/colors.dart';
import 'package:extra/utils/consts.dart';
import 'package:extra/utils/strings.dart';
import 'package:extra/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nice_button/nice_button.dart';

class Extra extends StatefulWidget {
  @override
  _ExtraState createState() => _ExtraState();
}

class _ExtraState extends State<Extra> {

  var city = TextEditingController();
  var _where = TextEditingController();
  var _description = TextEditingController();
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body:Center(
            child: ListView(
              shrinkWrap: true,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    FlatButton.icon(

                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back_ios, color: MyColors.PRIMARY_COLOR,),
                      label: Text(Strings.BACK, style: TextStyle(color: MyColors.PRIMARY_COLOR,),),
                    ),
                  ],
                ),
                Utils().title(context, Strings.ANNONCEMENT_CREATE),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: _textFields(),
                  ),
                ),
                NiceButton(
                  width: double.infinity,
                  gradientColors: [
                    MyColors.PRIMARY_COLOR,
                    MyColors.ACCENT_COLOR
                  ],
                  onPressed: (){
                    if( _formKey.currentState.validate() ){

                      ExtraJob(
                        description: _description.text,
                        where: _where.text,
                        profile: Profile() //<- GET CURRENT PROFILE
                      );
                    }else{
                      return null;
                    }
                  },
                  text: Strings.CREATE,
                ),
                SizedBox(height: 30,),
              ],

            )

        )
    );
  }


  _entryField(String title, String hint,FormFieldValidator<String> validator, TextEditingController controller, {bool isDesc = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            validator: validator,
              controller: controller,
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

  String _validate(str) => Utils().validations(Consts.TYPE_TEXT, str);
  _textFields() {
    return Column(
      children: <Widget>[
        _entryField(Strings.WORK_WHERE, Strings.WORK_CITY, _validate, _where,),
        _entryField(Strings.WHAT_DO_YOU_WANT, Strings.WHAT_DO_YOU_WANT_HINT,  _validate, _description, isDesc: true),
        //_entryField("Senha", isPassword: true),
      ],
    );
  }
}
