import 'package:extra/pages/home.dart';
import 'package:extra/pages/list_extra.dart';
import 'package:extra/utils/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grouped_buttons/grouped_buttons.dart';

class ProfileEdit extends StatefulWidget {
  @override
  _ProfileEditState createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
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

  _submitButton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 15),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.shade200,
                offset: Offset(2, 2),
                blurRadius: 5,
                spreadRadius: 1)
          ],
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Consts.PRIMARY_COLOR, Consts.ACCENT_COLOR])),
      child: Text(
        'Cadastrar ',
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
    );
  }

  _textFields() {
    return Column(
      children: <Widget>[
        _entryField("Nome", "digite seu nome completo"),
        _entryField("Email ", "qual o seu melhor email"),
        _entryField("Num. Celular ", " com ddd (xx) xxx-xxxxxx"),
        _entryField("Profissão ", "No que você é bom?"),
        _entryField("Cidade ", "extra para qual cidade?"),
        _entryField("Estado ", "extra para qual estado?"),
        _entryField("Descrição ",
            "descreva um pouco de suas habilidades isto ajuda a ser chamado no extra",
            isDesc: true),
        //_entryField("Senha", isPassword: true),
      ],
    );
  }

  @override
  build(BuildContext context) {
    CheckboxGroup(labels: <String>[
      "Todos    ",
      "Cidade   ",
      "Estado   ",
    ], onSelected: (List<String> checked) => print(checked.toString()));

    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: IconButton(
                icon: Icon(Icons.playlist_add_check), onPressed: () {
              Consts().push(context, ListExtras() );
            }),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              InkWell(
                borderRadius: BorderRadius.circular(90),
                onTap: () {},
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  maxRadius: 45,
                  minRadius: 45,
                  child: Image.asset(
                    "assets/images/avatar.png",
                    width: 70,
                    height: 70,
                  ),
                ),
              ),
              Text("cadastre sua foto"),
              SizedBox(
                height: 10,
              ),
              Divider(
                color: Colors.black38,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text("Filtrar rede por:",
                          textAlign: TextAlign.start,
                          style: GoogleFonts.portLligatSans(
                            textStyle: Theme.of(context).textTheme.display1,
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          )),
                      RadioButtonGroup(
                          orientation: GroupedButtonsOrientation.HORIZONTAL,
                          labels: <String>[
                            "Todos     ",
                            "Cidade    ",
                            "Estado    ",
                          ],
                          onSelected: (String selected) => print(selected)),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              _textFields(),
              SizedBox(
                height: 20,
              ),
              _submitButton(),
            ],
          ),
        ),
      ),
    );
  }
}
