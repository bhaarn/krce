import 'dart:async';

import 'package:deepaprakasar/database/crud/user/deletemmmprofile.dart';
import 'package:deepaprakasar/database/crud/user/editmmmprofile.dart';
import 'package:deepaprakasar/database/crud/user/viewacharyan.dart';
import 'package:deepaprakasar/database/crud/user/viewcountry.dart';
import 'package:deepaprakasar/database/crud/user/viewgothram.dart';
import 'package:deepaprakasar/database/crud/user/viewmmmprofileremovalreason.dart';
import 'package:deepaprakasar/database/crud/user/viewpadham.dart';
import 'package:deepaprakasar/database/crud/user/viewprofilemmm.dart';
import 'package:deepaprakasar/database/crud/user/viewrasi.dart';
import 'package:deepaprakasar/database/crud/user/viewsect.dart';
import 'package:deepaprakasar/database/crud/user/viewsoothram.dart';
import 'package:deepaprakasar/database/crud/user/viewstar.dart';
import 'package:deepaprakasar/database/crud/user/viewsubsect.dart';
import 'package:deepaprakasar/database/crud/user/viewvedham.dart';
import 'package:deepaprakasar/database/dao/acharyan.dart';
import 'package:deepaprakasar/database/dao/country.dart';
import 'package:deepaprakasar/database/dao/gothram.dart';
import 'package:deepaprakasar/database/dao/padham.dart';
import 'package:deepaprakasar/database/dao/profilemmm.dart';
import 'package:deepaprakasar/database/dao/rasi.dart';
import 'package:deepaprakasar/database/dao/reason.dart';
import 'package:deepaprakasar/database/dao/sect.dart';
import 'package:deepaprakasar/database/dao/soothram.dart';
import 'package:deepaprakasar/database/dao/star.dart';
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
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:intl/intl.dart';

class ViewEditDeleteMMMProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ViewEditDeleteMMMProfileState();
}

class ViewEditDeleteMMMProfileState extends State<ViewEditDeleteMMMProfile> {
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
  List<Country> whatsappCountries = [];
  late String dbWhatsAppCountryCode;

  Future<Status>? _futureStatus;

  var listGenderText = [Strings.DET_MMM_REG_MALE, Strings.DET_MMM_REG_FEMALE];
  late var tabTextIconGenderIndexSelected;

  var listMaritalText = [Strings.DET_MMM_REG_SINGLE, Strings.DET_MMM_REG_MARRIED];
  late var tabTextIconMaritalIndexSelected;

  var listPreferenceText = [Strings.DET_MMM_REG_SECT_ONLY, Strings.DET_MMM_REG_SUB_SECT_ONLY];
  late var tabTextIconPreferenceIndexSelected;

  Star? selectedStar;
  List<Star> stars = [];

  Padham? selectedPadham;
  List<Padham> padhams = [];

  late String obtainedDate;
  late String obtainedTime;
  late String dbDate;
  late String dbTime;

  ProfileMmm? profileMMM;
  List<ProfileMmm> profileMmms = [];

  Reason? selectedReason;
  List<Reason> reasons = [];

  @override
  void initState() {
    super.initState();
    // On Page Load Get all the states from the server
    cleanSlate();

    viewProfileMMM(SharedPrefs().username).then((List<ProfileMmm> value) {
      setState(() {
        profileMmms = value;
        if (profileMmms.first.uniqueId.isEmpty) {
        } else {
          for (int i = 0; i < profileMmms.length; i++) {
            firstNameFieldController.text = profileMmms.first.firstName;
            lastNameFieldController.text = profileMmms.first.lastName;
            motherNameFieldController.text = profileMmms.first.motherName;
            tabTextIconGenderIndexSelected =
                (profileMmms.first.gender.startsWith(Strings.DET_MMM_REG_MALE)) ? 0 : 1;
            dateOfBirthFieldController.text =
                profileMmms.first.birthDateTimeFormatted;
            birthPlaceFieldController.text = profileMmms.first.placeOfBirth;
            DateTime normalDate =
                DateTime.parse(profileMmms.first.birthDateTime);
            dbDate = DateFormat(Strings.DET_MMM_REG_DATE_FMT_DB).format(normalDate);
            dbTime = DateFormat(Strings.DET_MMM_REG_TIME_FMT_DB).format(normalDate);
            tabTextIconMaritalIndexSelected =
                profileMmms.first.maritalStatus.startsWith(Strings.DET_MMM_REG_SINGLE) ? 0 : 1;
            tabTextIconPreferenceIndexSelected =
                profileMmms.first.preference.startsWith(Strings.DET_MMM_REG_SECT_ONLY) ? 0 : 1;
            rasiFieldController.text = profileMmms.first.rasi;
            nativeCityFieldController.text = profileMmms.first.nativeCity;
            qualificationFieldController.text = profileMmms.first.qualification;
            presentCityFieldController.text = profileMmms.first.presentCity;
            occupationFieldController.text = profileMmms.first.occupation;
            salaryFieldController.text = profileMmms.first.salary;
            heightFeetFieldController.text =
                profileMmms.first.heightInch.split(Strings.DOT)[0];
            heightInchFieldController.text =
                profileMmms.first.heightInch.split(Strings.DOT)[1];
            heightCmFieldController.text = profileMmms.first.heightCm;
            weightFieldController.text = profileMmms.first.weight;
            siblingsFieldController.text = profileMmms.first.siblings;
            contactNumberFieldController.text =
                profileMmms.first.contactNumber.split(Strings.HYPHEN)[1];
            whatsAppNumberFieldController.text =
                profileMmms.first.whatsAppNumber.split(Strings.HYPHEN)[1];
            expectationFieldController.text = profileMmms.first.expectation;
            uniqueIDFieldController.text =
                Strings.DET_VW_ET_DT_MMM_PRF_UNQ_ID + profileMmms.first.uniqueId;

            viewVedham().then((List<Vedham> value) {
              vedhams = value;
              for (int i = 0; i < vedhams.length; i++) {
                if (vedhams[i].vedham == profileMmms.first.vedham) {
                  selectedVedham = vedhams[i];
                  break;
                }
              }

              viewSoothram(selectedVedham!.vedham).then((List<Soothram> value) {
                soothrams = value;
                for (int i = 0; i < soothrams.length; i++) {
                  if (soothrams[i].soothram == profileMmms.first.soothram) {
                    selectedSoothram = soothrams[i];
                    break;
                  }
                }
                onSoothramChange(selectedSoothram);
              });
            });

            viewSect().then((List<Sect> value) {
              sects = value;
              for (int i = 0; i < sects.length; i++) {
                if (sects[i].sect == profileMmms.first.sect) {
                  selectedSect = sects[i];
                  break;
                }
              }

              viewSubSect(selectedSect!.sect).then((List<SubSect> value) {
                subsects = value;
                for (int i = 0; i < subsects.length; i++) {
                  if (subsects[i].subSect == profileMmms.first.subsect) {
                    selectedSubSect = subsects[i];
                    break;
                  }
                }
                onSubSectChange(selectedSubSect);
              });

              viewAcharyan(selectedSect!.sect).then((List<Acharyan> value) {
                acharyans = value;
                for (int i = 0; i < acharyans.length; i++) {
                  if (acharyans[i].acharyan == profileMmms.first.acharyan) {
                    selectedAcharyan = acharyans[i];
                    break;
                  }
                }
                onAcharyanChanged(selectedAcharyan);
              });
            });
            viewGothram().then((List<Gothram> value) {
              gothrams = value;
              for (int i = 0; i < gothrams.length; i++) {
                if (gothrams[i].gothram == profileMmms.first.gothram) {
                  selectedGothram = gothrams[i];
                  break;
                }
              }
              onGothramChanged(selectedGothram);
            });

            viewStar().then((List<Star> value) {
              stars = value;
              for (int i = 0; i < stars.length; i++) {
                if (stars[i].star == profileMmms.first.star) {
                  selectedStar = stars[i];
                  break;
                }
              }

              viewPadham(selectedStar!.star).then((List<Padham> value) {
                padhams = value;
                for (int i = 0; i < padhams.length; i++) {
                  if (padhams[i].padham == profileMmms.first.padham) {
                    selectedPadham = padhams[i];
                    break;
                  }
                }
                onPadhamChanged(selectedPadham);
              });
            });

            viewCountry().then((List<Country> value) {
              contactCountries = value;
              for (int i = 0; i < contactCountries.length; i++) {
                if (contactCountries[i].countryCode ==
                    profileMmms.first.contactNumber.split(Strings.HYPHEN)[0]) {
                  selectedContactCountry = contactCountries[i];
                  break;
                }
              }
              onContactCountryChanged(selectedContactCountry);
            });

            viewCountry().then((List<Country> value) {
              whatsappCountries = value;
              for (int i = 0; i < whatsappCountries.length; i++) {
                if (whatsappCountries[i].countryCode ==
                    profileMmms.first.whatsAppNumber.split(Strings.HYPHEN)[0]) {
                  selectedWhatsAppCountry = whatsappCountries[i];
                  break;
                }
              }
              onWhatsAppCountryChanged(selectedWhatsAppCountry);
            });

            viewMMMProfileRemovalReason().then((List<Reason> value) {
              reasons = value;
            });
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (profileMmms.isEmpty) {
      return Scaffold(
          appBar: AppBar(
            title: Text(
              Strings.TITLE_MMM_MMM_REGISTRATION,
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
            child: Text(Strings.DET_VW_ET_DT_MMM_PRF_NO_PRF),
          ));
    } else {
      Widget roundedRectButton(String title, List<Color> gradient) {
        return Builder(builder: (BuildContext mContext) {
          return InkWell(
            onTap: () {
              switch (title) {
                case Strings.BTN_TITLE_UPDATE:
                  if (firstNameFieldController.text.isNotEmpty &&
                      lastNameFieldController.text.isNotEmpty &&
                      motherNameFieldController.text.isNotEmpty &&
                      birthPlaceFieldController.text.isNotEmpty &&
                      selectedSect!.sect.isNotEmpty &&
                      selectedSubSect!.subSect.isNotEmpty &&
                      selectedGothram!.gothram.isNotEmpty &&
                      selectedSoothram!.soothram.isNotEmpty &&
                      selectedVedham!.vedham.isNotEmpty &&
                      selectedAcharyan!.acharyan.isNotEmpty &&
                      selectedContactCountry!.countryName.isNotEmpty &&
                      selectedWhatsAppCountry!.countryName.isNotEmpty &&
                      selectedStar!.star.isNotEmpty &&
                      selectedPadham!.padham.isNotEmpty &&
                      rasiFieldController.text.isNotEmpty &&
                      nativeCityFieldController.text.isNotEmpty &&
                      qualificationFieldController.text.isNotEmpty &&
                      presentCityFieldController.text.isNotEmpty &&
                      occupationFieldController.text.isNotEmpty &&
                      salaryFieldController.text.isNotEmpty &&
                      heightCmFieldController.text.isNotEmpty &&
                      heightFeetFieldController.text.isNotEmpty &&
                      heightInchFieldController.text.isNotEmpty &&
                      weightFieldController.text.isNotEmpty &&
                      siblingsFieldController.text.isNotEmpty &&
                      contactNumberFieldController.text.isNotEmpty &&
                      whatsAppNumberFieldController.text.isNotEmpty) {
                    setState(() {
                      _futureStatus = editMmmProfile(
                          firstNameFieldController.text,
                          lastNameFieldController.text,
                          motherNameFieldController.text,
                          listGenderText[tabTextIconGenderIndexSelected],
                          dbDate + Strings.SPACE + dbTime,
                          birthPlaceFieldController.text,
                          listMaritalText[tabTextIconMaritalIndexSelected],
                          selectedSect!.sect,
                          selectedSubSect!.subSect,
                          selectedGothram!.gothram,
                          selectedSoothram!.soothram,
                          selectedVedham!.vedham,
                          selectedAcharyan!.acharyan,
                          selectedStar!.star,
                          selectedPadham!.padham,
                          rasiFieldController.text,
                          nativeCityFieldController.text,
                          qualificationFieldController.text,
                          presentCityFieldController.text,
                          occupationFieldController.text,
                          salaryFieldController.text,
                          heightCmFieldController.text,
                          heightFeetFieldController.text +
                              Strings.DOT +
                              heightInchFieldController.text,
                          weightFieldController.text,
                          siblingsFieldController.text,
                          dbContactCountryCode +
                              Strings.HYPHEN +
                              contactNumberFieldController.text,
                          dbWhatsAppCountryCode +
                              Strings.HYPHEN +
                              whatsAppNumberFieldController.text,
                          expectationFieldController.text,
                          listPreferenceText[
                              tabTextIconPreferenceIndexSelected],
                          profileMmms.first.uniqueId);
                    });
                  } else {
                    return showAlertDialogSingle(context, Strings.ALERT_HDR_DATA_INPUT_MISSING,
                        Strings.ALERT_BDY_DATA_INPUT_MISSING);

                    /*
                    Navigator.pop(context);
                     Navigator.push(
              context,
              PageRouteBuilder(
                barrierDismissible: true,
                opaque: false,
                pageBuilder: (_, anim1, anim2) => MyDialog(),
              ),
            );
                     */
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
            Strings.TITLE_MMM_MMM_REGISTRATION,
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
                          updateAccountField,
                          sizedBoxHeight,
                          uniqueIDField,
                          sizedBoxHeight,
                          firstNameField,
                          sizedBoxHeight,
                          lastNameField,
                          sizedBoxHeight,
                          motherNameField,
                          sizedBoxHeight,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                initialIndex: tabTextIconGenderIndexSelected,
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
                          Row(
                            children: [
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
                                              obtainedDate + Strings.SPACE + obtainedTime;
                                        },
                                      );
                                    });
                                  },
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                height: 50,
                                child: ElevatedButton(
                                  style: elevatedButtonStyle,
                                  child: Text(Strings.BTN_TITLE_TOB),
                                  onPressed: () {
                                    setState(() {
                                      DatePicker.showTime12hPicker(
                                        context,
                                        showTitleActions: true,
                                        onConfirm: (date) {
                                          obtainedTime =
                                              DateFormat(Strings.DET_MMM_REG_TIME_FMT_IN).format(date);
                                          dbTime = DateFormat(Strings.DET_MMM_REG_TIME_FMT_DB)
                                              .format(date);
                                          print(dbDate + Strings.SPACE + dbTime);
                                          dateOfBirthFieldController.text =
                                              obtainedDate + Strings.SPACE + obtainedTime;
                                        },
                                      );
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          sizedBoxHeight,
                          dateOfBirthField,
                          sizedBoxHeight,
                          birthPlaceField,
                          sizedBoxHeight,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                width: 180,
                                child: Center(
                                  child: maritalStatusField,
                                ),
                              ),
                              FlutterToggleTab(
                                width: 50,
                                borderRadius: 32,
                                initialIndex: tabTextIconMaritalIndexSelected,
                                selectedTextStyle: selectedTextStyle,
                                unSelectedTextStyle: unSelectedTextStyle,
                                labels: [Strings.DET_MMM_REG_SINGLE, Strings.DET_MMM_REG_MARRIED],
                                selectedLabelIndex: (index) {
                                  setState(() {
                                    tabTextIconMaritalIndexSelected = index;
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
                          DropdownButtonFormField<Star>(
                            decoration:
                                inputDecoration(Strings.DD_HINT_SEL_STAR),
                            value: selectedStar,
                            isExpanded: true,
                            items: stars.map((Star star) {
                              return DropdownMenuItem<Star>(
                                value: star,
                                child: Text(star.star),
                              );
                            }).toList(),
                            onChanged: onStarChanged,
                          ),
                          sizedBoxHeight,
                          DropdownButtonFormField<Padham>(
                            decoration: inputDecoration(
                                Strings.DD_HINT_SEL_PADHAM),
                            value: selectedPadham,
                            isExpanded: true,
                            items: padhams.map((Padham padham) {
                              return DropdownMenuItem<Padham>(
                                value: padham,
                                child: Text(padham.padham),
                              );
                            }).toList(),
                            onChanged: onPadhamChanged,
                          ),
                          sizedBoxHeight,
                          rasiField,
                          sizedBoxHeight,
                          nativeCityField,
                          sizedBoxHeight,
                          qualificationField,
                          sizedBoxHeight,
                          presentCityField,
                          sizedBoxHeight,
                          occupationField,
                          sizedBoxHeight,
                          salaryField,
                          sizedBoxHeight,
                          Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 5,
                                child: heightFeetField,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 5,
                                child: heightInchField,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 3,
                                height: 50,
                                child: ElevatedButton(
                                  style: elevatedButtonStyle,
                                  child: Text(Strings.BTN_TITLE_CONVERT_FEET_CMS),
                                  onPressed: () {
                                    setState(() {
                                      var heightInFeet = int.parse(
                                          heightFeetFieldController.text);
                                      assert(heightInFeet is int);
                                      var heightInInch = int.parse(
                                          heightInchFieldController.text);
                                      assert(heightInInch is int);
                                      int totalHeightInInches =
                                          (heightInFeet * 12) + (heightInInch);
                                      double heightInCms =
                                          totalHeightInInches * 2.54;
                                      heightCmFieldController.text =
                                          heightInCms.toStringAsFixed(1);
                                    });
                                  },
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 3.8,
                                child: heightCmField,
                              ),
                            ],
                          ),
                          sizedBoxHeight,
                          weightField,
                          sizedBoxHeight,
                          siblingsField,
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
                            items: whatsappCountries.map((Country country) {
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
                          expectationField,
                          sizedBoxHeight,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              FlutterToggleTab(
                                width: 100,
                                borderRadius: 32,
                                initialIndex:
                                    tabTextIconPreferenceIndexSelected,
                                selectedTextStyle: selectedTextStyle,
                                unSelectedTextStyle: unSelectedTextStyle,
                                labels: [
                                  Strings.DET_MMM_REG_SECT_ONLY,
                                  Strings.DET_MMM_REG_SUB_SECT_ONLY
                                ],
                                selectedLabelIndex: (index) {
                                  setState(() {
                                    tabTextIconPreferenceIndexSelected = index;
                                  });
                                },
                              ),
                            ],
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
                                            cleanSlate();
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
        ),
      );
    }
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
      print(selectedGothram!.gothram);
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

  void onStarChanged(star) {
    setState(() {
      selectedStar = star;
      padhams = [];
      selectedPadham = null;
    });
    viewPadham(selectedStar!.star).then((List<Padham> value) {
      setState(() {
        padhams = value;
      });
    });
  }

  void onPadhamChanged(padham) {
    setState(() {
      selectedPadham = padham;
    });
    viewRasi(selectedStar!.star, selectedPadham!.padham).then((Rasi value) {
      setState(() {
        rasiFieldController.text = value.rasi;
      });
    });
  }

  void cleanSlate() {
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
    whatsappCountries = [];
    selectedStar = null;
    stars = [];
    selectedPadham = null;
    padhams = [];
    clearInput();
  }

  showAlertDialogDropDown(BuildContext context, String title) {
    // set up the button
    Widget okButton = TextButton(
      child: Text(Strings.OK),
      onPressed: () {
        setState(() {
          _futureStatus = deleteMMMProfile(SharedPrefs().username,
              profileMmms.first.uniqueId, selectedReason!.reason);
        });
        cleanSlate();
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
