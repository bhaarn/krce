import 'package:deepaprakasar/database/dao/services.dart';
import 'package:deepaprakasar/resources/texts/strings.dart';
import 'package:deepaprakasar/ui/views/kainkaryalayam/kairegistration.dart';
import 'package:deepaprakasar/ui/views/kainkaryalayam/vieweditdeleteprofile.dart';
import 'package:deepaprakasar/ui/views/kainkaryalayam/viewkainkaryam.dart';
import 'package:flutter/material.dart';

class Kainkaryalayam extends StatefulWidget {
  @override
  KainkaryalayamState createState() => KainkaryalayamState();
}

class KainkaryalayamState extends State<Kainkaryalayam> {
  late List services;

  @override
  void initState() {
    services = getServices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ListTile makeListTile(Services services) => ListTile(
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
            services.title,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),

          subtitle: Row(
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child: Container(
                    child: LinearProgressIndicator(
                        backgroundColor: Color.fromRGBO(209, 224, 224, 0.2),
                        value: services.indicatorValue,
                        valueColor: AlwaysStoppedAnimation(Colors.green)),
                  )),
            ],
          ),
          trailing:
              Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
          onTap: () {
            switch(services.title) {
              case Strings.TITLE_KAI_KAINKARYAM:
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => KAIRegistration()));
                break;
              case Strings.TITLE_KAI_VIEW_REQUESTS:
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ViewKainKaryam()));
                break;
              case Strings.TITLE_KAI_VIEW_EDIT_DELETE_PROFILE:
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ViewEditDeleteKAIProfile()));
                break;
              default:
                break;
            }
          },
        );

    Card makeCard(Services services) => Card(
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
            child: makeListTile(services),
          ),
        );

    final makeBody = Container(
      // decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, 1.0)),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: services.length,
        itemBuilder: (BuildContext context, int index) {
          return makeCard(services[index]);
        },
      ),
    );

    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      body: makeBody,
    );
  }
}

List getServices() {
  return [
    Services(
      title: Strings.TITLE_KAI_KAINKARYAM,
      indicatorValue: 0.33,
    ),
    Services(
      title: Strings.TITLE_KAI_VIEW_REQUESTS,
      indicatorValue: 0.66,
    ),
    Services(
      title: Strings.TITLE_KAI_VIEW_EDIT_DELETE_PROFILE,
      indicatorValue: 1.0,
    ),
  ];
}
