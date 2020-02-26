import 'package:extra/entity/profile.dart';
import 'package:extra/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Terms extends StatefulWidget {


  @override
  _TermsState createState() => _TermsState();
}

class _TermsState extends State<Terms> {


  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(
        title: Text("Termos e Compromisso"),

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
                         Utils().title(context, "Termos & Compromisso"),
                         SizedBox(height: 10,),
                         Text(
                           "Sua responsabilidade",
                           style: GoogleFonts.portLligatSans(
                             fontSize: 25,
                             fontWeight: FontWeight.w700,
                             color: Colors.black,
                           ),
                         ),
                         Text(
                           "Ser honesto!",
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
              leading: Icon(Icons.warning),
              subtitle: Text("Seus dados ficam visiveis a todos ou seja, seu telefone, email, foto e o que vocÊ cadastrar"),
            ),
            SizedBox(height: 20,),
            ListTile(
              leading: Icon(Icons.favorite),
              subtitle: Text("Por tempo indeterminado o aplicativo será gratuito, assim que atingir a conta de gratuidade do "
                  " servidor GOOGLE avisaremos pelo aplicativo quais decisões vamos tomar, NÃO PEDIMOS SENHA E NEM NÚMERDO DE "
                  " CARTÃO DE CRÉDITO E NEM ENVIAMOS EMAIL SOLICITANDO O MESMO!!"),
            ),
            SizedBox(height: 20,),
            ListTile(
              leading: Icon(Icons.playlist_add_check),
              subtitle: Text("Você tem uma cota de 1 pedido para achar extras, ou seja, você pode cadastrar um pedito exemplo: "
                  "preciso de 5 graçons para um evento em Floria dia tal horá tal, isto conta como um pedido de extra após atigir sua "
                  "cota somente no outro mês você pode solicitar novamente, ou a não se que voce coloque crédito para isso entre em "
                  "contato conosco clicando lá no menu dos 3 pontinhos em sobre ou enviando um email para paulosoujava@gmail.com"),
            ),
            SizedBox(height: 20,),
            ListTile(
              leading: Icon(Icons.account_box),
              subtitle: Text("Todos os dados colocado por você são de sua responsabilidade, este aplicativo não negocia valores e nem "
                  "faz nenhum tipo de pagamento a pessoas, as negociações estão por conta de vocês, disponibilizamos um bate papo"
                  " para você conversar com a outra pessoa pedimos que mantenham suas conversas por este aplicativo para evitar "
                  "possiveis transtornos. "),
            ),
            SizedBox(height: 20,),
            ListTile(
              leading: Icon(Icons.help),
              subtitle: Text("Contatos abaixo:  "),
              title: Text("Você tem alguma dúvida"),
            ),
            ListTile(
              leading: Icon(Icons.phone),
              subtitle: Text("Contato por telefone"),
              onTap: (){},
              title: Text("Ligar"),
            ),
            ListTile(
              leading: Icon(Icons.email),
              subtitle: Text("Contatos por email"),
              onTap: (){},
              title: Text("Email"),
            ),

            SizedBox(height: 20,),



          ],
        ),
      ),
    );
  }
}
