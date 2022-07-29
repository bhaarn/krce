import 'package:deepaprakasar/database/crud/user/viewvedfreshcity.dart';
import 'package:deepaprakasar/database/dao/city.dart';
import 'package:deepaprakasar/resources/texts/strings.dart';
import 'package:deepaprakasar/ui/views/vedhakaryalayam/fresherdetails.dart';
import 'package:flutter/material.dart';

class BraminFresherList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BraminFresherListState();
}

class BraminFresherListState extends State<BraminFresherList> {
  List<City> cities = [];

  @override
  void initState() {
    cleanSlate();
    viewVedFreshCity().then((List<City> value) {
      setState(() {
        cities = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ListTile makeListTile(City cities) => ListTile(
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
            cities.city,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          trailing:
              Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FresherDetails(city: cities.city)));
          },
        );

    Card makeCard(City cities) => Card(
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
            child: makeListTile(cities),
          ),
        );

    final makeBody = Container(
      // decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, 1.0)),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: cities.length,
        itemBuilder: (BuildContext context, int index) {
          return makeCard(cities[index]);
        },
      ),
    );

    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        title: Text(
          Strings.TITLE_VED_SELECT_CITY,
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
    cities = [];
  }
}
