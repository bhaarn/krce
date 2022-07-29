import 'package:deepaprakasar/database/dao/services.dart';
import 'package:deepaprakasar/resources/texts/strings.dart';
import 'package:deepaprakasar/ui/views/matrimony/latestnews.dart';
import 'package:deepaprakasar/ui/views/matrimony/mmmmatriprofiles.dart';
import 'package:deepaprakasar/ui/views/matrimony/mmmregistration.dart';
import 'package:deepaprakasar/ui/views/matrimony/othmatriprofiles.dart';
import 'package:deepaprakasar/ui/views/matrimony/vieweditdeleteprofile.dart';
import 'package:flutter/material.dart';

class Matrimony extends StatefulWidget {
  @override
  MatrimonyState createState() => MatrimonyState();
}

class MatrimonyState extends State<Matrimony> {
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
            switch (services.title) {
              case Strings.TITLE_MMM_MMM_REGISTRATION:
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MMMRegistration()));
                break;
              case Strings.TITLE_MMM_VARAN_VADHU_LIST:
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MmmMatriProfiles()));
                break;
              case Strings.TITLE_MMM_OMM_PROFILES:
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OthMatriProfiles()));
                break;
              case Strings.TITLE_MMM_VIEW_EDIT_DELETE_PROFILE:
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ViewEditDeleteMMMProfile()));
                break;
              case Strings.TITLE_MMM_LATEST_NEWS:
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ViewLatestNews()));
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
      title: Strings.TITLE_MMM_MMM_REGISTRATION,
      indicatorValue: 0.20,
    ),
    Services(
      title: Strings.TITLE_MMM_VARAN_VADHU_LIST,
      indicatorValue: 0.40,
    ),
    Services(
      title: Strings.TITLE_MMM_OMM_PROFILES,
      indicatorValue: 0.60,
    ),
    Services(
      title: Strings.TITLE_MMM_VIEW_EDIT_DELETE_PROFILE,
      indicatorValue: 0.80,
    ),
    Services(
      title: Strings.TITLE_MMM_LATEST_NEWS,
      indicatorValue: 1.0,
    ),
  ];
}
