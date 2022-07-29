import 'dart:async';

import 'package:deepaprakasar/resources/texts/strings.dart';
import 'package:deepaprakasar/ui/views/authentication/loginscreen.dart';
import 'package:deepaprakasar/ui/views/mainmenu/mainmenutabadmin.dart';
import 'package:deepaprakasar/ui/views/mainmenu/mainmenutabuser.dart';
import 'package:deepaprakasar/ui/widgets/roundedrectbtngrad.dart';
import 'package:deepaprakasar/ui/widgets/showalertdialog.dart';
import 'package:deepaprakasar/utils/sharedpreferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final LocalAuthentication auth = LocalAuthentication();
  _SupportState _supportState = _SupportState.unknown;
  bool? _canCheckBiometrics;
  String _authorized = Strings.DET_HM_NOT_AUTHORIZED;
  bool isAuthenticating = false;

  @override
  void initState() {
    super.initState();
    auth.isDeviceSupported().then(
          (isSupported) => setState(() => _supportState = isSupported
              ? _SupportState.supported
              : _SupportState.unsupported),
        );
    _checkBiometrics();
  }

  Future<void> _checkBiometrics() async {
    late bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      canCheckBiometrics = false;
      print(e);
    }
    if (!mounted) return;

    setState(() {
      _canCheckBiometrics = canCheckBiometrics;
    });
  }

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      setState(() {
        isAuthenticating = true;
        _authorized = Strings.DET_HM_AUTH;
      });
      authenticated = await auth.authenticate(
          localizedReason: Strings.DET_HM_OS_DETERMINE,
          useErrorDialogs: true,
          stickyAuth: true);
      setState(() {
        isAuthenticating = false;
        _authorized = Strings.DET_HM_AUTH;
      });
    } on PlatformException catch (e) {
      print(e);
      setState(() {
        isAuthenticating = false;
        _authorized = Strings.DET_HM_ERR + "${e.message}";
      });
      return;
    }
    if (!mounted) return;

    setState(
        () => _authorized = authenticated ? Strings.DET_HM_AUTHORIZED : Strings.DET_HM_NOT_AUTHORIZED);
  }

  Future<bool> onBackPressed() async {
    return (await showAlertDialogDouble(
            context, Strings.ALERT_HDR_ARE_YOU_SURE, Strings.ALERT_BDY_ARE_YOU_SURE)) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: onBackPressed,
        child: new Scaffold(
            body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: <Color>[
                Colors.blue,
                Colors.green,
              ],
                  stops: [
                0.0,
                1.0
              ],
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  tileMode: TileMode.repeated)),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  Strings.CHN_IMG_PATH,
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width * 0.4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    roundedRectButton(
                      Strings.BTN_TITLE_LOGIN,
                      [
                        Colors.pink,
                        Colors.amber,
                      ],
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    roundedRectButton(
                      Strings.BTN_TITLE_REGISTER_NOW,
                      [
                        Colors.amber,
                        Colors.pink,
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Visibility(
                    visible: _supportState == _SupportState.supported &&
                            _canCheckBiometrics == true &&
                            sharedPrefs.fingerprint
                        ? true
                        : false,
                    child: TextButton(
                        style: TextButton.styleFrom(primary: Colors.white),
                        child: Column(
                          // Replace with a Row for horizontal icon + text
                          children: <Widget>[
                            Icon(Icons.fingerprint),
                            Text(Strings.DET_HM_LOGIN_METHOD)
                          ],
                        ),
                        onPressed: () async {
                          await _authenticate();
                          if (_authorized == Strings.DET_HM_AUTHORIZED &&
                              sharedPrefs.role == Strings.ROLE_USR) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MainMenuTabUser()));
                          } else if (_authorized == Strings.DET_HM_AUTHORIZED &&
                              sharedPrefs.role == Strings.ROLE_ADM) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MainMenuTabAdmin()));
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                          }
                        })),
              ],
            ),
          ),
        )));
  }
}

enum _SupportState {
  unknown,
  supported,
  unsupported,
}
