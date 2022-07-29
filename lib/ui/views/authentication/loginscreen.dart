import 'dart:async';

import 'package:deepaprakasar/database/crud/user/login.dart';
import 'package:deepaprakasar/database/dao/status.dart';
import 'package:deepaprakasar/resources/texts/strings.dart';
import 'package:deepaprakasar/ui/views/authentication/forgotpasswordscreen.dart';
import 'package:deepaprakasar/ui/views/authentication/signupscreen.dart';
import 'package:deepaprakasar/ui/widgets/clipper.dart';
import 'package:deepaprakasar/ui/widgets/showalertdialog.dart';
import 'package:deepaprakasar/ui/widgets/textfield.dart';
import 'package:deepaprakasar/utils/sharedpreferences.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  Future<Status>? _futureStatus;

  @override
  Widget build(BuildContext context) {
    Widget roundedRectButton(String title, List<Color> gradient) {
      return Builder(builder: (BuildContext mContext) {
        return InkWell(
          onTap: () {
            if (userNameFieldController.text != Strings.EMPTY_STRING &&
                passwordFieldController.text != Strings.EMPTY_STRING) {
              setState(() {
                _futureStatus = login(
                    userNameFieldController.text, passwordFieldController.text);
              });
            }
          },
          splashColor: Colors.lightBlue,
          child: Container(
            alignment: Alignment.center,
            height: MediaQuery.of(mContext).size.height * 0.05,
            width: MediaQuery.of(mContext).size.width / 3,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              gradient: LinearGradient(
                  colors: gradient,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight),
            ),
            child: Text(title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500)),
          ),
        );
      });
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(
            Strings.TITLE_LGN_LOGIN,
            style: new TextStyle(color: Colors.white),
          ),
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
              height: MediaQuery.of(context).size.height,
              color: Colors.black12,
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: <Widget>[
                      ClipPath(
                        clipper: TopWaveClipper(),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: <Color>[
                              Colors.blue,
                              Colors.green,
                            ], begin: Alignment.topLeft, end: Alignment.center),
                          ),
                          height: MediaQuery.of(context).size.height / 2.5,
                        ),
                      ),
                      Image.asset(
                        Strings.CHN_IMG_PATH,
                        height: MediaQuery.of(context).size.height * 0.2,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      width: MediaQuery.of(context).size.width * 1.0,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: <Widget>[
                          ClipPath(
                            clipper: FooterWaveClipper(),
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: <Color>[Colors.purple, Colors.teal],
                                    begin: Alignment.center,
                                    end: Alignment.bottomRight),
                              ),
                              height: MediaQuery.of(context).size.height / 3,
                            ),
                          ),
                          Column(
//                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              SizedBox(
                                height: 10,
                              ),
                              helloField,
                              loginIntoField,
                              SizedBox(
                                height: 10,
                              ),
                              userNameField,
                              SizedBox(
                                height: 10,
                              ),
                              passwordField,
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(8.0),
                                // ignore: unnecessary_null_comparison
                                child: (_futureStatus != null)
                                    ? FutureBuilder<Status>(
                                        future: _futureStatus,
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            sharedPrefs.fingerprint = true;
                                            sharedPrefs.username =
                                                userNameFieldController.text;
                                            if (snapshot.data!.status ==
                                                Strings.ROLE_USR) {
                                              sharedPrefs.role =
                                                  snapshot.data!.status;
                                              startTime(snapshot.data!.status);
                                            } else if (snapshot.data!.status ==
                                                Strings.ROLE_ADM) {
                                              sharedPrefs.role =
                                                  snapshot.data!.status;
                                              startTime(snapshot.data!.status);
                                            } else {
                                              WidgetsBinding.instance!
                                                  .addPostFrameCallback((_) {
                                                return showAlertDialogSingle(
                                                    context,
                                                    Strings.DET_LGN_PROCESSING,
                                                    snapshot.data!.status);
                                              });
                                            }
                                          } else if (snapshot.hasError) {
                                            return Text("${snapshot.error}");
                                          }
                                          return CircularProgressIndicator(
                                                value: 0.0);
                                        },
                                      )
                                    : Text(
                                    Strings.DET_MMM_REG_INPUT_REQ_FIELDS),
                              ),
                              roundedRectButton(
                                Strings.BTN_TITLE_LOGIN_NOW,
                                [
                                  Colors.green,
                                  Colors.green,
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              RichText(
                                  text: TextSpan(text: Strings.EMPTY_STRING, children: <TextSpan>[
                                TextSpan(
                                    text: Strings.DET_LGN_FORGOT_PWD,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline,
                                        color: Colors.red),
                                    recognizer: new TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ForgotPasswordScreen()));
                                      })
                              ])),
                              SizedBox(
                                height: 15,
                              ),
                              RichText(
                                text: TextSpan(
                                    text: Strings.DET_LGN_REGISTER_PT1,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                    children: <TextSpan>[
                                      new TextSpan(
                                        text: Strings.DET_LGN_REGISTER_PT2,
                                        style: new TextStyle(
                                            fontWeight: FontWeight.bold,
                                            decoration:
                                                TextDecoration.underline,
                                            color: Colors.green),
                                        recognizer: new TapGestureRecognizer()
                                          ..onTap = () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        SignUpScreen()));
                                          },
                                      )
                                    ]),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image.asset(
                                    Strings.CHN_IMG_PATH,
                                    height: 50,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Image.asset(
                                    Strings.CHN_IMG_PATH,
                                    height: 50,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      )),
                ],
              )),
        ));
  }

  void navigationPageUser() {
    Navigator.of(context).pushReplacementNamed(Strings.PG_RT_MM_TAB_USR);
  }

  void navigationPageAdmin() {
    Navigator.of(context).pushReplacementNamed(Strings.PG_RT_MM_TAB_ADM);
  }

  startTime(String role) async {
    var _duration = new Duration(milliseconds: 10);
    if (role == Strings.ROLE_USR) {
      return new Timer(_duration, navigationPageUser);
    } else {
      return new Timer(_duration, navigationPageAdmin);
    }
  }
}
