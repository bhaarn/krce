import 'package:deepaprakasar/database/crud/user/registerved.dart';
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
import 'package:deepaprakasar/ui/widgets/showalertdialog.dart';
import 'package:deepaprakasar/ui/widgets/styles.dart';
import 'package:deepaprakasar/ui/widgets/textfield.dart';
import 'package:deepaprakasar/utils/sharedpreferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';

class VEDRegistration extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => VEDRegistrationState();
}

class VEDRegistrationState extends State<VEDRegistration> {
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

  Country? selectedContactCountry;
  List<Country> contactCountries = [];
  late String dbContactCountryCode;

  Country? selectedWhatsAppCountry;
  List<Country> whatsAppCountries = [];
  late String dbWhatsAppCountryCode;

  Future<Status>? _futureStatus;

  var listGenderText = [Strings.DET_MMM_REG_MALE, Strings.DET_MMM_REG_FEMALE];
  var tabTextIconGenderIndexSelected = 0;

  var listJobStatusText = [Strings.DET_VED_REG_FRESHER, Strings.DET_VED_REG_EXP];
  var tabTextIconJobStatusIndexSelected = 0;

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
                selectedSect!.sect.isNotEmpty &&
                selectedSubSect!.subSect.isNotEmpty &&
                selectedGothram!.gothram.isNotEmpty &&
                selectedSoothram!.soothram.isNotEmpty &&
                selectedVedham!.vedham.isNotEmpty &&
                selectedAcharyan!.acharyan.isNotEmpty &&
                selectedContactCountry!.countryName.isNotEmpty &&
                selectedWhatsAppCountry!.countryName.isNotEmpty &&
                qualificationFieldController.text.isNotEmpty &&
                presentCityFieldController.text.isNotEmpty &&
                addressFieldController.text.isNotEmpty &&
                occupationFieldController.text.isNotEmpty &&
                contactNumberFieldController.text.isNotEmpty &&
                whatsAppNumberFieldController.text.isNotEmpty) {
              setState(() {
                _futureStatus = registerVed(
                    firstNameFieldController.text,
                    lastNameFieldController.text,
                    listGenderText[tabTextIconGenderIndexSelected],
                    selectedSect!.sect,
                    selectedSubSect!.subSect,
                    selectedGothram!.gothram,
                    selectedSoothram!.soothram,
                    selectedVedham!.vedham,
                    selectedAcharyan!.acharyan,
                    qualificationFieldController.text,
                    presentCityFieldController.text,
                    addressFieldController.text,
                    listJobStatusText[tabTextIconJobStatusIndexSelected],
                    occupationFieldController.text,
                    dbContactCountryCode +
                        Strings.HYPHEN +
                        contactNumberFieldController.text,
                    dbWhatsAppCountryCode +
                        Strings.HYPHEN +
                        whatsAppNumberFieldController.text,
                    SharedPrefs().username,
                    Strings.EMPTY_STRING);
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
            Strings.TITLE_VED_VED_REGISTRATION,
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
                          DropdownButtonFormField<Sect>(
                            decoration:
                                inputDecoration(Strings.DD_HINT_SEL_SECT),
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
                          sizedBoxHeight,
                          DropdownButtonFormField<SubSect>(
                            decoration:
                                inputDecoration(Strings.DD_HINT_SEL_SUB_SECT),
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
                          sizedBoxHeight,
                          DropdownButtonFormField<Gothram>(
                            decoration:
                                inputDecoration(Strings.DD_HINT_SEL_GOTHRAM),
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
                          sizedBoxHeight,
                          DropdownButtonFormField<Vedham>(
                            decoration:
                                inputDecoration(Strings.DD_HINT_SEL_VEDHAM),
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
                          sizedBoxHeight,
                          DropdownButtonFormField<Soothram>(
                            decoration:
                                inputDecoration(Strings.DD_HINT_SEL_SOOTHRAM),
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
                          sizedBoxHeight,
                          DropdownButtonFormField<Acharyan>(
                            decoration: inputDecoration(
                                Strings.DD_HINT_SEL_ACHARYAN),
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
                          sizedBoxHeight,
                          qualificationField,
                          sizedBoxHeight,
                          presentCityField,
                          sizedBoxHeight,
                          addressField,
                          sizedBoxHeight,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 180,
                                child: Center(
                                  child: jobStatusField,
                                ),
                              ),
                              FlutterToggleTab(
                                width: 50,
                                borderRadius: 32,
                                initialIndex: 2,
                                selectedTextStyle: selectedTextStyle,
                                unSelectedTextStyle: unSelectedTextStyle,
                                labels: [Strings.DET_VED_REG_FRESHER, Strings.DET_VED_REG_EXP],
                                selectedLabelIndex: (index) {
                                  setState(() {
                                    tabTextIconJobStatusIndexSelected = index;
                                  });
                                },
                              ),
                            ],
                          ),
                          sizedBoxHeight,
                          occupationField,
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
                                            CircularProgressIndicator(
                                                value: 1.0);
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
                                            CircularProgressIndicator(
                                                value: 1.0);
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

  void onContactCountryChanged(country) {
    setState(() {
      selectedContactCountry = country;
      dbContactCountryCode = selectedContactCountry!.countryCode;
      contactCountryFieldController.text =
          Strings.PLUS + selectedContactCountry!.countryCode;
    });
  }

  void onWhatsAppCountryChanged(country) {
    setState(() {
      selectedWhatsAppCountry = country;
      dbWhatsAppCountryCode = selectedWhatsAppCountry!.countryCode;
      whatsAppCountryFieldController.text =
          Strings.PLUS + selectedWhatsAppCountry!.countryCode;
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
    selectedContactCountry = null;
    contactCountries = [];
    selectedWhatsAppCountry = null;
    whatsAppCountries = [];
    clearInput();
  }
}
