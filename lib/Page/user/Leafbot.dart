

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ghiras/widgets/extensions.dart';

import '../../widgets/assets.dart';

class Leafbot extends StatefulWidget {
  const Leafbot({super.key});

  @override
  State<Leafbot> createState() => _LeafbotState();
}

class _LeafbotState extends State<Leafbot> {


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
   Start();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Start();
  }



  Start(){
     Future.delayed(const Duration(seconds: 1), () {
       showDialog(
         context: context,
         builder: (BuildContext context) {
           return WillPopScope(
               onWillPop: () async => false,
               child: AlertDialog(
                 shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(25),
                 ),
                 surfaceTintColor: Colors.white,
                 backgroundColor: Colors.white,
                 title: Image.asset(Assets.shared.chatbot1),
                 content: Text(
                   "اهلا! انا ليف صديقك الذكي\nحدثني عن نباتاتك الجميلة!",
                   textAlign: TextAlign.center,
                   style: TextStyle(
                     color: "#8f8f8f".toHexa(),
                   ),
                 ),
                 actions: [
                   Center(
                       child: CircularProgressIndicator(
                         color:"#1aceb9".toHexa(),
                         backgroundColor: Colors.white,
                       )),
                 ],
               ));
         },
       );
     });
     Future.delayed(const Duration(seconds: 3), () {
       Navigator.of(context).pop();
       Navigator.pushNamed(context, '/Bot');
     });
   }
  @override
  Widget build(BuildContext context) {
    return  Container();
  }
}
