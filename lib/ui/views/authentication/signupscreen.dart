import 'package:deepaprakasar/database/crud/user/registerprofile.dart';
import 'package:deepaprakasar/database/crud/user/viewacharyan.dart';
import 'package:deepaprakasar/database/crud/user/viewcountry.dart';
import 'package:deepaprakasar/database/crud/user/viewgothram.dart';
import 'package:deepaprakasar/database/crud/user/viewsect.dart';
import 'package:deepaprakasar/database/crud/user/viewsoothram.dart';
import 'package:deepaprakasar/database/crud/user/viewsubsect.dart';
import 'package:deepaprakasar/database/crud/user/viewvedham.dart';
import 'package:deepaprakasar/database/dao/acharyan.dart';
import 'package:deepaprakasar/database/dao/country.dart';
import 'package:deepaprakasar/database/dao/gothram.dart';
import 'package:deepaprakasar/database/dao/sect.dart';
import 'package:deepaprakasar/database/dao/soothram.dart';
import 'package:deepaprakasar/database/dao/status.dart';
import 'package:deepaprakasar/database/dao/subsect.dart';
import 'package:deepaprakasar/database/dao/vedham.dart';
import 'package:deepaprakasar/resources/texts/strings.dart';
import 'package:deepaprakasar/ui/views/authentication/loginscreen.dart';
import 'package:deepaprakasar/ui/widgets/showalertdialog.dart';
import 'package:deepaprakasar/ui/widgets/textfield.dart';
import 'package:deepaprakasar/utils/launchurl.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  Vedham? selectedVedham;
  Soothram? selectedSoothram;
  List<Vedham> vedhams = [];
  List<Soothram> soothrams = [];

  Sect? selectedSect;
  SubSect? selectedSubSect;
  List<Sect> sects = [];
  List<SubSect> subsects = [];

  Gothram? selectedGothram;
  List<Gothram> gothrams = [];

  Acharyan? selectedAcharyan;
  List<Acharyan> acharyans = [];

  Country? selectedCountry;
  List<Country> countries = [];

  bool checkedValue = false;
  Future<Status>? _futureStatus;

  @override
  void initState() {
    super.initState();
    // On Page Load Get all the states from the server
    cleanSlate();
    viewVedham().then((List<Vedham> value) {
      setState(() {
        vedhams = value;
      });
    });

    viewSect().then((List<Sect> value) {
      setState(() {
        sects = value;
      });
    });

    viewGothram().then((List<Gothram> value) {
      setState(() {
        gothrams = value;
      });
    });

    viewCountry().then((List<Country> value) {
      setState(() {
        countries = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget roundedRectButton(String title, List<Color> gradient) {
      return Builder(builder: (BuildContext mContext) {
        return InkWell(
          onTap: () {
            if (checkedValue) {
              if (firstNameFieldController.text != Strings.EMPTY_STRING &&
                  lastNameFieldController.text != Strings.EMPTY_STRING &&
                  userNameFieldController.text != Strings.EMPTY_STRING &&
                  passwordFieldController.text != Strings.EMPTY_STRING &&
                  selectedSect!.sect != Strings.EMPTY_STRING &&
                  selectedSubSect!.subSect != Strings.EMPTY_STRING &&
                  selectedGothram!.gothram != Strings.EMPTY_STRING &&
                  selectedSoothram!.soothram != Strings.EMPTY_STRING &&
                  selectedVedham!.vedham != Strings.EMPTY_STRING &&
                  selectedAcharyan!.acharyan != Strings.EMPTY_STRING &&
                  selectedCountry!.countryName != Strings.EMPTY_STRING &&
                  contactNumberFieldController.text != Strings.EMPTY_STRING) {
                setState(() {
                  _futureStatus = registerProfile(
                      firstNameFieldController.text,
                      lastNameFieldController.text,
                      userNameFieldController.text,
                      passwordFieldController.text,
                      selectedSect!.sect,
                      selectedSubSect!.subSect,
                      selectedGothram!.gothram,
                      selectedSoothram!.soothram,
                      selectedVedham!.vedham,
                      selectedAcharyan!.acharyan,
                      contactCountryFieldController.text +
                          Strings.HYPHEN +
                          contactNumberFieldController.text,
                  Strings.ROLE_USR);
                });
              }
            } else {
              showAlertDialogSingle(context, Strings.ALERT_HDR_TERMS_NOT_ACCEPTED,
                  Strings.ALERT_BDY_TERMS_NOT_ACCEPTED);
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
            Strings.BTN_TITLE_SIGN_UP,
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
              color: Colors.black12,
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: <Widget>[
                      Column(
//                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          createAccountField,
                          SizedBox(
                            height: 10,
                          ),
                          userNameField,
                          SizedBox(
                            height: 10,
                          ),
                          passwordField,
                          SizedBox(
                            height: 10,
                          ),
                          firstNameField,
                          SizedBox(
                            height: 10,
                          ),
                          lastNameField,
                          SizedBox(
                            height: 10,
                          ),
                          DropdownButtonFormField<Sect>(
                            decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                hintText: Strings.DD_HINT_SEL_SECT,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(32.0))),
                            value: selectedSect,
                            isExpanded: true,
                            items: sects.map((Sect sect) {
                              return DropdownMenuItem<Sect>(
                                value: sect,
                                child: Text(sect.sect),
                              );
                            }).toList(),
                            onChanged: onSectChanged,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          DropdownButtonFormField<SubSect>(
                            decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                hintText: Strings.DD_HINT_SEL_SUB_SECT,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(32.0))),
                            value: selectedSubSect,
                            isExpanded: true,
                            items: subsects.map((SubSect subSect) {
                              return DropdownMenuItem<SubSect>(
                                value: subSect,
                                child: Text(subSect.subSect),
                              );
                            }).toList(),
                            onChanged: onSubSectChange,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          DropdownButtonFormField<Gothram>(
                            decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                hintText: Strings.DD_HINT_SEL_GOTHRAM,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(32.0))),
                            value: selectedGothram,
                            isExpanded: true,
                            items: gothrams.map((Gothram gothram) {
                              return DropdownMenuItem<Gothram>(
                                value: gothram,
                                child: Text(gothram.gothram),
                              );
                            }).toList(),
                            onChanged: onGothramChanged,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          DropdownButtonFormField<Vedham>(
                            decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                hintText: Strings.DD_HINT_SEL_VEDHAM,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(32.0))),
                            value: selectedVedham,
                            isExpanded: true,
                            items: vedhams.map((Vedham vedham) {
                              return DropdownMenuItem<Vedham>(
                                value: vedham,
                                child: Text(vedham.vedham),
                              );
                            }).toList(),
                            onChanged: onVedhamChanged,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          DropdownButtonFormField<Soothram>(
                            decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                hintText: Strings.DD_HINT_SEL_SOOTHRAM,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(32.0))),
                            value: selectedSoothram,
                            isExpanded: true,
                            items: soothrams.map((Soothram soothram) {
                              return DropdownMenuItem<Soothram>(
                                value: soothram,
                                child: Text(soothram.soothram),
                              );
                            }).toList(),
                            onChanged: onSoothramChange,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          DropdownButtonFormField<Acharyan>(
                            decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                hintText: Strings.DD_HINT_SEL_ACHARYAN,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(32.0))),
                            value: selectedAcharyan,
                            isExpanded: true,
                            items: acharyans.map((Acharyan acharyan) {
                              return DropdownMenuItem<Acharyan>(
                                value: acharyan,
                                child: Text(acharyan.acharyan),
                              );
                            }).toList(),
                            onChanged: onAcharyanChanged,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          DropdownButtonFormField<Country>(
                            decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                hintText: Strings.DD_HINT_SEL_COUNTRY,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(32.0))),
                            value: selectedCountry,
                            isExpanded: true,
                            items: countries.map((Country country) {
                              return DropdownMenuItem<Country>(
                                value: country,
                                child: Text(country.countryName),
                              );
                            }).toList(),
                            onChanged: onCountryChanged,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 3,
                                child: contactCountryField,
                              ),
                              Container(
                                width: (MediaQuery.of(context).size.width) -
                                    (MediaQuery.of(context).size.width / 3),
                                child: contactNumberField,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                Checkbox(
                                  value: checkedValue,
                                  onChanged: (value) {
                                    setState(() {
                                      checkedValue = !checkedValue;
                                    });
                                  },
                                ),
                                RichText(
                                    text: TextSpan(
                                        text: Strings.DET_SIGN_UP_TERMS_CONDITIONS_PT1,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                        children: <TextSpan>[
                                      new TextSpan(
                                        text: Strings.DET_SIGN_UP_TERMS_CONDITIONS_PT2,
                                        style: new TextStyle(
                                            fontWeight: FontWeight.bold,
                                            decoration:
                                                TextDecoration.underline,
                                            color: Colors.red),
                                        recognizer: new TapGestureRecognizer()
                                          ..onTap = () {
                                            launchURL(
                                                Strings.TERMS_CONDITIONS_URL);
                                          },
                                      ),
                                    ])),
                              ],
                            ),
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
                                        if (snapshot.data!.status.contains(
                                            Strings.SYSTEM_ERROR)) {
                                          SchedulerBinding.instance!
                                              .addPostFrameCallback((_) {
                                            return showAlertDialogSingle(
                                                context,
                                                Strings.ALERT_HDR_USR_PRESENT,
                                                Strings.ALERT_BDY_USR_PRESENT);
                                          });
                                        } else if (snapshot.data!.status
                                            .startsWith(
                                                Strings.REG_SUCCESS)) {
                                          SchedulerBinding.instance!
                                              .addPostFrameCallback((_) {
                                            cleanSlate();
                                            return showAlertDialogSingle(
                                                context,
                                                Strings.ALERT_HDR_REG_SUCCESS,
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
                            Strings.BTN_TITLE_REGISTER,
                            [
                              Colors.pink,
                              Colors.amber,
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          RichText(
                            text: TextSpan(
                                text: Strings.DET_SIGN_UP_ACCOUNT_PRESENT_PT1,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                                children: <TextSpan>[
                                  new TextSpan(
                                    text: Strings.DET_SIGN_UP_ACCOUNT_PRESENT_PT2,
                                    style: new TextStyle(
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline,
                                        color: Colors.red),
                                    recognizer: new TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LoginScreen()));
                                      },
                                  ),
                                ]),
                          )
                        ],
                      ),
                    ],
                  )),
                ],
              )),
        ));
  }

  void onVedhamChanged(vedham) {
    setState(() {
      selectedVedham = vedham;
      soothrams = [];
      selectedSoothram = null;
    });
    viewSoothram(selectedVedham!.vedham).then((List<Soothram> value) {
      setState(() {
        soothrams = value;
      });
    });
  }

  void onSoothramChange(soothram) {
    setState(() {
      selectedSoothram = soothram;
    });
  }

  void onSectChanged(sect) {
    setState(() {
      selectedSect = sect;
      subsects = [];
      selectedSubSect = null;
      acharyans = [];
      selectedAcharyan = null;
    });
    viewSubSect(selectedSect!.sect).then((List<SubSect> value) {
      setState(() {
        subsects = value;
      });
    });

    viewAcharyan(selectedSect!.sect).then((List<Acharyan> value) {
      setState(() {
        acharyans = value;
      });
    });
  }

  void onSubSectChange(subsect) {
    setState(() {
      selectedSubSect = subsect;
    });
  }

  void onGothramChanged(gothram) {
    setState(() {
      selectedGothram = gothram;
    });
  }

  void onAcharyanChanged(acharyan) {
    setState(() {
      selectedAcharyan = acharyan;
    });
  }

  void onCountryChanged(country) {
    setState(() {
      selectedCountry = country;
      contactCountryFieldController.text = Strings.PLUS + selectedCountry!.countryCode;
    });
  }

  void cleanSlate() {
    sectList.clear();
    subSectList.clear();
    gothramList.clear();
    soothramList.clear();
    vedhamList.clear();
    acharyanList.clear();
    countryList.clear();
    selectedSect = null;
    sects = [];
    selectedSubSect = null;
    subsects = [];
    selectedGothram = null;
    gothrams = [];
    selectedSoothram = null;
    soothrams = [];
    selectedVedham = null;
    vedhams = [];
    selectedAcharyan = null;
    acharyans = [];
    selectedCountry = null;
    countries = [];
    clearInput();
  }
}
