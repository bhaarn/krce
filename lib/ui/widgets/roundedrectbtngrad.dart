import 'package:deepaprakasar/resources/texts/strings.dart';
import 'package:deepaprakasar/ui/views/authentication/loginscreen.dart';
import 'package:deepaprakasar/ui/views/authentication/signupscreen.dart';
import 'package:flutter/material.dart';

Widget roundedRectButton(String title, List<Color> gradient) {
  return Builder(builder: (BuildContext mContext) {
    return InkWell(
      onTap: () {
        switch (title) {
          case Strings.BTN_TITLE_LOGIN:
            Navigator.push(mContext,
                MaterialPageRoute(builder: (context) => LoginScreen()));
            break;
          case Strings.BTN_TITLE_REGISTER_NOW:
            Navigator.push(mContext,
                MaterialPageRoute(builder: (context) => SignUpScreen()));
            break;
        }
      },
      splashColor: Colors.lightBlue,
      child: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(mContext).size.height * 0.05,
        width: MediaQuery.of(mContext).size.width / 3,
        decoration: ShapeDecoration(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
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

Widget elevatedButton(BuildContext context) {
  return Container(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                Color.fromRGBO(58, 66, 86, 1.0)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32.0),
            ))),
        onPressed: () => {},
        child: Text("TAKE THIS LESSON", style: TextStyle(color: Colors.white)),
      ));
}
