import 'package:deepaprakasar/database/crud/user/forgotpassword.dart';
import 'package:deepaprakasar/database/crud/user/viewcountry.dart';
import 'package:deepaprakasar/database/dao/country.dart';
import 'package:deepaprakasar/database/dao/status.dart';
import 'package:deepaprakasar/resources/texts/strings.dart';
import 'package:deepaprakasar/ui/widgets/textfield.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ForgotPasswordScreenState();
}

class ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  Future<Status>? _futureStatus;

  Country? selectedCountry;
  List<Country> countries = [];

  @override
  void initState() {
    super.initState();
    // On Page Load Get all the states from the server
    cleanSlate();

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
            if (userNameFieldController.text != Strings.EMPTY_STRING &&
                contactNumberFieldController.text != Strings.EMPTY_STRING &&
                selectedCountry!.countryName != Strings.EMPTY_STRING) {
              setState(() {
                _futureStatus = forgotPassword(
                    userNameFieldController.text,
                    contactCountryFieldController.text +
                        Strings.HYPHEN +
                        contactNumberFieldController.text);
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
            Strings.TITLE_FORGOT_PWD_FORGOT_PWD,
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
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              userNameField,
              SizedBox(
                height: 10,
              ),
              DropdownButtonFormField<Country>(
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
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
                            return Text(Strings.DET_FORGOT_PWD_YOUR_PASSWORD + snapshot.data!.status);
                          } else if (snapshot.hasError) {
                            return Text("${snapshot.error}");
                          }
                          return CircularProgressIndicator(
                                                value: 0.0);
                        },
                      )
                    : Text(Strings.DET_MMM_REG_INPUT_REQ_FIELDS),
              ),
              roundedRectButton(
                Strings.BTN_TITLE_GET_PWD,
                [
                  Colors.pink,
                  Colors.amber,
                ],
              ),
            ],
          ),
        ));
  }

  void onCountryChanged(country) {
    setState(() {
      selectedCountry = country;
      contactCountryFieldController.text = Strings.PLUS + selectedCountry!.countryCode;
    });
  }

  void cleanSlate() {
    countryList.clear();
    selectedCountry = null;
    countries = [];
    clearInput();
  }
}
