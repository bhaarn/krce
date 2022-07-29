import 'package:deepaprakasar/database/dao/services.dart';
import 'package:deepaprakasar/resources/texts/strings.dart';
import 'package:deepaprakasar/ui/views/vedhakaryalayam/braminfresherlist.dart';
import 'package:deepaprakasar/ui/views/vedhakaryalayam/braminprofessionallist.dart';
import 'package:deepaprakasar/ui/views/vedhakaryalayam/karyalayam.dart';
import 'package:deepaprakasar/ui/views/vedhakaryalayam/vedregistration.dart';
import 'package:deepaprakasar/ui/views/vedhakaryalayam/vieweditdeleteprofile.dart';
import 'package:flutter/material.dart';

class VedhaKaryalayam extends StatefulWidget {
  @override
  VedhaKaryalayamState createState() => VedhaKaryalayamState();
}

class VedhaKaryalayamState extends State<VedhaKaryalayam> {
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
              case Strings.TITLE_VED_VED_REGISTRATION:
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => VEDRegistration()));
                break;
              case Strings.TITLE_VED_PROF_LIST:
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BraminProfessionalList()));
                break;
              case Strings.TITLE_VED_FRESH_LIST:
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BraminFresherList()));
                break;
              case Strings.TITLE_VED_KAR_JOB_CLASSIFIEDS:
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => KaryalayamList()));
                break;
              case Strings.TITLE_VED_VIEW_EDIT_DELETE_PROFILE:
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ViewEditDeleteVEDProfile()));
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
      title: Strings.TITLE_VED_VED_REGISTRATION,
      indicatorValue: 0.20,
    ),
    Services(
      title: Strings.TITLE_VED_PROF_LIST,
      indicatorValue: 0.40,
    ),
    Services(
      title: Strings.TITLE_VED_FRESH_LIST,
      indicatorValue: 0.60,
    ),
    Services(
      title: Strings.TITLE_VED_KAR_JOB_CLASSIFIEDS,
      indicatorValue: 0.80,
    ),
    Services(
      title: Strings.TITLE_VED_VIEW_EDIT_DELETE_PROFILE,
      indicatorValue: 1.0,
    ),
  ];
}
