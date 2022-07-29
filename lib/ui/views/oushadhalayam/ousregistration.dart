import 'package:deepaprakasar/database/crud/user/registerous.dart';
import 'package:deepaprakasar/database/crud/user/viewcountry.dart';
import 'package:deepaprakasar/database/dao/country.dart';
import 'package:deepaprakasar/database/dao/status.dart';
import 'package:deepaprakasar/resources/texts/strings.dart';
import 'package:deepaprakasar/ui/widgets/showalertdialog.dart';
import 'package:deepaprakasar/ui/widgets/styles.dart';
import 'package:deepaprakasar/ui/widgets/textfield.dart';
import 'package:deepaprakasar/utils/sharedpreferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:intl/intl.dart';

class OUSRegistration extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => OUSRegistrationState();
}

class OUSRegistrationState extends State<OUSRegistration> {
  Country? selectedContactCountry;
  List<Country> contactCountries = [];

  Country? selectedWhatsAppCountry;
  List<Country> whatsAppCountries = [];

  Future<Status>? _futureStatus;

  var listGenderText = [Strings.DET_MMM_REG_MALE, Strings.DET_MMM_REG_MALE];
  var tabTextIconGenderIndexSelected = 0;

  late String obtainedDate;
  late String dbDate;

  @override
  void initState() {
    super.initState();
    // On Page Load Get all the states from the server
    cleanSlate();

    viewCountry().then((List<Country> value) {
      setState(() {
        contactCountries = value;
      });
    });

    viewCountry().then((List<Country> value) {
      setState(() {
        whatsAppCountries = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget roundedRectButton(String title, List<Color> gradient) {
      return Builder(builder: (BuildContext mContext) {
        return InkWell(
          onTap: () {
            if (firstNameFieldController.text.isNotEmpty &&
                lastNameFieldController.text.isNotEmpty &&
                ailmentShortDescFieldController.text.isNotEmpty &&
                selectedContactCountry!.countryName.isNotEmpty &&
                selectedWhatsAppCountry!.countryName.isNotEmpty &&
                contactNumberFieldController.text.isNotEmpty &&
                whatsAppNumberFieldController.text.isNotEmpty) {
              setState(() {
                _futureStatus = registerOus(
                    firstNameFieldController.text,
                    lastNameFieldController.text,
                    listGenderText[tabTextIconGenderIndexSelected],
                    ailmentShortDescFieldController.text,
                    contactCountryFieldController.text +
                        Strings.HYPHEN +
                        contactNumberFieldController.text,
                    whatsAppCountryFieldController.text +
                        Strings.HYPHEN +
                        whatsAppNumberFieldController.text,
                    SharedPrefs().username,
                    dbDate);
              });
            } else {
              return showAlertDialogSingle(context, Strings.ALERT_HDR_DATA_INPUT_MISSING,
                  Strings.ALERT_BDY_DATA_INPUT_MISSING);
            }
          },
          splashColor: Colors.lightBlue,
          child: Container(
            alignment: Alignment.center,
            height: MediaQuery.of(mContext).size.height * 0.05,
            width: MediaQuery.of(mContext).size.width / 3,
            decoration: shapeDecoration(gradient),
            child: Text(title, style: normalTextStyle),
          ),
        );
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          Strings.TITLE_OUS_REGISTRATION,
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
                        sizedBoxHeight,
                        createAccountField,
                        sizedBoxHeight,
                        firstNameField,
                        sizedBoxHeight,
                        lastNameField,
                        sizedBoxHeight,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 180,
                              child: Center(
                                child: genderField,
                              ),
                            ),
                            FlutterToggleTab(
                              width: 50,
                              borderRadius: 32,
                              initialIndex: 2,
                              selectedTextStyle: selectedTextStyle,
                              unSelectedTextStyle: unSelectedTextStyle,
                              labels: [Strings.DET_MMM_REG_MALE, Strings.DET_MMM_REG_FEMALE],
                              selectedLabelIndex: (index) {
                                setState(() {
                                  tabTextIconGenderIndexSelected = index;
                                });
                              },
                            ),
                          ],
                        ),
                        sizedBoxHeight,
                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          height: 50,
                          child: ElevatedButton(
                            style: elevatedButtonStyle,
                            child: Text(Strings.BTN_TITLE_DOB),
                            onPressed: () {
                              setState(() {
                                DatePicker.showDatePicker(
                                  context,
                                  showTitleActions: true,
                                  minTime: DateTime(Strings.DET_MMM_REG_MIN_YEAR,
                                      Strings.DET_MMM_REG_MAX_MONTH, Strings.DET_MMM_REG_MIN_DATE),
                                  maxTime: DateTime.now(),
                                  onConfirm: (date) {
                                    obtainedDate = DateFormat(Strings.DET_MMM_REG_DATE_FMT_IN)
                                        .format(date)
                                        .toString()
                                        .split(Strings.SPACE)[0];
                                    dbDate = DateFormat(Strings.DET_MMM_REG_DATE_FMT_DB)
                                        .format(date)
                                        .toString();
                                    dateOfBirthFieldController.text =
                                        obtainedDate;
                                  },
                                );
                              });
                            },
                          ),
                        ),
                        sizedBoxHeight,
                        dateOfBirthField,
                        sizedBoxHeight,
                        ailmentShortDescField,
                        sizedBoxHeight,
                        DropdownButtonFormField<Country>(
                          decoration:
                              inputDecoration(Strings.DD_HINT_SEL_COUNTRY),
                          value: selectedContactCountry,
                          isExpanded: true,
                          items: contactCountries.map((Country country) {
                            return DropdownMenuItem<Country>(
                              value: country,
                              child: Text(country.countryName),
                            );
                          }).toList(),
                          onChanged: onContactCountryChanged,
                        ),
                        sizedBoxHeight,
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
                        sizedBoxHeight,
                        DropdownButtonFormField<Country>(
                          decoration:
                              inputDecoration(Strings.DD_HINT_SEL_COUNTRY),
                          value: selectedWhatsAppCountry,
                          isExpanded: true,
                          items: whatsAppCountries.map((Country country) {
                            return DropdownMenuItem<Country>(
                              value: country,
                              child: Text(country.countryName),
                            );
                          }).toList(),
                          onChanged: onWhatsAppCountryChanged,
                        ),
                        sizedBoxHeight,
                        Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 3,
                              child: whatsappCountryField,
                            ),
                            Container(
                              width: (MediaQuery.of(context).size.width) -
                                  (MediaQuery.of(context).size.width / 3),
                              child: whatsappNumberField,
                            ),
                          ],
                        ),
                        sizedBoxHeight,
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
                                              Strings.ALERT_HDR_SYSTEM_ERROR,
                                              Strings.ALERT_BDY_SYSTEM_ERROR);
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
                              : Text(Strings.DET_MMM_REG_INPUT_REQ_FIELDS),
                        ),
                        roundedRectButton(
                          Strings.BTN_TITLE_REGISTER,
                          [
                            Colors.pink,
                            Colors.amber,
                          ],
                        ),
                      ],
                    ),
                  ],
                )),
              ],
            )),
      ),
    );
  }

  void onContactCountryChanged(country) {
    setState(() {
      selectedContactCountry = country;
      contactCountryFieldController.text =
          Strings.PLUS + selectedContactCountry!.countryCode;
    });
  }

  void onWhatsAppCountryChanged(country) {
    setState(() {
      selectedWhatsAppCountry = country;
      whatsAppCountryFieldController.text =
          Strings.PLUS + selectedWhatsAppCountry!.countryCode;
    });
  }

  void cleanSlate() {
    countryList.clear();
    selectedContactCountry = null;
    contactCountries = [];
    selectedWhatsAppCountry = null;
    whatsAppCountries = [];
    clearInput();
  }
}
