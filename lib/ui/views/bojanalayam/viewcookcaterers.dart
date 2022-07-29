import 'package:deepaprakasar/database/crud/user/viewfoodproducts.dart';
import 'package:deepaprakasar/database/dao/foodproducts.dart';
import 'package:flutter/material.dart';

class ViewBookCaterers extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ViewBookCaterersState();
}

class ViewBookCaterersState extends State<ViewBookCaterers> {
  List<FoodProducts> foodProducts = [];

  @override
  void initState() {
    cleanSlate();
    viewFoodProducts().then((List<FoodProducts> value) {
      setState(() {
        foodProducts = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }

  void cleanSlate() {
    foodProducts = [];
  }
}
