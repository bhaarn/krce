import 'package:deepaprakasar/database/crud/user/viewomm.dart';
import 'package:deepaprakasar/database/dao/profileomm.dart';
import 'package:deepaprakasar/resources/texts/strings.dart';
import 'package:deepaprakasar/utils/sharedpreferences.dart';
import 'package:flutter/material.dart';

class OthMatriProfiles extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => OthMatriProfilesState();
}

class OthMatriProfilesState extends State<OthMatriProfiles> {
  List<ProfileOmm> profileOmms = [];

  @override
  void initState() {
    cleanSlate();
    viewOmm(SharedPrefs().username).then((List<ProfileOmm> value) {
      setState(() {
        profileOmms = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ListTile makeListTile(ProfileOmm profileOmms) => ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: new BoxDecoration(
                border: new Border(
                    right: new BorderSide(width: 1.0, color: Colors.white24))),
            child: Icon(Icons.auto_awesome, color: Colors.white),
          ),
          title: Text(
            Strings.DET_OMM_PROFILES +
                profileOmms.uniqueId +
                Strings.LINE_BREAK + Strings.LINE_BREAK +
                profileOmms.profile,
            style: TextStyle(color: Colors.white),
          ),

        );

    Card makeCard(ProfileOmm profileOmms) => Card(
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
            child: makeListTile(profileOmms),
          ),
        );

    final makeBody = Container(
      // decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, 1.0)),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: profileOmms.length,
        itemBuilder: (BuildContext context, int index) {
          return makeCard(profileOmms[index]);
        },
      ),
    );

    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        title: Text(
          Strings.TITLE_OMM_PROFILES,
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
    profileOmms = [];
  }
}
