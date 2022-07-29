import 'package:deepaprakasar/database/crud/user/viewous.dart';
import 'package:deepaprakasar/database/dao/profileous.dart';
import 'package:deepaprakasar/resources/texts/strings.dart';
import 'package:deepaprakasar/utils/sharedpreferences.dart';
import 'package:flutter/material.dart';

class ViewOusAppointment extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ViewOusAppointmentState();
}

class ViewOusAppointmentState extends State<ViewOusAppointment> {
  List<OusUser> ousUsers = [];

  @override
  void initState() {
    cleanSlate();
    viewOus(SharedPrefs().username).then((List<OusUser> value) {
      setState(() {
        ousUsers = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ListTile makeListTile(OusUser ousUsers) => ListTile(
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
            ousUsers.firstName +
                Strings.SPACE +
                ousUsers.lastName +
                Strings.LINE_BREAK +
                ousUsers.ailmentShortDesc +
                Strings.LINE_BREAK +
                Strings.DET_OMM_PROFILES +
                ousUsers.uniqueId,
            style: TextStyle(color: Colors.white),
          ),
        );

    Card makeCard(OusUser ousUsers) => Card(
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
            child: makeListTile(ousUsers),
          ),
        );

    final makeBody = Container(
      // decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, 1.0)),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: ousUsers.length,
        itemBuilder: (BuildContext context, int index) {
          return makeCard(ousUsers[index]);
        },
      ),
    );

    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        title: Text(
          Strings.TITLE_OUS_APPTS,
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
    ousUsers = [];
  }
}
