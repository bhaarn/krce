import 'package:deepaprakasar/resources/texts/strings.dart';
import 'package:deepaprakasar/ui/views/mainmenu/homescreen.dart';
import 'package:deepaprakasar/ui/views/mainmenu/mainmenutabadmin.dart';
import 'package:deepaprakasar/ui/views/mainmenu/mainmenutabuser.dart';
import 'package:deepaprakasar/ui/views/mainmenu/splashscreen.dart';
import 'package:deepaprakasar/utils/sharedpreferences.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs().init();
  runApp(MaterialApp(
    title: Strings.APP_NAME,
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      //primarySwatch: Colors.green,
      primaryColor: Color.fromRGBO(58, 66, 86, 1.0),
    ),
    home: SplashScreen(),
    routes: <String, WidgetBuilder>{
      Strings.PG_RT_HM: (BuildContext context) => new HomeScreen(),
      Strings.PG_RT_MM_TAB_USR: (BuildContext context) => new MainMenuTabUser(),
      Strings.PG_RT_MM_TAB_ADM: (BuildContext context) => new MainMenuTabAdmin(),
    },
  ));
}
