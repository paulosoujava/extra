import 'package:extra/entity/profile.dart';
import 'package:extra/utils/colors.dart';
import 'package:extra/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PublicProfile extends StatefulWidget {

  Profile profile;


  PublicProfile(this.profile);

  @override
  _PublicProfileState createState() => _PublicProfileState();
}

class _PublicProfileState extends State<PublicProfile> {


  @override
  Widget build(BuildContext context) {

    Profile profile = widget.profile;

    return Scaffold(
      appBar: AppBar(
        title: Text(profile.name),
        actions: <Widget>[
          FlatButton.icon(
              onPressed: () {},
              icon: Icon(
                Icons.chat_bubble_outline,
                color: Colors.white,
              ),
              label: Text("Chat", style: TextStyle(color: Colors.white),))
        ],
      ),
      body: _body(profile),
    );
  }

  _body(Profile profile) {
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
                  flex: 1,
                  child: CircleAvatar(
                    backgroundColor: MyColors.ACCENT_COLOR,
                    minRadius: 40,
                    maxRadius: 40,
                    child: Image.asset(profile.urlPhoto, fit: BoxFit.cover, height: 40, width: 40,),
                  ),
                ),


                Flexible(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, top: 25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: <Widget>[
                         Text(
                           profile.mainFunction,
                           style: GoogleFonts.portLligatSans(
                             fontSize: 25,
                             fontWeight: FontWeight.w700,
                             color: Colors.black,
                           ),
                         ),
                         Text(
                           "${profile.city} - ${profile.state}",
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
              title: Text(profile.description),
            ),

            SizedBox(height: 20,),
            Divider(color: Colors.black38,),
           SizedBox(height: 20,),
            ListTile(
              leading: Icon(Icons.bug_report),
              subtitle: Text("relate o ocorrido"),
              onTap: (){},
              title: Text("Reportar este usuário"),
            ),
          ],
        ),
      ),
    );
  }
}
