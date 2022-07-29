import 'package:deepaprakasar/database/crud/user/viewlatestnews.dart';
import 'package:deepaprakasar/database/dao/latestnews.dart';
import 'package:deepaprakasar/resources/texts/strings.dart';
import 'package:flutter/material.dart';

class ViewLatestNews extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ViewLatestNewsState();
}

class ViewLatestNewsState extends State<ViewLatestNews> {
  List<LatestNews> latestNewss = [];

  @override
  void initState() {
    cleanSlate();
    viewLatestNews().then((List<LatestNews> value) {
      setState(() {
        latestNewss = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ListTile makeListTile(LatestNews latestNews) => ListTile(
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
                  Strings.DET_LATEST_NEWS_VADHU +
                      latestNews.femaleName +
                      Strings.DET_LATEST_NEWS_VARAN +
                      latestNews.maleName,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Divider(
                  color: Colors.yellow,
                ),
                Text(
                  Strings.DET_LATEST_NEWS_ON + latestNews.marriageDate,
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  Strings.DET_LATEST_NEWS_DETAILS + latestNews.marriageDetails,
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          subtitle: Center(
            //   child: Image.network(latestNews.newsImage),
            child: Image.network(latestNews.marriagePhoto),
          ),
        );

    Card makeCard(LatestNews latestNews) => Card(
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
            child: makeListTile(latestNews),
          ),
        );

    final makeBody = Container(
      // decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, 1.0)),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: latestNewss.length,
        itemBuilder: (BuildContext context, int index) {
          return makeCard(latestNewss[index]);
        },
      ),
    );

    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        title: Text(
          Strings.TITLE_LATEST_NEWS,
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
    latestNewss = [];
  }
}
