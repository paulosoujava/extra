import 'package:extra/utils/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nice_button/nice_button.dart';

class Extra extends StatefulWidget {
  @override
  _ExtraState createState() => _ExtraState();
}

class _ExtraState extends State<Extra> {
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
                      icon: Icon(Icons.arrow_back_ios, color: Consts.PRIMARY_COLOR,),
                      label: Text("Voltar", style: TextStyle(color: Consts.PRIMARY_COLOR,),),
                    ),
                  ],
                ),
                Consts().title(context, "Cadastrar um anúncio "),
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


  _entryField(String title, String hint, {bool isDesc = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
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

  _textFields() {
    return Column(
      children: <Widget>[
        _entryField("Trabalhar onde? ", "Qual cidade estado?"),
        _entryField("descreva o que precisa ", "Ex.: Preciso de auxiliar para trabalhar", isDesc: true),
        //_entryField("Senha", isPassword: true),
      ],
    );
  }
}
