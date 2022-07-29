import 'package:deepaprakasar/database/crud/user/registervat.dart';
import 'package:deepaprakasar/database/crud/user/viewcity.dart';
import 'package:deepaprakasar/database/crud/user/viewcountry.dart';
import 'package:deepaprakasar/database/crud/user/viewdistrict.dart';
import 'package:deepaprakasar/database/crud/user/viewpincode.dart';
import 'package:deepaprakasar/database/crud/user/viewpropertyoperation.dart';
import 'package:deepaprakasar/database/crud/user/viewpropertytype.dart';
import 'package:deepaprakasar/database/crud/user/viewstate.dart';
import 'package:deepaprakasar/database/dao/city.dart';
import 'package:deepaprakasar/database/dao/country.dart';
import 'package:deepaprakasar/database/dao/district.dart';
import 'package:deepaprakasar/database/dao/pincode.dart';
import 'package:deepaprakasar/database/dao/propertyoperation.dart';
import 'package:deepaprakasar/database/dao/propertytype.dart';
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

class VatikalayamSell extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => VatikalayamSellState();
}

class VatikalayamSellState extends State<VatikalayamSell> {
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

  @override
  void initState() {
    super.initState();
    // On Page Load Get all the states from the server
    cleanSlate();

    //  DateTime now = new DateTime.now();
    //  date = new DateTime(now.year, now.month, now.day);

    viewPropertyType().then((List<PropertyType> value) {
      setState(() {
        propertyTypes = value;
      });
    });

    viewPropertyOperation(Strings.SELL).then((List<PropertyOperation> value) {
      setState(() {
        propertyOperations = value;
      });
    });

    viewState().then((List<States> value) {
      setState(() {
        states = value;
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
                contactNumberFieldController.text.isNotEmpty &&
                whatsAppNumberFieldController.text.isNotEmpty) {
              setState(() {
                _futureStatus = registerVat(
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
                    SharedPrefs().username,
                    selectedPinCode!.pinCode);
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
                        createAccountField,
                        sizedBoxHeight,
                        DropdownButtonFormField<PropertyType>(
                          decoration: inputDecoration(
                              Strings.DD_HINT_SEL_PROPERTY_TYPE),
                          value: selectedPropertyType,
                          isExpanded: true,
                          items: propertyTypes.map((PropertyType propertyType) {
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

  void cleanSlate() {
    propertyTypeList.clear();
    propertyOperationList.clear();
    countryList.clear();
    stateList.clear();
    districtList.clear();
    pinCodeList.clear();
    cityList.clear();
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
}
