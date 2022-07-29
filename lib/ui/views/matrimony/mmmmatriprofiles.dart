import 'package:deepaprakasar/database/crud/user/hideviewedprofiles.dart';
import 'package:deepaprakasar/database/crud/user/viewmmm.dart';
import 'package:deepaprakasar/database/dao/profilemmm.dart';
import 'package:deepaprakasar/resources/texts/strings.dart';
import 'package:deepaprakasar/ui/widgets/styles.dart';
import 'package:deepaprakasar/utils/contactmethods.dart';
import 'package:deepaprakasar/utils/sharedpreferences.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class MmmMatriProfiles extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MmmMatriProfilesState();
}

class MmmMatriProfilesState extends State<MmmMatriProfiles> {
  List<ProfileMmm> profileMmms = [];
  late String contactNumber;
  late String whatsAppNumber;

  @override
  void initState() {
    cleanSlate();
    viewMmm(SharedPrefs().username).then((List<ProfileMmm> value) {
      setState(() {
        profileMmms = value;
        contactNumber = profileMmms.first.contactNumber.toString();
        whatsAppNumber = profileMmms.first.whatsAppNumber.toString();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ListTile makeListTile(ProfileMmm profileMmm, int index) => ListTile(
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
                  (profileMmm.gender == Strings.DET_VIEW_MMM_PRF_MALE)
                      ? Strings.DET_VIEW_MMM_PRF_CHI
                      : Strings.DET_VIEW_MMM_PRF_SOW + profileMmm.firstName,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Divider(
                  color: Colors.yellow,
                ),
                Text(
                  Strings.DET_VIEW_MMM_PRF_PERSONAL_DETAILS,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Text(
                  Strings.DET_VIEW_MMM_PRF_CHILD_OF +
                      profileMmm.lastName +
                      Strings.DET_VIEW_MMM_PRF_AND +
                      profileMmm.motherName,
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  Strings.DET_VIEW_MMM_PRF_NATIVE_OF + profileMmm.nativeCity,
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  Strings.DET_VIEW_MMM_PRF_SIBLINGS + profileMmm.siblings,
                  style: TextStyle(color: Colors.white),
                ),
                Divider(
                  color: Colors.yellow,
                ),
                Text(
                  Strings.DET_VIEW_MMM_PRF_BIO_DETAILS,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Text(
                  Strings.DET_VIEW_MMM_PRF_HEIGHT +
                      profileMmm.heightInch +
                      Strings.DET_VIEW_MMM_PRF_FEET +
                      profileMmm.heightCm +
                      Strings.DET_VIEW_MMM_PRF_CMS,
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  Strings.DET_VIEW_MMM_PRF_WEIGHT + profileMmm.weight + Strings.DET_VIEW_MMM_PRF_KGS,
                  style: TextStyle(color: Colors.white),
                ),
                Divider(
                  color: Colors.yellow,
                ),
                Text(
                  Strings.DET_VIEW_MMM_PRF_HOROSCOPE_DETAILS,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Text(
                  Strings.DET_VIEW_MMM_PRF_BORN_ON + profileMmm.birthDateTime,
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  Strings.DET_VIEW_MMM_PRF_AT + profileMmm.placeOfBirth,
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  Strings.DET_VIEW_MMM_PRF_IN +
                      profileMmm.star +
                      Strings.SPACE +
                      profileMmm.padham +
                      Strings.DET_VIEW_MMM_PRF_PADHAM +
                      profileMmm.rasi +
                      Strings.DET_VIEW_MMM_PRF_RASI,
                  style: TextStyle(color: Colors.white),
                ),
                Divider(
                  color: Colors.yellow,
                ),
                Text(
                  Strings.DET_VIEW_MMM_PRF_VAIDHEEHA_DETAILS,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Text(
                  profileMmm.gothram +
                      Strings.DET_VIEW_MMM_PRF_GOTHRAM +
                      profileMmm.subsect +
                      Strings.SPACE +
                      profileMmm.sect,
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  profileMmm.acharyan + Strings.DET_VIEW_MMM_PRF_SHISYA,
                  style: TextStyle(color: Colors.white),
                ),
                Divider(
                  color: Colors.yellow,
                ),
                Text(
                  Strings.DET_VIEW_MMM_PRF_LOUKEEKA_DETAILS,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Text(
                  Strings.DET_VIEW_MMM_PRF_OCCUPATION + profileMmm.occupation,
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  Strings.DET_VIEW_MMM_PRF_SALARY + profileMmm.salary,
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  Strings.DET_VIEW_MMM_PRF_QUALIFICATION + profileMmm.qualification,
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  Strings.DET_VIEW_MMM_PRF_PRESENT_CITY + profileMmm.presentCity,
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  Strings.DET_VIEW_MMM_PRF_EXPECTATION + profileMmm.expectation,
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  Strings.DET_VIEW_MMM_PRF_PREFERENCE + profileMmm.preference,
                  style: TextStyle(color: Colors.white),
                ),
                Divider(
                  color: Colors.yellow,
                ),
                Text(
                  Strings.DET_VIEW_MMM_PRF_CONTACT_DETAILS,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                RichText(
                  text: TextSpan(
                      text: Strings.DET_VIEW_MMM_PRF_PHONE,
                      style: TextStyle(fontSize: 16),
                      children: <TextSpan>[
                        new TextSpan(
                          text: Strings.PLUS + contactNumber,
                          style: new TextStyle(
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              color: Colors.green),
                          recognizer: new TapGestureRecognizer()
                            ..onTap = () {
                              launchCaller(Strings.DET_VIEW_MMM_PRF_TEL + contactNumber);
                            },
                        )
                      ]),
                ),
                RichText(
                  text: TextSpan(
                      text: Strings.DET_VIEW_MMM_PRF_WA,
                      style: TextStyle(fontSize: 16),
                      children: <TextSpan>[
                        new TextSpan(
                          text: Strings.PLUS + contactNumber,
                          style: new TextStyle(
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              color: Colors.green),
                          recognizer: new TapGestureRecognizer()
                            ..onTap = () {
                              launchWhatsApp(Strings.DET_VIEW_MMM_PRF_WA_URL_HDR +
                                  whatsAppNumber +
                                  Strings.DET_VIEW_MMM_PRF_WA_URL_DTL_PT1 +
                                  profileMmm.uniqueId +
                                  Strings.DET_VIEW_MMM_PRF_WA_URL_DTL_PT2);
                            },
                        )
                      ]),
                ),
                Text(Strings.DET_VIEW_MMM_PRF_PROFILE_ID + profileMmm.uniqueId,
                    style: TextStyle(color: Colors.white)),
                Divider(
                  color: Colors.yellow,
                ),
              ],
            ),
          ),
          subtitle: ElevatedButton(
              style: elevatedButtonStyle,
              child: Text(Strings.BTN_TITLE_DONT_SHOW + profileMmm.firstName + Strings.BTN_TITLE_AGAIN),
              onPressed: () {
                setState(() {
                  _doNotShowProfile(
                      SharedPrefs().username, profileMmm.uniqueId);
                  profileMmms.removeAt(index);
                });
              }),
        );

    Card makeCard(ProfileMmm profileMmms, int index) => Card(
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
            child: makeListTile(profileMmms, index),
          ),
        );

    final makeBody = Container(
      // decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, 1.0)),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: profileMmms.length,
        itemBuilder: (BuildContext context, int index) {
          return makeCard(profileMmms[index], index);
        },
      ),
    );

    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        title: Text(
          Strings.TITLE_MMM_VIEW_PROFILES,
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
    profileMmms = [];
  }

  _doNotShowProfile(String registeredBy, String uniqueID) {
    hideViewedProfiles(registeredBy, uniqueID);
  }
}
