import 'package:deepaprakasar/database/crud/user/viewdistrict.dart';
import 'package:deepaprakasar/database/crud/user/viewpropertyoperation.dart';
import 'package:deepaprakasar/database/crud/user/viewstate.dart';
import 'package:deepaprakasar/database/dao/district.dart';
import 'package:deepaprakasar/database/dao/propertyoperation.dart';
import 'package:deepaprakasar/database/dao/states.dart';
import 'package:deepaprakasar/resources/texts/strings.dart';
import 'package:deepaprakasar/ui/views/vatikalayam/vatikalayambuydetails.dart';
import 'package:deepaprakasar/ui/widgets/showalertdialog.dart';
import 'package:deepaprakasar/ui/widgets/styles.dart';
import 'package:deepaprakasar/ui/widgets/textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VatikalayamBuy extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => VatikalayamBuyState();
}

class VatikalayamBuyState extends State<VatikalayamBuy> {

  States? selectedState;
  District? selectedDistrict;
  PropertyOperation? selectedPropertyOperation;

  List<States> states = [];
  List<District> districts = [];
  List<PropertyOperation> propertyOperations = [];

  @override
  void initState() {
    super.initState();
    // On Page Load Get all the states from the server
    cleanSlate();

    viewPropertyOperation(Strings.BUY).then((List<PropertyOperation> value) {
      setState(() {
        propertyOperations = value;
      });
    });

    viewState().then((List<States> value) {
      setState(() {
        states = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget roundedRectButton(String title, List<Color> gradient) {
      return Builder(builder: (BuildContext mContext) {
        return InkWell(
          onTap: () {
            if (selectedPropertyOperation!.operation.isNotEmpty &&
                selectedState!.states.isNotEmpty &&
                selectedDistrict!.district.isNotEmpty) {
              setState(() {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VatikalayamBuyDetails(district: selectedDistrict!.district,
                        state: selectedState!.states, propertyOperation: selectedPropertyOperation!.operation)));
              });
            } else {
              return showAlertDialogSingle(context, Strings.ALERT_HDR_DATA_INPUT_MISSING,
                  Strings.ALERT_HDR_DATA_INPUT_MISSING);
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
          Strings.TITLE_VAT_VIEW,
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
                        viewPropertyField,
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
                        roundedRectButton(
                          Strings.BTN_TITLE_VIEW_PROPERTIES,
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
    });
  }

  void onPropertyOperationChanged(propertyOperation) {
    setState(() {
      selectedPropertyOperation = propertyOperation;
    });
  }

  void cleanSlate() {
    propertyOperationList.clear();
    stateList.clear();
    districtList.clear();
    selectedPropertyOperation = null;
    propertyOperations = [];
    selectedState = null;
    states = [];
    selectedDistrict = null;
    districts = [];
    clearInput();
  }
}
