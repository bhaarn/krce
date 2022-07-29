import 'package:deepaprakasar/database/crud/user/viewkai.dart';
import 'package:deepaprakasar/database/dao/profilekai.dart';
import 'package:deepaprakasar/resources/texts/strings.dart';
import 'package:deepaprakasar/utils/contactmethods.dart';
import 'package:deepaprakasar/utils/sharedpreferences.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ViewKainKaryam extends StatefulWidget {
  @override
  ViewKainKaryamState createState() => ViewKainKaryamState();
}

class ViewKainKaryamState extends State<ViewKainKaryam> {
  List<ProfileKai> profileKais = [];
  late String contactNumber;
  late String whatsAppNumber;

  @override
  void initState() {
    super.initState();
    cleanSlate();
    viewKai(SharedPrefs().username).then((List<ProfileKai> value) {
      setState(() {
        profileKais = value;
        contactNumber = profileKais.first.contactNumber.toString();
        whatsAppNumber = profileKais.first.whatsAppNumber.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    ListTile makeListTile(ProfileKai profileKai, int index) => ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 2.0, vertical: 10.0),
      leading: Container(
        padding: EdgeInsets.only(right: 5.0),
        decoration: new BoxDecoration(
            border: new Border(
                right: new BorderSide(width: 1.0, color: Colors.white24))),
        child: Icon(Icons.auto_awesome, color: Colors.white),
      ),
      title: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              (profileKai.subKainkaryam + Strings.SPACE + Strings.FOR +
                  Strings.SPACE + profileKai.kainkaryam),
              style: TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
            Divider(
              color: Colors.yellow,
            ),
            Text(
              profileKai.details,
              style: TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
            Divider(
              color: Colors.yellow,
            ),
            Text(
              Strings.DET_VIEW_MMM_PRF_CONTACT_DETAILS,
              style: TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
            RichText(
              text: TextSpan(
                  text: Strings.DET_VIEW_MMM_PRF_PHONE,
                  style: TextStyle(fontSize: 16),
                  children: <TextSpan>[
                    new TextSpan(
                      text: Strings.PLUS + contactNumber,
                      style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          color: Colors.green),
                      recognizer: new TapGestureRecognizer()
                        ..onTap = () {
                          launchCaller(Strings.DET_VIEW_MMM_PRF_TEL + contactNumber);
                        },
                    )
                  ]),
            ),
            RichText(
              text: TextSpan(
                  text: Strings.DET_VIEW_MMM_PRF_WA,
                  style: TextStyle(fontSize: 16),
                  children: <TextSpan>[
                    new TextSpan(
                      text: Strings.PLUS + contactNumber,
                      style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          color: Colors.green),
                      recognizer: new TapGestureRecognizer()
                        ..onTap = () {
                          launchWhatsApp(Strings.DET_VIEW_MMM_PRF_WA_URL_HDR +
                              whatsAppNumber +
                              Strings.DET_VIEW_MMM_PRF_WA_URL_DTL_PT1 +
                              profileKai.uniqueID +
                              Strings.DET_VIEW_MMM_PRF_WA_URL_DTL_PT2);
                        },
                    )
                  ]),
            ),
            Divider(
              color: Colors.yellow,
            ),
            Text(Strings.DET_KAI_REQ_DATE + Strings.SPACE + Strings.HYPHEN +
                Strings.SPACE + profileKai.requiredDate,
                style: TextStyle(color: Colors.white)),
            Text(Strings.DET_VIEW_MMM_PRF_PROFILE_ID + profileKai.uniqueID,
                style: TextStyle(color: Colors.white)),
            Divider(
              color: Colors.yellow,
            ),
          ],
        ),
      ),
    );

    Card makeCard(ProfileKai profileKai, int index) => Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
        child: makeListTile(profileKai, index),
      ),
    );

    final makeBody = Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: profileKais.length,
        itemBuilder: (BuildContext context, int index) {
          return makeCard(profileKais[index], index);
        },
      ),
    );

    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        title: Text(
          Strings.TITLE_MMM_VIEW_PROFILES,
          style: new TextStyle(color: Colors.white),
        ),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: makeBody,
    );
  }

  void cleanSlate() {
    profileKais = [];
  }
}