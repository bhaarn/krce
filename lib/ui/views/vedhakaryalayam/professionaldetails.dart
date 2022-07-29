import 'package:deepaprakasar/database/crud/user/viewvedprof.dart';
import 'package:deepaprakasar/database/dao/profileved.dart';
import 'package:deepaprakasar/resources/texts/strings.dart';
import 'package:deepaprakasar/utils/contactmethods.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ProfessionalDetails extends StatefulWidget {
  final String city;

  ProfessionalDetails({Key? key, required this.city}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new ProfessionalDetailsState(city);
}

class ProfessionalDetailsState extends State<ProfessionalDetails> {
  String city;
  List<ProfileVed> professionals = [];

  ProfessionalDetailsState(this.city);

  @override
  void initState() {
    cleanSlate();
    viewVedProf(city).then((List<ProfileVed> value) {
      setState(() {
        professionals = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ListTile makeListTile(ProfileVed profileVed) => ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        leading: Container(
          padding: EdgeInsets.only(right: 12.0),
          decoration: new BoxDecoration(
              border: new Border(
                  right: new BorderSide(width: 1.0, color: Colors.white24))),
          child: Icon(Icons.auto_awesome, color: Colors.white),
        ),
        title: Container(
          child: Column(
            children: <Widget>[
              Text(
                profileVed.firstName + Strings.SPACE + profileVed.lastName,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              Divider(
                color: Colors.yellow,
              ),
              Text(
                Strings.DET_VED_VAIDEEHA_DETAILS,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              Text(
                profileVed.gothram +
                   Strings.SPACE + Strings.DET_VED_GOTHRAM + Strings.SPACE +
                    profileVed.subsect +
                    Strings.SPACE +
                    profileVed.sect,
                style: TextStyle(color: Colors.white),
              ),
              Text(
                profileVed.acharyan + Strings.SPACE + Strings.DET_VED_SHISHYA,
                style: TextStyle(color: Colors.white),
              ),
              Divider(
                color: Colors.yellow,
              ),
              Text(
                Strings.DET_VED_LOUKEEKA_DETAILS,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              Text(
                profileVed.occupation,
                style: TextStyle(color: Colors.white),
              ),
              Text(
                profileVed.qualification,
                style: TextStyle(color: Colors.white),
              ),
              Divider(
                color: Colors.yellow,
              ),
              Text(
                Strings.DET_VED_CONTACT_DETAILS,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              Text(
                profileVed.address,
                style: TextStyle(color: Colors.white),
              ),
              RichText(
                text: TextSpan(
                    text: Strings.DET_VIEW_MMM_PRF_PHONE,
                    style: TextStyle(fontSize: 16),
                    children: <TextSpan>[
                      new TextSpan(
                        text: Strings.PLUS + profileVed.contactNumber,
                        style: new TextStyle(
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            color: Colors.green),
                        recognizer: new TapGestureRecognizer()
                          ..onTap = () {
                            launchCaller(Strings.DET_VIEW_MMM_PRF_TEL + profileVed.contactNumber);
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
                        text: Strings.PLUS + profileVed.whatsAppNumber,
                        style: new TextStyle(
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            color: Colors.green),
                        recognizer: new TapGestureRecognizer()
                          ..onTap = () {
                            launchWhatsApp(Strings.DET_VIEW_MMM_PRF_WA_URL_HDR +
                                profileVed.whatsAppNumber +
                                Strings.DET_VIEW_VED_PRF_WA_URL_DTL_PT1 +
                                profileVed.uniqueID +
                                Strings.DET_VIEW_VED_PRF_WA_URL_DTL_PT2);
                          },
                      )
                    ]),
              ),
              Divider(
                color: Colors.yellow,
              ),
            ],
          ),
        ),
        subtitle: Center(
          child: Text(Strings.DET_VED_PROFILE_ID + profileVed.uniqueID,
              style: TextStyle(color: Colors.white)),
        ));

    Card makeCard(ProfileVed profileVed) => Card(
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
            child: makeListTile(profileVed),
          ),
        );

    final makeBody = Container(
      // decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, 1.0)),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: professionals.length,
        itemBuilder: (BuildContext context, int index) {
          return makeCard(professionals[index]);
        },
      ),
    );

    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        title: Text(
          Strings.TITLE_VED_PROFESSIONALS_DETAILS,
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
    professionals = [];
  }
}
