import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ghiras/widgets/extensions.dart';

import '../../widgets/AppDetails.dart';
import '../../widgets/assets.dart';
import '../../widgets/commonColor.dart';
import '../../widgets/commonWidget.dart';

class start extends StatefulWidget {
  const start({super.key});

  @override
  State<start> createState() => _startState();
}

class _startState extends State<start> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: Container(
                padding: const EdgeInsets.all(30),
                constraints: const BoxConstraints(
                  maxWidth: 500,
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      textWidget(
                        text: "اهلا بك",
                        color: CommonColor.calendarColor,
                        fontFamily: AppDetails.cairoRegular,
                        fontSize: 30,
                      ),
                      textWidget(
                        text: " في تطبيق غراس",
                        color: CommonColor.calendarColor,
                        fontFamily: AppDetails.cairoRegular,
                        fontSize: 20,
                      ),
                      Stack(
                          alignment: AlignmentDirectional.topCenter,
                        children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: InkWell(
                              onTap: () => Navigator.pushNamed(context, '/weather'),
                              child: Container(
                                  width: 203,
                                  height: 67,
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: "#D9D9D9".toHexa(),
                                          offset: const Offset(
                                            0.0,
                                            4.0,
                                          ),
                                          blurRadius: 0.10,
                                          spreadRadius: 0.10,
                                        ),
                                      ],
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20)),
                                      color: Colors.white,
                                      border: Border.all(
                                        color: "#c7d5aa".toHexa(),
                                      )),
                                  child: Center(
                                    child: Text(
                                      'حالة الطقس',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: "#427D24".toHexa()),
                                    ),
                                  )
                              ),),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Image.asset(
                            Assets.shared.cloudy,
                            height: 40,
                            width: 40,
                          ),
                        ),
                      ],
                      ),
                      const SizedBox(height: 10,),
                      Stack(
                        alignment: AlignmentDirectional.topCenter,
                        children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              onTap: () => Navigator.pushNamed(context, '/Education'),
                              child: Container(
                                  width: 203,
                                  height: 67,
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: "#D9D9D9".toHexa(),
                                          offset: const Offset(
                                            0.0,
                                            4.0,
                                          ),
                                          blurRadius: 0.10,
                                          spreadRadius: 0.10,
                                        ),
                                      ],
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20)),
                                      color: Colors.white,
                                      border: Border.all(
                                        color: "#c7d5aa".toHexa(),
                                      )),
                                  child: Center(
                                    child: Text(
                                      'المحتوى التعليمي',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: "#427D24".toHexa()),
                                    ),
                                  )
                              ),),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(right: 35),
                            child: Image.asset(
                              Assets.shared.content,
                              height: 40,
                              width: 40,
                            ),
                          ),
                      ],
                      ),
                      const SizedBox(height: 10,),
                      Stack(
                        alignment: AlignmentDirectional.topCenter,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: InkWell(
                                onTap: () => Navigator.pushNamed(context, '/Bot'),
                                child: Container(
                                    width: 203,
                                    height: 67,
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: "#D9D9D9".toHexa(),
                                            offset: const Offset(
                                              0.0,
                                              4.0,
                                            ),
                                            blurRadius: 0.10,
                                            spreadRadius: 0.10,
                                          ),
                                        ],
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(20)),
                                        color: Colors.white,
                                        border: Border.all(
                                          color: "#c7d5aa".toHexa(),
                                        )),
                                    child: Center(
                                      child: Text(
                                        'ChatBot',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: "#427D24".toHexa()),
                                      ),
                                    )
                                ),),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: Image.asset(
                              Assets.shared.chatbot,
                              height: 40,
                              width: 40,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 128,
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: "#D9D9D9".toHexa(),
                                    offset: const Offset(
                                      0.0,
                                      4.0,
                                    ),
                                    blurRadius: 0.10,
                                    spreadRadius: 0.10,
                                  ),
                                ],
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(20)),
                                color: Colors.white,
                                border: Border.all(
                                  color: "#5E875A".toHexa(),
                                )),
                            child: InkWell(
                              onTap: () => Navigator.pushNamed(context, '/RegisterPage'),
                              child: Text(
                                'التسجيل',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 15,
                                    color: "#5E875A".toHexa()),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20,),
                          Container(
                            width: 128,
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: "#D9D9D9".toHexa(),
                                    offset: const Offset(
                                      0.0,
                                      4.0,
                                    ),
                                    blurRadius: 0.10,
                                    spreadRadius: 0.10,
                                  ),
                                ],
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(20)),
                                color: Colors.white,
                                border: Border.all(
                                  color: "#5E875A".toHexa(),
                                )),
                            child: InkWell(
                              onTap: () => Navigator.pushNamed(context, '/LoginPage'),
                              child: Text(
                                'تسجيل الدخول',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 15,
                                    color: "#5E875A".toHexa()),
                              ),
                            ),
                          ),

                        ],
                      )
                    ]))),
        bottomNavigationBar: Image.asset(
          Assets.shared.splash,
          height: 200,
          width: 278,
        ));
  }
}
