import 'package:deepaprakasar/resources/texts/strings.dart';
import 'package:deepaprakasar/ui/views/bojanalayam/bojanalayam.dart';
import 'package:deepaprakasar/ui/views/deepaprakasar.dart';
import 'package:deepaprakasar/ui/views/kainkaryalayam/kainkaryalayam.dart';
import 'package:deepaprakasar/ui/views/matrimony/matrimony.dart';
import 'package:deepaprakasar/ui/views/oushadhalayam/oushadhalayam.dart';
import 'package:deepaprakasar/ui/views/sastralayam.dart';
import 'package:deepaprakasar/ui/views/vatikalayam/vatikalayam.dart';
import 'package:deepaprakasar/ui/views/vedhakaryalayam/vedhakaryalayam.dart';
import 'package:deepaprakasar/ui/views/vidyalayam.dart';
import 'package:deepaprakasar/utils/sharedpreferences.dart';
import 'package:flutter/material.dart';

class MainMenuTabUser extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MainMenuTabUserState();
}

class MainMenuTabUserState extends State<MainMenuTabUser>
    with TickerProviderStateMixin {
  late TabController _controller;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this);
    _controller.addListener(() {
      setState(() {
        selectedIndex = _controller.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 9,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            indicatorWeight: 5,
            isScrollable: true,
            tabs: [
              Tab(icon: Icon(Icons.family_restroom), child: Text(Strings.TITLE_MM_TB_MM)),
              Tab(icon: Icon(Icons.work), child: Text(Strings.TITLE_MM_TB_VEDKAR)),
              Tab(
                  icon: Icon(Icons.local_hospital),
                  child: Text(Strings.TITLE_MM_TB_OUS)),
              Tab(
                  icon: Icon(Icons.school),
                  child: Text(Strings.TITLE_MM_TB_VID)),
              Tab(icon: Icon(Icons.food_bank), child: Text(Strings.TITLE_MM_TB_BOJ)),
              Tab(icon: Icon(Icons.home), child: Text(Strings.TITLE_MM_TB_VAT)),
              Tab(icon: Icon(Icons.book), child: Text(Strings.TITLE_MM_TB_SAS)),
              Tab(icon: Icon(Icons.local_atm), child: Text(Strings.TITLE_MM_TB_KAI)),
              Tab(
                  icon: Icon(Icons.contact_support),
                  child: Text(Strings.TITLE_MM_TB_DPSR)),
            ],
          ),
          title: Center(
            child: Column(
              children: [
                Text(
                  Strings.DET_MM_TB_WEL + SharedPrefs().username,
                ),
                Text(
                    greeting()
                ),
              ],
            ),
          ),
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: TabBarView(
          children: [
            Matrimony(),
            VedhaKaryalayam(),
            Oushadhalayam(),
            Vidyalayam(),
            Bojanalayam(),
            Vatikalayam(),
            Sastralayam(),
            Kainkaryalayam(),
            DeepaPrakasar(),
          ],
        ),
      ),
    );
  }

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return Strings.DET_MM_TB_GREET_MOR;
    }
    if (hour < 16) {
      return Strings.DET_MM_TB_GREET_NOON;
    }
    return Strings.DET_MM_TB_GREET_EVE;
  }
}
