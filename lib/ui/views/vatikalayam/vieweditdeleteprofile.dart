import 'dart:async';

import 'package:deepaprakasar/database/crud/user/deletevatprofile.dart';
import 'package:deepaprakasar/database/crud/user/editvatprofile.dart';
import 'package:deepaprakasar/database/crud/user/viewcity.dart';
import 'package:deepaprakasar/database/crud/user/viewcountry.dart';
import 'package:deepaprakasar/database/crud/user/viewdistrict.dart';
import 'package:deepaprakasar/database/crud/user/viewpincode.dart';
import 'package:deepaprakasar/database/crud/user/viewprofilevat.dart';
import 'package:deepaprakasar/database/crud/user/viewpropertyoperation.dart';
import 'package:deepaprakasar/database/crud/user/viewpropertytype.dart';
import 'package:deepaprakasar/database/crud/user/viewstate.dart';
import 'package:deepaprakasar/database/crud/user/viewvatprofileremovalreason.dart';
import 'package:deepaprakasar/database/dao/city.dart';
import 'package:deepaprakasar/database/dao/country.dart';
import 'package:deepaprakasar/database/dao/district.dart';
import 'package:deepaprakasar/database/dao/pincode.dart';
import 'package:deepaprakasar/database/dao/profilevat.dart';
import 'package:deepaprakasar/database/dao/propertyoperation.dart';
import 'package:deepaprakasar/database/dao/propertytype.dart';
import 'package:deepaprakasar/database/dao/reason.dart';
import 'package:deepaprakasar/database/dao/states.dart';
import 'package:deepaprakasar/database/dao/status.dart';
import 'package:deepaprakasar/resources/texts/strings.dart';
import 'package:deepaprakasar/ui/widgets/fileupload.dart';
import 'package:deepaprakasar/ui/widgets/showalertdialog.dart';
import 'package:deepaprakasar/ui/widgets/styles.dart';
import 'package:deepaprakasar/ui/widgets/textfield.dart';
import 'package:deepaprakasar/utils/sharedpreferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ViewEditDeleteVATProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ViewEditDeleteVATProfileState();
}

class ViewEditDeleteVATProfileState extends State<ViewEditDeleteVATProfile> {
  States? selectedState;
  District? selectedDistrict;
  City? selectedCity;
  PinCode? selectedPinCode;

  PropertyType? selectedPropertyType;
  PropertyOperation? selectedPropertyOperation;

  List<States> states = [];
  List<District> districts = [];
  List<City> cities = [];
  List<PinCode> pinCodes = [];

  List<PropertyType> propertyTypes = [];
  List<PropertyOperation> propertyOperations = [];

  Country? selectedContactCountry;
  List<Country> contactCountries = [];
  late String dbContactCountryCode;

  Country? selectedWhatsAppCountry;
  List<Country> whatsAppCountries = [];
  late String dbWhatsAppCountryCode;

  late String fileName;

//  late DateTime date;

  Future<Status>? _futureStatus;

  ProfileVat? profileVAT;
  List<ProfileVat> profileVats = [];

  Reason? selectedReason;
  List<Reason> reasons = [];

  @override
  void initState() {
    super.initState();
    // On Page Load Get all the states from the server
    // cleanSlate();

    viewProfileVat(SharedPrefs().username).then((List<ProfileVat> value) {
      setState(() {
        profileVats = value;

        if (profileVats.first.uniqueId.isEmpty) {
        } else {
          addressFieldController.text = profileVats.first.address;
          detailsFieldController.text = profileVats.first.details;
          fileNameFieldController.text = profileVats.first.photoPath;
          contactNumberFieldController.text =
              profileVats.first.contactNumber.split(Strings.HYPHEN)[1];
          whatsAppNumberFieldController.text =
              profileVats.first.whatsAppNumber.split(Strings.HYPHEN)[1];
          uniqueIDFieldController.text =
              Strings.DET_VW_ET_DT_VAT_PRF_UNQ_ID + profileVats.first.uniqueId;

          viewPropertyType().then((List<PropertyType> value) {
            propertyTypes = value;
            for (int i = 0; i < propertyTypes.length; i++) {
              if (propertyTypes[i].type == profileVats.first.propertyType) {
                selectedPropertyType = propertyTypes[i];
                break;
              }
            }
            onPropertyTypeChanged(selectedPropertyType);
          });

          viewPropertyOperation(Strings.SELL)
              .then((List<PropertyOperation> value) {
            propertyOperations = value;
            for (int i = 0; i < propertyOperations.length; i++) {
              if (propertyOperations[i].operation ==
                  profileVats.first.propertyOperation) {
                selectedPropertyOperation = propertyOperations[i];
                break;
              }
            }
            onPropertyOperationChanged(selectedPropertyOperation);
          });

          viewState().then((List<States> value) {
            states = value;
            for (int i = 0; i < states.length; i++) {
              if (states[i].states == profileVats.first.state) {
                selectedState = states[i];
                break;
              }
            }

            viewDistrict(selectedState!.states).then((List<District> value) {
              districts = value;
              for (int i = 0; i < districts.length; i++) {
                if (districts[i].district == profileVats.first.district) {
                  selectedDistrict = districts[i];
                  break;
                }
              }
              viewPinCode(selectedState!.states, selectedDistrict!.district)
                  .then((List<PinCode> value) {
                pinCodes = value;
                for (int i = 0; i < pinCodes.length; i++) {
                  if (pinCodes[i].pinCode == profileVats.first.pinCode) {
                    selectedPinCode = pinCodes[i];
                    break;
                  }
                }
                viewCity(selectedPinCode!.pinCode).then((List<City> value) {
                  cities = value;
                  for (int i = 0; i < cities.length; i++) {
                    if (cities[i].city == profileVats.first.city) {
                      selectedCity = cities[i];
                      break;
                    }
                  }
                  onCityChanged(selectedCity);
                });
              });
            });
          });

          viewCountry().then((List<Country> value) {
            contactCountries = value;
            for (int i = 0; i < contactCountries.length; i++) {
              if (contactCountries[i].countryCode ==
                  profileVats.first.contactNumber.split(Strings.HYPHEN)[0]) {
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
                  profileVats.first.whatsAppNumber.split(Strings.HYPHEN)[0]) {
                selectedWhatsAppCountry = whatsAppCountries[i];
                break;
              }
            }
            onWhatsAppCountryChanged(selectedWhatsAppCountry);
          });

          viewVATProfileRemovalReason().then((List<Reason> value) {
            reasons = value;
          });

        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (profileVats.isEmpty) {
      return Scaffold(
          appBar: AppBar(
            title: Text(
              Strings.TITLE_VAT_REGISTRATION,
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
            child: Text(Strings.DET_VW_ET_DT_VAT_PRF_NO_PRF),
          ));
    } else {
      Widget roundedRectButton(String title, List<Color> gradient) {
        return Builder(builder: (BuildContext mContext) {
          return InkWell(
            onTap: () {
              switch (title) {
                case Strings.BTN_TITLE_UPDATE:
                  if (selectedPropertyType!.type.isNotEmpty &&
                      selectedPropertyOperation!.operation.isNotEmpty &&
                      selectedState!.states.isNotEmpty &&
                      selectedDistrict!.district.isNotEmpty &&
                      selectedCity!.city.isNotEmpty &&
                      selectedPinCode!.pinCode.isNotEmpty &&
                      selectedContactCountry!.countryName.isNotEmpty &&
                      selectedWhatsAppCountry!.countryName.isNotEmpty &&
                      addressFieldController.text.isNotEmpty &&
                      detailsFieldController.text.isNotEmpty &&
                      fileNameFieldController.text.isNotEmpty &&
                      contactNumberFieldController.text.isNotEmpty &&
                      whatsAppNumberFieldController.text.isNotEmpty) {
                    setState(() {
                      _futureStatus = editVatProfile(
                          selectedPropertyType!.type,
                          selectedCity!.city,
                          selectedDistrict!.district,
                          selectedState!.states,
                          addressFieldController.text,
                          detailsFieldController.text,
                          fileNameFieldController.text,
                          selectedPropertyOperation!.operation,
                          Strings.AVBL,
                          dbContactCountryCode +
                              Strings.HYPHEN +
                              contactNumberFieldController.text,
                          dbWhatsAppCountryCode +
                              Strings.HYPHEN +
                              whatsAppNumberFieldController.text,
                          profileVats.first.uniqueId,
                          selectedPinCode!.pinCode);
                    });
                  } else {
                    return showAlertDialogSingle(context, Strings.ALERT_HDR_DATA_INPUT_MISSING,
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
            Strings.TITLE_VAT_REGISTRATION,
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
                          Center(
                            child: Image.network(Strings.TRANSPORT_PROTOCOL + Strings.WEB_CONNECTOR
                                + Strings.BACK_SLASH + Strings.BACKEND + profileVats.first.photoPath),
                          ),
                          sizedBoxHeight,
                          DropdownButtonFormField<PropertyType>(
                            decoration: inputDecoration(
                                Strings.DD_HINT_SEL_PROPERTY_TYPE),
                            value: selectedPropertyType,
                            isExpanded: true,
                            items:
                                propertyTypes.map((PropertyType propertyType) {
                              return DropdownMenuItem<PropertyType>(
                                value: propertyType,
                                child: Text(propertyType.type),
                              );
                            }).toList(),
                            onChanged: onPropertyTypeChanged,
                          ),
                          sizedBoxHeight,
                          DropdownButtonFormField<States>(
                            decoration:
                                inputDecoration(Strings.DD_HINT_SEL_STATE),
                            value: selectedState,
                            isExpanded: true,
                            items: states.map((States states) {
                              return DropdownMenuItem<States>(
                                value: states,
                                child: Text(states.states),
                              );
                            }).toList(),
                            onChanged: onStateChanged,
                          ),
                          sizedBoxHeight,
                          DropdownButtonFormField<District>(
                            decoration:
                                inputDecoration(Strings.DD_HINT_SEL_DISTRICT),
                            value: selectedDistrict,
                            isExpanded: true,
                            items: districts.map((District district) {
                              return DropdownMenuItem<District>(
                                value: district,
                                child: Text(district.district),
                              );
                            }).toList(),
                            onChanged: onDistrictChanged,
                          ),
                          sizedBoxHeight,
                          DropdownButtonFormField<PinCode>(
                            decoration:
                                inputDecoration(Strings.DD_HINT_SEL_PIN_CODE),
                            value: selectedPinCode,
                            isExpanded: true,
                            items: pinCodes.map((PinCode pinCode) {
                              return DropdownMenuItem<PinCode>(
                                value: pinCode,
                                child: Text(pinCode.pinCode),
                              );
                            }).toList(),
                            onChanged: onPinCodeChanged,
                          ),
                          sizedBoxHeight,
                          DropdownButtonFormField<City>(
                            decoration:
                                inputDecoration(Strings.DD_HINT_SEL_AREA),
                            value: selectedCity,
                            isExpanded: true,
                            items: cities.map((City city) {
                              return DropdownMenuItem<City>(
                                value: city,
                                child: Text(city.city),
                              );
                            }).toList(),
                            onChanged: onCityChanged,
                          ),
                          sizedBoxHeight,
                          addressField,
                          sizedBoxHeight,
                          detailsField,
                          sizedBoxHeight,
                          fileNameField,
                          sizedBoxHeight,
                          Container(
                            width: MediaQuery.of(context).size.width / 2,
                            height: 50,
                            child: ElevatedButton(
                              style: elevatedButtonStyle,
                              child: Text(Strings.BTN_TITLE_BROWSE_IMAGE),
                              onPressed: () {
                                setState(() {
                                  _navigateAndGetFile(context);
                                });
                              },
                            ),
                          ),
                          sizedBoxHeight,
                          DropdownButtonFormField<PropertyOperation>(
                            decoration:
                                inputDecoration(Strings.DD_HINT_SEL_OPERATION),
                            value: selectedPropertyOperation,
                            isExpanded: true,
                            items: propertyOperations
                                .map((PropertyOperation propertyOperation) {
                              return DropdownMenuItem<PropertyOperation>(
                                value: propertyOperation,
                                child: Text(propertyOperation.operation),
                              );
                            }).toList(),
                            onChanged: onPropertyOperationChanged,
                          ),
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
        ),
      );
    }
  }

  void onStateChanged(states) {
    setState(() {
      selectedState = states;
      districts = [];
      selectedDistrict = null;
    });
    viewDistrict(selectedState!.states).then((List<District> value) {
      setState(() {
        districts = value;
      });
    });
  }

  void onDistrictChanged(district) {
    setState(() {
      selectedDistrict = district;
      pinCodes = [];
      selectedPinCode = null;
    });

    viewPinCode(selectedState!.states, selectedDistrict!.district)
        .then((List<PinCode> value) {
      setState(() {
        pinCodes = value;
      });
    });
  }

  onPinCodeChanged(pinCode) {
    setState(() {
      selectedPinCode = pinCode;
      cities = [];
      selectedCity = null;
    });

    viewCity(selectedPinCode!.pinCode).then((List<City> value) {
      setState(() {
        cities = value;
      });
    });
  }

  void onCityChanged(city) {
    setState(() {
      selectedCity = city;
    });
  }

  void onPropertyTypeChanged(propertyType) {
    setState(() {
      selectedPropertyType = propertyType;
    });
  }

  void onPropertyOperationChanged(propertyOperation) {
    setState(() {
      selectedPropertyOperation = propertyOperation;
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
    selectedPropertyType = null;
    propertyTypes = [];
    selectedPropertyOperation = null;
    propertyOperations = [];
    selectedState = null;
    states = [];
    selectedDistrict = null;
    districts = [];
    selectedPinCode = null;
    pinCodes = [];
    selectedCity = null;
    cities = [];
    selectedContactCountry = null;
    contactCountries = [];
    selectedWhatsAppCountry = null;
    whatsAppCountries = [];
    clearInput();
  }

  showAlertDialogDropDown(BuildContext context, String title) {
    // set up the button
    Widget okButton = TextButton(
      child: Text(Strings.OK),
      onPressed: () {
        setState(() {
          _futureStatus = deleteVATProfile(SharedPrefs().username,
              profileVats.first.uniqueId, selectedReason!.reason);
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

  void _navigateAndGetFile(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FileUploadWithHttp()),
    );
    fileName = result;
    fileNameFieldController.text = fileName;
    showAlertDialogSingle(
        context,
        Strings.ALERT_HDR_FILE_UPLOADED,
        Strings.ALERT_BDY_FILE_UPLOADED);
  }
}
