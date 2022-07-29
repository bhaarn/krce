import 'package:deepaprakasar/database/crud/user/registerbojdet.dart';
import 'package:deepaprakasar/database/crud/user/viewfoodproducts.dart';
import 'package:deepaprakasar/database/dao/foodproducts.dart';
import 'package:deepaprakasar/database/dao/status.dart';
import 'package:deepaprakasar/resources/texts/strings.dart';
import 'package:deepaprakasar/ui/widgets/showalertdialog.dart';
import 'package:deepaprakasar/ui/widgets/styles.dart';
import 'package:deepaprakasar/ui/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BuyFoodProducts extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BuyFoodProductsState();
}

class BuyFoodProductsState extends State<BuyFoodProducts> {
  var isVisible = false;
  FoodProducts? selectedFoodProducts;
  List<FoodProducts> foodProducts = [];
  String uniqueId = Strings.EMPTY_STRING;

  Future<Status>? _futureStatus;
  int basic250Price = 0;
  int basic500Price = 0;
  int basic1000Price = 0;
  double quarterFinalPrice = 0;
  double halfFinalPrice = 0;
  double oneFinalPrice = 0;

  String product1Name = Strings.EMPTY_STRING;
  String product2Name = Strings.EMPTY_STRING;
  String product3Name = Strings.EMPTY_STRING;
  String product1250QuantityPrice = Strings.EMPTY_STRING;
  String product1500QuantityPrice = Strings.EMPTY_STRING;
  String product11000QuantityPrice = Strings.EMPTY_STRING;
  String product2250QuantityPrice = Strings.EMPTY_STRING;
  String product2500QuantityPrice = Strings.EMPTY_STRING;
  String product21000QuantityPrice = Strings.EMPTY_STRING;
  String product3250QuantityPrice = Strings.EMPTY_STRING;
  String product3500QuantityPrice = Strings.EMPTY_STRING;
  String product31000QuantityPrice = Strings.EMPTY_STRING;

  @override
  void initState() {
    cleanSlate();
    _remove();
    viewFoodProducts().then((List<FoodProducts> value) {
      setState(() {
        foodProducts = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final quarterKGInputField = TextField(
      controller: quarterKGInputFieldController,
      onChanged: onQuarterKGInputFieldChanged,
      obscureText: false,
      keyboardType: TextInputType.number,
      maxLength: 2,
      style: style,
      decoration: inputDecoration(Strings.DB_QUANTITY),
    );

    final halfKGInputField = TextField(
      controller: halfKGInputFieldController,
      onChanged: onHalfKGInputFieldChanged,
      obscureText: false,
      keyboardType: TextInputType.number,
      maxLength: 2,
      style: style,
      decoration: inputDecoration(Strings.DB_QUANTITY),
    );

    final oneKGInputField = TextField(
      controller: oneKGInputFieldController,
      onChanged: onOneKGInputFieldChanged,
      obscureText: false,
      keyboardType: TextInputType.number,
      maxLength: 2,
      style: style,
      decoration: inputDecoration(Strings.DB_QUANTITY),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          Strings.TITLE_BOJ_BUY_FOOD_PRDS,
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
                        buyFoodProductsField,
                        sizedBoxHeight,
                        DropdownButtonFormField<FoodProducts>(
                          decoration: inputDecoration(
                              Strings.DD_HINT_SEL_REQ_PRD),
                          value: selectedFoodProducts,
                          isExpanded: true,
                          items: foodProducts.map((FoodProducts foodProducts) {
                            return DropdownMenuItem<FoodProducts>(
                              value: foodProducts,
                              child: Text(foodProducts.productName),
                            );
                          }).toList(),
                          onChanged: onFoodProductsChanged,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(Strings.HINT_1KG_PRICE + basic1000Price.toString()),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: 110,
                              child: Center(
                                child: quarterKGField,
                              ),
                            ),
                            Container(
                              width: 110,
                              child: Center(
                                child: quarterKGInputField,
                              ),
                            ),
                            Container(
                              width: 110,
                              child: Center(
                                child: Text(quarterFinalPrice.toString()),
                              ),
                            ),
                          ],
                        ),
                        sizedBoxHeight,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: 110,
                              child: Center(
                                child: halfKGField,
                              ),
                            ),
                            Container(
                              width: 110,
                              child: Center(
                                child: halfKGInputField,
                              ),
                            ),
                            Container(
                              width: 110,
                              child: Center(
                                child: Text(halfFinalPrice.toString()),
                              ),
                            ),
                          ],
                        ),
                        sizedBoxHeight,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: 110,
                              child: Center(
                                child: oneKGField,
                              ),
                            ),
                            Container(
                              width: 110,
                              child: Center(
                                child: oneKGInputField,
                              ),
                            ),
                            Container(
                              width: 110,
                              child: Center(
                                child: Text(oneFinalPrice.toString()),
                              ),
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
                                child: Text(Strings.BTN_TITLE_SAVE_ADD_NEW_ITEM),
                                onPressed: () {
                                  setState(() {
                                    if (quarterKGInputFieldController.text !=
                                        Strings.EMPTY_STRING) {
                                      quarterFinalPrice = (double.parse(
                                              quarterKGInputFieldController
                                                  .text) *
                                          (basic1000Price.toDouble()) /
                                          4);
                                      registerBojDetDB(
                                          selectedFoodProducts!.productName,
                                          Strings.DATA_250_GM,
                                          quarterKGInputFieldController.text,
                                          quarterFinalPrice.toString(),
                                          uniqueId);
                                    }
                                    if (halfKGInputFieldController.text != Strings.EMPTY_STRING) {
                                      halfFinalPrice = (double.parse(
                                              halfKGInputFieldController.text) *
                                          (basic1000Price.toDouble()) /
                                          2);
                                      registerBojDetDB(
                                          selectedFoodProducts!.productName,
                                          Strings.DATA_500_GM,
                                          halfKGInputFieldController.text,
                                          halfFinalPrice.toString(),
                                          uniqueId);
                                    }
                                    if (oneKGInputFieldController.text != Strings.EMPTY_STRING) {
                                      oneFinalPrice = (double.parse(
                                              oneKGInputFieldController.text) *
                                          (basic1000Price.toDouble()) /
                                          1);
                                      registerBojDetDB(
                                          selectedFoodProducts!.productName,
                                          Strings.DATA_1_KG,
                                          oneKGInputFieldController.text,
                                          oneFinalPrice.toString(),
                                          uniqueId);
                                    }
                                    quarterKGInputFieldController.text = Strings.EMPTY_STRING;
                                    halfKGInputFieldController.text = Strings.EMPTY_STRING;
                                    oneKGInputFieldController.text = Strings.EMPTY_STRING;

                                    quarterFinalPrice = (double.parse(
                                            quarterKGInputFieldController
                                                .text) *
                                        (basic1000Price.toDouble()) /
                                        4);
                                    halfFinalPrice = (double.parse(
                                            halfKGInputFieldController.text) *
                                        (basic1000Price.toDouble()) /
                                        2);
                                    oneFinalPrice = (double.parse(
                                            oneKGInputFieldController.text) *
                                        (basic1000Price.toDouble()) /
                                        1);

                                    _save(
                                        selectedFoodProducts!.productName,
                                        quarterKGInputFieldController.text,
                                        quarterFinalPrice,
                                        halfKGInputFieldController.text,
                                        halfFinalPrice,
                                        oneKGInputFieldController.text,
                                        oneFinalPrice);

                                    isVisible = false;
                                  });
                                },
                              ),
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
                                              return showAlertDialogSingle(
                                                  context,
                                                  Strings.ALERT_HDR_SYSTEM_ERROR,
                                                  Strings.ALERT_BDY_SYSTEM_ERROR);
                                            });
                                          } else if (snapshot.data!.status
                                              .startsWith(Strings.UID_HDR_BOJ)) {
                                            uniqueId = snapshot.data!.status;
                                          }
                                        } else if (snapshot.hasError) {
                                          return Text("${snapshot.error}");
                                        }
                                        return CircularProgressIndicator(
                                                value: 0.0);
                                      },
                                    )
                                  : Text(Strings.EMPTY_STRING),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 2,
                              height: 50,
                              child: ElevatedButton(
                                style: elevatedButtonStyle,
                                child: Text(Strings.BTN_TITLE_REVIEW_ORDER),
                                onPressed: () {
                                  setState(() {
                                    _show();
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        Visibility(
                          visible: isVisible,
                          child: Column(
                            children: [
                              sizedBoxHeight,
                              product1NameField,
                              sizedBoxHeight,
                              product1250QuantityPriceField,
                              sizedBoxHeight,
                              product1500QuantityPriceField,
                              sizedBoxHeight,
                              product11000QuantityPriceField,
                              sizedBoxHeight,
                              product2NameField,
                              sizedBoxHeight,
                              product2250QuantityPriceField,
                              sizedBoxHeight,
                              product2500QuantityPriceField,
                              sizedBoxHeight,
                              product21000QuantityPriceField,
                              sizedBoxHeight,
                              product3NameField,
                              sizedBoxHeight,
                              product3250QuantityPriceField,
                              sizedBoxHeight,
                              product3500QuantityPriceField,
                              sizedBoxHeight,
                              product31000QuantityPriceField,
                              sizedBoxHeight,
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  registerBojDetDB(String productName, String productType, String quantity,
      String price, String uniqueId) {
    _futureStatus =
        registerBojDet(productName, productType, quantity, price, uniqueId);
  }

  _save(String productId, String quarterQty, double quarterPrice,
      String halfQty, double halfPrice, String oneQty, double onePrice) async {
    List<String> productData = [
      productId,
      quarterQty,
      quarterPrice.toString(),
      halfQty,
      halfPrice.toString(),
      oneQty,
      onePrice.toString()
    ];
    List<String> productDataStrings =
        productData.map((i) => i.toString()).toList();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> productList = (prefs.getStringList(Strings.SHARED_PREF_PRD_LIST) ?? []);
    productList.addAll(productDataStrings);
    // List<double> productOriginalList = productList.map((i)=> double.parse(i)).toList();
    List<String> productOriginalList = productList.toList();
    print('Product list  $productOriginalList');
    await prefs.setStringList(Strings.SHARED_PREF_PRD_LIST, productList);
  }

  _show() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? st = prefs.getStringList(Strings.SHARED_PREF_PRD_LIST);

    product1Name = Strings.DATA_PRD_NAME + st![0] + Strings.LINE_BREAK;
    if (st[1] != Strings.DATA_EMPTY_PRICE) {
      product1250QuantityPrice =
          Strings.DATA_250_QTY_PRICE + st[1] + Strings.DATA_ITEM_RS + st[2];
    } else {
      product1250QuantityPrice = Strings.EMPTY_STRING;
    }
    if (st[3] != Strings.DATA_EMPTY_PRICE) {
      product1500QuantityPrice =
          Strings.DATA_500_QTY_PRICE + st[3] + Strings.DATA_ITEM_RS + st[4];
    } else {
      product1500QuantityPrice = Strings.EMPTY_STRING;
    }
    if (st[5] != Strings.DATA_EMPTY_PRICE) {
      product11000QuantityPrice =
          Strings.DATA_1000_QTY_PRICE + st[5] + Strings.DATA_ITEM_RS + st[6];
    } else {
      product11000QuantityPrice = Strings.EMPTY_STRING;
    }

    product1NameFieldController.text = product1Name;
    product1250QuantityPriceFieldController.text = product1250QuantityPrice;
    product1500QuantityPriceFieldController.text = product1500QuantityPrice;
    product11000QuantityPriceFieldController.text = product11000QuantityPrice;

    product2Name = Strings.DATA_PRD_NAME + st[7] + Strings.LINE_BREAK;
    if (st[8] != Strings.DATA_EMPTY_PRICE) {
      product2250QuantityPrice =
          Strings.DATA_250_QTY_PRICE + st[8] + Strings.DATA_ITEM_RS + st[9];
    } else {
      product2250QuantityPrice = Strings.EMPTY_STRING;
    }
    if (st[10] != Strings.DATA_EMPTY_PRICE) {
      product2500QuantityPrice =
          Strings.DATA_500_QTY_PRICE + st[10] + Strings.DATA_ITEM_RS + st[11];
    } else {
      product2500QuantityPrice = Strings.EMPTY_STRING;
    }
    if (st[12] != Strings.DATA_EMPTY_PRICE) {
      product21000QuantityPrice =
          Strings.DATA_1000_QTY_PRICE + st[12] + Strings.DATA_ITEM_RS + st[13];
    } else {
      product21000QuantityPrice = Strings.EMPTY_STRING;
    }

    product2NameFieldController.text = product2Name;
    product2250QuantityPriceFieldController.text = product2250QuantityPrice;
    product2500QuantityPriceFieldController.text = product2500QuantityPrice;
    product21000QuantityPriceFieldController.text = product21000QuantityPrice;

    product3Name = Strings.DATA_PRD_NAME + st[14] + Strings.LINE_BREAK;
    if (st[15] != Strings.DATA_EMPTY_PRICE) {
      product3250QuantityPrice =
          Strings.DATA_250_QTY_PRICE + st[15] + Strings.DATA_ITEM_RS + st[16];
    } else {
      product3250QuantityPrice = Strings.EMPTY_STRING;
    }
    if (st[17] != Strings.DATA_EMPTY_PRICE) {
      product3500QuantityPrice =
          Strings.DATA_500_QTY_PRICE + st[17] + Strings.DATA_ITEM_RS + st[18];
    } else {
      product3500QuantityPrice = Strings.EMPTY_STRING;
    }
    if (st[19] != Strings.DATA_EMPTY_PRICE) {
      product31000QuantityPrice =
          Strings.DATA_1000_QTY_PRICE + st[19] + Strings.DATA_ITEM_RS + st[20];
    } else {
      product31000QuantityPrice = Strings.EMPTY_STRING;
    }

    product3NameFieldController.text = product3Name;
    product3250QuantityPriceFieldController.text = product3250QuantityPrice;
    product3500QuantityPriceFieldController.text = product3500QuantityPrice;
    product31000QuantityPriceFieldController.text = product31000QuantityPrice;

    isVisible = true;
  }

  _remove() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(Strings.SHARED_PREF_PRD_LIST);
  }

  void cleanSlate() {
    quarterFinalPrice = 0;
    halfFinalPrice = 0;
    oneFinalPrice = 0;
    foodProducts = [];
    selectedFoodProducts = null;
    quarterKGInputFieldController.clear();
    halfKGInputFieldController.clear();
    oneKGInputFieldController.clear();
  }

  void onFoodProductsChanged(foodProduct) {
    setState(() {
      quarterKGInputFieldController.clear();
      halfKGInputFieldController.clear();
      oneKGInputFieldController.clear();
      quarterFinalPrice = 0;
      halfFinalPrice = 0;
      oneFinalPrice = 0;
      selectedFoodProducts = foodProduct;
      basic1000Price = int.parse(selectedFoodProducts!.price);
      assert(basic1000Price is int);
    });
  }

  void onQuarterKGInputFieldChanged(updatedText) {
    setState(() {
      quarterFinalPrice =
          (double.parse(updatedText) * (basic1000Price.toDouble() / 4));
    });
  }

  void onHalfKGInputFieldChanged(updatedText) {
    setState(() {
      halfFinalPrice =
          (double.parse(updatedText) * (basic1000Price.toDouble() / 2));
    });
  }

  void onOneKGInputFieldChanged(updatedText) {
    setState(() {
      oneFinalPrice =
          (double.parse(updatedText) * (basic1000Price.toDouble() / 1));
    });
  }
}
