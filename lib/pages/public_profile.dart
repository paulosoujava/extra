import 'package:extra/entity/profile.dart';
import 'package:extra/utils/colors.dart';
import 'package:extra/utils/strings.dart';
import 'package:extra/utils/utils.dart';
import 'package:extra/widgets/image_network.dart';
import 'package:extra/widgets/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class PublicProfile extends StatefulWidget {
  @override
  _PublicProfileState createState() => _PublicProfileState();
}

class _PublicProfileState extends State<PublicProfile> {
  Profile profile;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    print(profile);
    return isLoading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text(profile.name),
              actions: <Widget>[
                FlatButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      Icons.chat_bubble_outline,
                      color: Colors.white,
                    ),
                    label: Text(
                      Strings.CHAT_VIEW,
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            ),
            body: _body(profile),
          );
  }

  _loadData() async {
    _updateUI(true);
    profile = await Profile.get();
    _updateUI(false);
  }

  _updateUI(bool ok) {
    setState(() {
      isLoading = ok;
    });
  }

  _body(Profile profile) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  flex: 2,
                  child: Utils().roundedImage(profile.urlPhoto, w: 120, h: 120),
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
                        Divider(
                          color: Colors.black38,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            ListTile(
              leading: Icon(Icons.phone),
              subtitle: Text(Strings.CONTACT_PHONE),
              onTap: () {
                _launchURL("tel:${profile.phone}");
              },
              title: Text(Strings.PHONE),
            ),
            ListTile(
              leading: Icon(Icons.email),
              subtitle: Text(Strings.CONTACT_EMAIL),
              onTap: () {
                _launchURL(
                    "mailto:${profile.email}?subject=Contato From APP&body=Seu texto...");
              },
              title: Text(Strings.EMAIL),
            ),
            ListTile(
              leading: Icon(Icons.account_box),
              onTap: null,
              title: Text(profile.description),
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              color: Colors.black38,
            ),
            SizedBox(
              height: 20,
            ),
            ListTile(
              leading: Icon(Icons.bug_report),
              subtitle: Text(Strings.SUBTITLE_REPORT),
              onTap: () {
                _launchURL(
                    "mailto:paulosoujava@gmail.com?subject=Reposrtar&body=user:${profile.email} sid: ${profile.id} seu texto: ");
              },
              title: Text(Strings.TITLE_REPORT),
            ),
          ],
        ),
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
