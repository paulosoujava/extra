import 'package:extra/entity/profile.dart';
import 'package:extra/utils/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class About extends StatefulWidget {


  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {


  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(
        title: Text("Sobre nós"),

      ),
      body: _body(),
    );
  }

  _body() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, top: 25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: <Widget>[
                         Consts().title(context, "Sobre nós"),
                         SizedBox(height: 10,),
                         Text(
                           "Paulo Oliveira",
                           style: GoogleFonts.portLligatSans(
                             fontSize: 25,
                             fontWeight: FontWeight.w700,
                             color: Colors.black,
                           ),
                         ),
                         Text(
                           "Desenvolvedor",
                           style: GoogleFonts.portLligatSans(
                             fontSize: 20,
                             fontWeight: FontWeight.w500,
                             color: Colors.black,
                           ),
                         ),
                         Text(
                           "Vs: 0.0.1",
                           style: GoogleFonts.portLligatSans(
                             fontSize: 20,
                             fontWeight: FontWeight.w500,
                             color: Colors.black,
                           ),
                         ),
                         Divider(color: Colors.black38,)
                       ],
                    ),
                  ),
                ),

              ],
            ),
            SizedBox(height: 30,),
            ListTile(
              leading: Icon(Icons.phone),
              subtitle: Text("Contatos por telefone"),
              onTap: (){},
              title: Text("Ligar"),
            ),
            ListTile(
              leading: Icon(Icons.email),
              subtitle: Text("Contatos por email"),
              onTap: (){},
              title: Text("Email"),
            ),
            ListTile(
              leading: Icon(Icons.account_box),
              onTap: null,
              title: Text("A ideia veio de um amigo o Marquinho, um aplicativo para "
                  "serviços extra, ou seja, fazer aquele dim dim por fora, sendo assim surgiu o Extra óóóhh. "
                  "Um aplicativo gratuito, ** enquanto durar a gratuidado do servidor google **, para você e quem quiser"
                  " cadastrar seu perfil e disponibilizar alguma atividade extra.\n"
                  " Ficou confuso ainda?\nVou exemplificar.ls"
                  " imageine que você excelete pintor esta querendo fazer um extra "
                  " e fica sabendo de um maravilhoso aplicativo que pessoas divulgam extras, você que é um cara experto e inteligênte "
                  "faz seu cadastro e ao visualizar a vaga do extra entra em contato pelo chat no prórpio aplicativo e combina "
                  "tuo certinho e R\$R\$R\$ dim dim no bolso, mas caso é voce que está precisando de um auxílio em um evento ou uma obra "
                  "que você trabalhe então você pode divulgar a vaga, exemplo: Estou precisando de um pintor para  os dias tais no horário tal "
                  " na cidade e estado tal.... Viu simples né!! "),
            ),

            SizedBox(height: 20,),
            Divider(color: Colors.black38,),


          ],
        ),
      ),
    );
  }
}
