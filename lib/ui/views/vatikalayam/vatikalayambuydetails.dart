import 'package:deepaprakasar/database/crud/user/viewvat.dart';
import 'package:deepaprakasar/database/dao/profilevat.dart';
import 'package:deepaprakasar/resources/texts/strings.dart';
import 'package:deepaprakasar/utils/contactmethods.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class VatikalayamBuyDetails extends StatefulWidget {
  final String district;
  final String state;
  final String propertyOperation;

  VatikalayamBuyDetails({Key? key, required this.district, required this.state,
  required this.propertyOperation}) : super(key: key);

  @override
  State<StatefulWidget> createState() => VatikalayamBuyDetailsState(district, state, propertyOperation);
}

class VatikalayamBuyDetailsState extends State<VatikalayamBuyDetails> {

  String district;
  String state;
  String propertyOperation;
  List<ProfileVat> vatikalayams = [];
  VatikalayamBuyDetailsState(this.district, this.state, this.propertyOperation);

  @override
  void initState() {
    super.initState();
    // On Page Load Get all the states from the server
    cleanSlate();

    viewVat(district, state, propertyOperation).then((List<ProfileVat> value) {
      setState(() {
        vatikalayams = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    ListTile makeListTile(ProfileVat profileVat) => ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        leading: Container(
          padding: EdgeInsets.only(right: 12.0),
          decoration: new BoxDecoration(
              border: new Border(
                  right: new BorderSide(width: 1.0, color: Colors.white24))),
          child: Icon(Icons.auto_awesome, color: Colors.white),
        ),
        title: Container(
          child: Column(
            children: <Widget>[
              Text(
                profileVat.propertyType + Strings.SPACE + profileVat.propertyOperation,
                style:
                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              Image.network(Strings.TRANSPORT_PROTOCOL + Strings.WEB_CONNECTOR
              + Strings.BACK_SLASH + Strings.BACKEND + profileVat.photoPath),
              Divider(
                color: Colors.yellow,
              ),
              Text(
                Strings.DET_VAT_PROPERTY_DETAILS,
                style:
                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              Image.network(profileVat.photoPath),
              Text(
                profileVat.address +
                    Strings.LINE_BREAK + profileVat.city + Strings.HYPHEN +
                    profileVat.pinCode +
                    Strings.LINE_BREAK +
                    profileVat.details,
                style: TextStyle(color: Colors.white),
              ),
              Divider(
                color: Colors.yellow,
              ),
              Text(
                Strings.DET_VED_CONTACT_DETAILS,
                style:
                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              RichText(
                text: TextSpan(
                    text: Strings.DET_VIEW_MMM_PRF_PHONE,
                    style: TextStyle(fontSize: 16),
                    children: <TextSpan>[
                      new TextSpan(
                        text: Strings.PLUS + profileVat.contactNumber,
                        style: new TextStyle(
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            color: Colors.green),
                        recognizer: new TapGestureRecognizer()
                          ..onTap = () {
                            launchCaller(Strings.DET_VIEW_MMM_PRF_TEL + profileVat.contactNumber);
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
                        text: Strings.PLUS + profileVat.whatsAppNumber,
                        style: new TextStyle(
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            color: Colors.green),
                        recognizer: new TapGestureRecognizer()
                          ..onTap = () {
                            launchWhatsApp(Strings.DET_VIEW_MMM_PRF_WA_URL_HDR +
                                profileVat.whatsAppNumber +
                                Strings.DET_VIEW_VED_PRF_WA_URL_DTL_PT1 +
                                profileVat.uniqueId +
                                Strings.DET_VIEW_VED_PRF_WA_URL_DTL_PT2);
                          },
                      )
                    ]),
              ),
              Divider(
                color: Colors.yellow,
              ),
            ],
          ),
        ),
        subtitle: Center(
          child: Text(Strings.DET_VED_PROFILE_ID + profileVat.uniqueId,
              style: TextStyle(color: Colors.white)),
        ));

    Card makeCard(ProfileVat profileVat) => Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
        child: makeListTile(profileVat),
      ),
    );

    final makeBody = Container(
      // decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, 1.0)),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: vatikalayams.length,
        itemBuilder: (BuildContext context, int index) {
          return makeCard(vatikalayams[index]);
        },
      ),
    );

    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        title: Text(
          Strings.TITLE_VAT_PROPERTIES_DETAILS,
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
    vatikalayams = [];
  }
}
