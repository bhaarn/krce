import 'package:deepaprakasar/database/crud/user/viewkar.dart';
import 'package:deepaprakasar/database/dao/karyalayam.dart';
import 'package:deepaprakasar/resources/texts/strings.dart';
import 'package:flutter/material.dart';

class KaryalayamList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => KaryalayamListState();
}

class KaryalayamListState extends State<KaryalayamList> {
  List<Karyalayam> karyalayams = [];

  @override
  void initState() {
    cleanSlate();
    viewKar().then((List<Karyalayam> value) {
      setState(() {
        karyalayams = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ListTile makeListTile(Karyalayam karyalayams) => ListTile(
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
            karyalayams.job + Strings.LINE_BREAK + Strings.LINE_BREAK +
                Strings.DET_KAR_LAST_DATE + karyalayams.expiryDate,
            style: TextStyle(color: Colors.white),
          ),

        );

    Card makeCard(Karyalayam karyalayams) => Card(
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
            child: makeListTile(karyalayams),
          ),
        );

    final makeBody = Container(
      // decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, 1.0)),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: karyalayams.length,
        itemBuilder: (BuildContext context, int index) {
          return makeCard(karyalayams[index]);
        },
      ),
    );

    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        title: Text(
          Strings.TITLE_KAR_JOB_CLASSIFIEDS,
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
    karyalayams = [];
  }
}
