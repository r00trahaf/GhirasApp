import 'package:flutter/material.dart';
import 'package:ghiras/widgets/extensions.dart';

showAlertDialog(BuildContext context, { String title = "", String message = "" , String titleBtnOne = "نعم", String titleBtnTwo = "اغلاق",  actionBtnOne,  actionBtnTwo, bool showBtnOne = true, bool showBtnTwo = true}) {

  Widget btnOne = TextButton(
    onPressed: actionBtnOne,
    child: Text(titleBtnOne,style: TextStyle(color: "#688665".toHexa())),
  );

  Widget btnTwo = TextButton(
    onPressed: actionBtnTwo,
    child: Text(titleBtnTwo,style: TextStyle(color: "#688665".toHexa())),
  );

  AlertDialog alert = AlertDialog(
    title: Text(title, style: TextStyle(color: "#688665".toHexa(),),),
    content: Text(message,style: TextStyle(color: "#688665".toHexa(),),),
    actions: [
      Visibility(visible: showBtnOne, child: btnOne),
      Visibility(visible: showBtnTwo, child: btnTwo),
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}