import 'package:deepaprakasar/database/crud/user/deletekaiprofile.dart';
import 'package:deepaprakasar/database/crud/user/editkaiprofile.dart';
import 'package:deepaprakasar/database/crud/user/viewcountry.dart';
import 'package:deepaprakasar/database/crud/user/viewkainkaryam.dart';
import 'package:deepaprakasar/database/crud/user/viewkaiprofileremovalreason.dart';
import 'package:deepaprakasar/database/crud/user/viewkaitype.dart';
import 'package:deepaprakasar/database/crud/user/viewprofilekai.dart';
import 'package:deepaprakasar/database/crud/user/viewsubkainkaryam.dart';
import 'package:deepaprakasar/database/dao/country.dart';
import 'package:deepaprakasar/database/dao/kainkaryam.dart';
import 'package:deepaprakasar/database/dao/kaitype.dart';
import 'package:deepaprakasar/database/dao/profilekai.dart';
import 'package:deepaprakasar/database/dao/reason.dart';
import 'package:deepaprakasar/database/dao/status.dart';
import 'package:deepaprakasar/database/dao/subkainkaryam.dart';
import 'package:deepaprakasar/resources/texts/strings.dart';
import 'package:deepaprakasar/ui/widgets/showalertdialog.dart';
import 'package:deepaprakasar/ui/widgets/styles.dart';
import 'package:deepaprakasar/ui/widgets/textfield.dart';
import 'package:deepaprakasar/utils/sharedpreferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class ViewEditDeleteKAIProfile extends StatefulWidget {
  @override
  ViewEditDeleteKAIProfileState createState() => ViewEditDeleteKAIProfileState();
}

class ViewEditDeleteKAIProfileState extends State<ViewEditDeleteKAIProfile> {

  KaiType? selectedKaiType;
  Kainkaryam? selectedKainkaryam;
  SubKainkaryam? selectedSubKainkaryam;
  List<KaiType> kaiTypes = [];
  List<Kainkaryam> kainkaryams = [];
  List<SubKainkaryam> subKainkaryams = [];

  Country? selectedContactCountry;
  List<Country> contactCountries = [];
  late String dbContactCountryCode;

  Country? selectedWhatsAppCountry;
  List<Country> whatsAppCountries = [];
  late String dbWhatsAppCountryCode;

  Future<Status>? _futureStatus;

  ProfileKai? profileKAI;
  List<ProfileKai> profileKais = [];

  Reason? selectedReason;
  List<Reason> reasons = [];

  late String obtainedDate;
  late String dbDate;

  @override
  void initState() {
    super.initState();
    cleanSlate();

    viewProfileKai(SharedPrefs().username).then((List<ProfileKai> value) {
      setState(() {
        profileKais = value;
        if (profileKais.first.uniqueID.isEmpty) {
        } else {
          detailsFieldController.text = profileKais.first.details;
          dateOfBirthFieldController.text = profileKais.first.requiredDateFormatted;
          DateTime normalDate = DateTime.parse(profileKais.first.requiredDate);
          dbDate = DateFormat(Strings.DET_MMM_REG_DATE_FMT_DB).format(normalDate);
          contactNumberFieldController.text =
          profileKais.first.contactNumber.split(Strings.HYPHEN)[1];
          whatsAppNumberFieldController.text =
          profileKais.first.whatsAppNumber.split(Strings.HYPHEN)[1];
          uniqueIDFieldController.text =
              Strings.DET_VW_ET_DT_VED_PRF_UNQ_ID + profileKais.first.uniqueID;

          viewKaiType().then((List<KaiType> value) {
            kaiTypes = value;
            for (int i = 0; i < kaiTypes.length; i++) {
              if (kaiTypes[i].type == profileKais.first.type) {
                selectedKaiType = kaiTypes[i];
                break;
              }
            }

            viewKainkaryam(selectedKaiType!.type).then((List<Kainkaryam> value) {
              kainkaryams = value;
              for (int i = 0; i < kainkaryams.length; i++) {
                if (kainkaryams[i].kainkaryam == profileKais.first.kainkaryam) {
                  selectedKainkaryam = kainkaryams[i];
                  break;
                }
              }

              viewSubKainkaryam(selectedKainkaryam!.kainkaryam).then((List<SubKainkaryam> value) {
                subKainkaryams = value;
                for (int i = 0; i < subKainkaryams.length; i++) {
                  if (subKainkaryams[i].subKainkaryam == profileKais.first.subKainkaryam) {
                    selectedSubKainkaryam = subKainkaryams[i];
                    break;
                  }
                }
                onSubKainkaryamChanged(selectedSubKainkaryam);
              });
            });
          });

          viewCountry().then((List<Country> value) {
            contactCountries = value;
            for (int i = 0; i < contactCountries.length; i++) {
              if (contactCountries[i].countryCode ==
                  profileKais.first.contactNumber.split(Strings.HYPHEN)[0]) {
                selectedContactCountry = contactCountries[i];
                break;
              }
            }
            onContactCountryChanged(selectedContactCountry);
          });

          viewCountry().then((List<Country> value) {
            whatsAppCountries = value;
            for (int i = 0; i < whatsAppCountries.length; i++) {
              if (whatsAppCountries[i].countryCode ==
                  profileKais.first.whatsAppNumber.split(Strings.HYPHEN)[0]) {
                selectedWhatsAppCountry = whatsAppCountries[i];
                break;
              }
            }
            onWhatsAppCountryChanged(selectedWhatsAppCountry);
          });

          viewKAIProfileRemovalReason().then((List<Reason> value) {
            reasons = value;
          });

        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (profileKais.isEmpty) {
      return Scaffold(
          appBar: AppBar(
            title: Text(
              Strings.TITLE_KAI_KAI_REGISTRATION,
              style: new TextStyle(color: Colors.white),
            ),
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Container(
            alignment: Alignment.center,
            child: Text(Strings.DET_VW_ET_DT_KAI_PRF_NO_PRF),
          ));
    } else {
      Widget roundedRectButton(String title, List<Color> gradient) {
        return Builder(builder: (BuildContext mContext) {
          return InkWell(
            onTap: () {
              switch (title) {
                case Strings.BTN_TITLE_UPDATE:
                  if (detailsFieldController.text.isNotEmpty &&
                      selectedKaiType!.type.isNotEmpty &&
                      selectedKainkaryam!.kainkaryam.isNotEmpty &&
                      selectedSubKainkaryam!.subKainkaryam.isNotEmpty &&
                      selectedContactCountry!.countryName.isNotEmpty &&
                      selectedWhatsAppCountry!.countryName.isNotEmpty &&
                      contactNumberFieldController.text.isNotEmpty &&
                      whatsAppNumberFieldController.text.isNotEmpty) {
                    setState(() {
                      _futureStatus = editKaiProfile(
                        selectedKainkaryam!.kainkaryam,
                        selectedSubKainkaryam!.subKainkaryam,
                        selectedKaiType!.type,
                        detailsFieldController.text,
                        dbDate,
                        dbContactCountryCode +
                            Strings.HYPHEN +
                            contactNumberFieldController.text,
                        dbWhatsAppCountryCode +
                            Strings.HYPHEN +
                            whatsAppNumberFieldController.text,
                        SharedPrefs().username,
                      );
                    });
                  } else {
                    return showAlertDialogSingle(
                        context, Strings.ALERT_HDR_DATA_INPUT_MISSING,
                        Strings.ALERT_BDY_DATA_INPUT_MISSING);
                  }
                  break;
                case Strings.BTN_TITLE_DELETE:
                  showAlertDialogDropDown(
                      context, Strings.DD_HINT_SEL_REASON);
                  break;
              }
            },
            splashColor: Colors.lightBlue,
            child: Container(
              alignment: Alignment.center,
              height: MediaQuery
                  .of(mContext)
                  .size
                  .height * 0.05,
              width: MediaQuery
                  .of(mContext)
                  .size
                  .width / 3,
              decoration: shapeDecoration(gradient),
              child: Text(title, style: normalTextStyle),
            ),
          );
        });
      }

      return Scaffold(
          appBar: AppBar(
            title: Text(
              Strings.TITLE_KAI_KAI_REGISTRATION,
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
                              children: <Widget>[
                                sizedBoxHeight,
                                updateAccountField,
                                sizedBoxHeight,
                                DropdownButtonFormField<KaiType>(
                                  decoration:
                                  inputDecoration(Strings.DD_HINT_SEL_KAI_TYPE),
                                  value: selectedKaiType,
                                  isExpanded: true,
                                  items: kaiTypes.map((KaiType kaiType) {
                                    return DropdownMenuItem<KaiType>(
                                      value: kaiType,
                                      child: Text(kaiType.type),
                                    );
                                  }).toList(),
                                  onChanged: onKaiTypeChanged,
                                ),
                                sizedBoxHeight,
                                DropdownButtonFormField<Kainkaryam>(
                                  decoration:
                                  inputDecoration(
                                      Strings.DD_HINT_SEL_KAINKARYAM),
                                  value: selectedKainkaryam,
                                  isExpanded: true,
                                  items: kainkaryams.map((
                                      Kainkaryam kainkaryam) {
                                    return DropdownMenuItem<Kainkaryam>(
                                      value: kainkaryam,
                                      child: Text(kainkaryam.kainkaryam),
                                    );
                                  }).toList(),
                                  onChanged: onKainkaryamChanged,
                                ),
                                sizedBoxHeight,
                                DropdownButtonFormField<SubKainkaryam>(
                                  decoration:
                                  inputDecoration(
                                      Strings.DD_HINT_SEL_SUB_KAINKARYAM),
                                  value: selectedSubKainkaryam,
                                  isExpanded: true,
                                  items: subKainkaryams.map((
                                      SubKainkaryam subKainkaryam) {
                                    return DropdownMenuItem<SubKainkaryam>(
                                      value: subKainkaryam,
                                      child: Text(subKainkaryam.subKainkaryam),
                                    );
                                  }).toList(),
                                  onChanged: onSubKainkaryamChanged,
                                ),
                                sizedBoxHeight,
                                detailsField,
                                sizedBoxHeight,
                                Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  height: 50,
                                  child: ElevatedButton(
                                    style: elevatedButtonStyle,
                                    child: Text(Strings.BTN_TITLE_REQ_DATE),
                                    onPressed: () {
                                      setState(() {
                                        DatePicker.showDatePicker(
                                          context,
                                          showTitleActions: true,
                                          minTime: DateTime(Strings.DET_MMM_REG_MIN_YEAR,
                                              Strings.DET_MMM_REG_MIN_MONTH, Strings.DET_MMM_REG_MIN_DATE),
                                          maxTime: DateTime(Strings.DET_MMM_REG_MAX_YEAR,
                                              Strings.DET_MMM_REG_MAX_MONTH, Strings.DET_MMM_REG_MAX_DATE),
                                          onConfirm: (date) {
                                            obtainedDate =
                                            DateFormat(Strings.DET_MMM_REG_DATE_FMT_IN)
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
                                DropdownButtonFormField<Country>(
                                  decoration:
                                  inputDecoration(Strings.DD_HINT_SEL_COUNTRY),
                                  value: selectedContactCountry,
                                  isExpanded: true,
                                  items: contactCountries.map((
                                      Country country) {
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
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width / 3,
                                      child: contactCountryField,
                                    ),
                                    Container(
                                      width: (MediaQuery
                                          .of(context)
                                          .size
                                          .width) -
                                          (MediaQuery
                                              .of(context)
                                              .size
                                              .width / 3),
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
                                  items: whatsAppCountries.map((
                                      Country country) {
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
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width / 3,
                                      child: whatsappCountryField,
                                    ),
                                    Container(
                                      width: (MediaQuery
                                          .of(context)
                                          .size
                                          .width) -
                                          (MediaQuery
                                              .of(context)
                                              .size
                                              .width / 3),
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
                                            .startsWith(Strings.SUCCESS)) {
                                          SchedulerBinding.instance!
                                              .addPostFrameCallback((_) {
                                            CircularProgressIndicator(
                                                value: 1.0);
                                            return showAlertDialogSingle(
                                                context,
                                                Strings.ALERT_HDR_UPD_SUCCESS,
                                                snapshot.data!.status);
                                          });
                                        } else if (snapshot.data!.status
                                            .startsWith(Strings.UNIQUE_ID)) {
                                          SchedulerBinding.instance!
                                              .addPostFrameCallback((_) {
                                            CircularProgressIndicator(
                                                value: 1.0);
                                            cleanSlate();
                                            return showAlertDialogSingle(
                                                context,
                                                Strings.ALERT_HDR_DEL_SUCCESS,
                                                snapshot.data!.status);
                                          });
                                        } else if (snapshot.data!.status.startsWith(
                                            Strings.DEL_FAILURE)) {
                                          SchedulerBinding.instance!
                                              .addPostFrameCallback((_) {
                                            CircularProgressIndicator(
                                                value: 1.0);
                                            return showAlertDialogSingle(
                                                context,
                                                Strings.ALERT_HDR_DEL_FAILURE,
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    roundedRectButton(
                                      Strings.BTN_TITLE_UPDATE,
                                      [
                                        Colors.pink,
                                        Colors.amber,
                                      ],
                                    ),
                                    roundedRectButton(
                                      Strings.BTN_TITLE_DELETE,
                                      [
                                        Colors.pink,
                                        Colors.amber,
                                      ],
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
  }

  void onKaiTypeChanged(kaiType) {
    setState(() {
      selectedKaiType = kaiType;
      kainkaryams = [];
      selectedKainkaryam = null;
    });
    viewKainkaryam(selectedKaiType!.type).then((List<Kainkaryam> value) {
      setState(() {
        kainkaryams = value;
      });
    });
  }

  void onKainkaryamChanged(kainkaryam) {
    setState(() {
      selectedKainkaryam = kainkaryam;
      subKainkaryams = [];
      selectedSubKainkaryam = null;
    });
    viewSubKainkaryam(selectedKainkaryam!.kainkaryam).then((List<SubKainkaryam> value) {
      setState(() {
        subKainkaryams = value;
      });
    });
  }

  void onSubKainkaryamChanged(subKainkaryam) {
    setState(() {
      selectedSubKainkaryam = subKainkaryam;
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
    kaiTypeList.clear();
    kainkaryamList.clear();
    subKainkaryamList.clear();
    countryList.clear();
    selectedKaiType = null;
    selectedKainkaryam = null;
    selectedSubKainkaryam = null;
    selectedContactCountry = null;
    selectedWhatsAppCountry = null;
    kaiTypes = [];
    kainkaryams = [];
    subKainkaryams = [];
    contactCountries = [];
    whatsAppCountries = [];
    clearInput();
  }

  showAlertDialogDropDown(BuildContext context, String title) {
    // set up the button
    Widget okButton = TextButton(
      child: Text(Strings.OK),
      onPressed: () {
        setState(() {
          _futureStatus = deleteKAIProfile(SharedPrefs().username,
              profileKais.first.uniqueID, selectedReason!.reason);
        });
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: DropdownButtonFormField<Reason>(
        decoration: inputDecoration(Strings.DD_HINT_SEL_REASON),
        value: selectedReason,
        isExpanded: true,
        items: reasons.map((Reason reason) {
          return DropdownMenuItem<Reason>(
            value: reason,
            child: Text(reason.reason),
          );
        }).toList(),
        onChanged: onReasonChanged,
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void onReasonChanged(reason) {
    setState(() {
      selectedReason = reason;
    });
  }
}