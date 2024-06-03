import 'package:flutter/material.dart';
import 'package:ghiras/Firebase.dart';
import 'package:ghiras/widgets/extensions.dart';

import '../Model/UserModel.dart';
import '../enum/Supporttype.dart';
import '../user_profile.dart';
import '../widgets/AppDetails.dart';
import '../widgets/assets.dart';
import '../widgets/commonColor.dart';
import '../widgets/commonWidget.dart';

class SupportPage extends StatefulWidget {
  const SupportPage({super.key});

  @override
  State<SupportPage> createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  void initState() {
    // TODO: implement initState
    super.initState();
    join();
  }

  bool Hebi = false;

  join() async {
    UserModel? hebi = await UserProfile.shared.getUser();
    if (hebi != null) {
      setState(() {
        Hebi = true;
      });
    } else {
      setState(() {
        Hebi = false;
      });
    }
  }

  String title = "";
  String subtitle = "";

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  SupportType Supporttype = SupportType.questions;

  bool validation() {
    return !(title == "" || subtitle == "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Center(
                child: Container(
                    constraints: const BoxConstraints(
                      maxWidth: 500,
                    ),
                    padding: const EdgeInsets.all(0),
                    width: double.infinity,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Stack(
                            alignment: AlignmentDirectional.bottomCenter,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 216,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                      scale: 1.0,
                                      opacity: 1.0,
                                      image: AssetImage(
                                        Assets.shared.support,
                                      ),
                                      fit: BoxFit.fitWidth,
                                    ),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(40)),
                              ),
                              Container(
                                width: 334,
                                height: 80,
                                decoration: BoxDecoration(
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(
                                          0.0,
                                          5.0,
                                        ),
                                        blurRadius: 0.10,
                                        spreadRadius: 0.10,
                                      ),
                                    ],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(35)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Stack(
                                      children: [
                                        //                                     Image.asset(
                                        //                                           Assets.shared.vector,
                                        //                                           height: 21.88,
                                        //                                           width: 25,
                                        //                                         ),
                                        Text(
                                          "مركز الدعم",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 25),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "كيف نقدر نخدمك ؟",
                                      style: TextStyle(
                                          color: "#CFE5A5".toHexa(),
                                          fontSize: 20),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Visibility(
                              visible: Hebi,
                              child: InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return StatefulBuilder(builder:
                                          (BuildContext context,
                                              void Function(void Function())
                                                  setState) {
                                        return AlertDialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                          ),
                                          title: Column(
                                            children: [
                                              Image.asset(
                                                Assets.shared.add1,
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              const Text(
                                                "اضافة  اسئلة مركز الدعم",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                          content: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                Container(
                                                  height: 44,
                                                  width: 190,
                                                  decoration: BoxDecoration(
                                                      boxShadow: const [
                                                        BoxShadow(
                                                          color: Colors.grey,
                                                          offset: Offset(
                                                            0.0,
                                                            1.0,
                                                          ),
                                                          blurRadius: 0.10,
                                                          spreadRadius: 0.10,
                                                        ),
                                                      ],
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      ChoiceChip(
                                                        backgroundColor:
                                                            Colors.white,
                                                        selectedColor: Colors
                                                                .lightBlueAccent[
                                                            100],
                                                        disabledColor:
                                                            "#E2ECC7".toHexa(),
                                                        showCheckmark: false,
                                                        label: const Text(
                                                          "الاسئلة الشائعة",
                                                        ),
                                                        labelStyle: TextStyle(
                                                          fontSize: 12,
                                                          color: "#365133"
                                                              .toHexa(),
                                                        ),
                                                        shape:
                                                            ContinuousRectangleBorder(
                                                          side:
                                                              const BorderSide(
                                                                  color: Colors
                                                                      .white,
                                                                  width: 1),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                        ),
                                                        selected: Supporttype ==
                                                            SupportType.account,
                                                        onSelected: (selected) {
                                                          print(selected);
                                                          setState(() {
                                                            Supporttype =
                                                                SupportType
                                                                    .account;
                                                          });
                                                        },
                                                      ),
                                                      ChoiceChip(
                                                        backgroundColor:
                                                            Colors.white,
                                                        selectedColor: Colors
                                                                .lightBlueAccent[
                                                            100],
                                                        disabledColor:
                                                            "#E2ECC7".toHexa(),
                                                        shape:
                                                            ContinuousRectangleBorder(
                                                          side:
                                                              const BorderSide(
                                                                  color: Colors
                                                                      .white,
                                                                  width: 1),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                        ),
                                                        showCheckmark: false,
                                                        label: const Text(
                                                            "الحساب"),
                                                        labelStyle: TextStyle(
                                                          fontSize: 12,
                                                          color: "#365133"
                                                              .toHexa(),
                                                        ),
                                                        selected: Supporttype ==
                                                            SupportType
                                                                .questions,
                                                        onSelected: (selected) {
                                                          print(selected);
                                                          setState(() {
                                                            Supporttype =
                                                                SupportType
                                                                    .questions;
                                                          });
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                TextFormField(
                                                  textAlign: TextAlign.center,
                                                  cursorColor: Colors.black,
                                                  keyboardType: TextInputType
                                                      .visiblePassword,
                                                  textInputAction:
                                                      TextInputAction.done,
                                                  onChanged: (value) =>
                                                      title = value.trim(),
                                                  decoration: InputDecoration(
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            "#28969A".toHexa(),
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25.0),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            "#28969A".toHexa(),
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25.0),
                                                    ),
                                                    border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            "#28969A".toHexa(),
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25.0),
                                                    ),
                                                    hintText: 'السؤال',
                                                    labelText: 'السؤال',
                                                    labelStyle: TextStyle(
                                                      color: "#28969A".toHexa(),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                TextFormField(
                                                  textAlign: TextAlign.center,
                                                  cursorColor: Colors.black,
                                                  keyboardType: TextInputType
                                                      .visiblePassword,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  onChanged: (value) =>
                                                      subtitle = value.trim(),
                                                  decoration: InputDecoration(
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            "#28969A".toHexa(),
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25.0),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            "#28969A".toHexa(),
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25.0),
                                                    ),
                                                    border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            "#28969A".toHexa(),
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25.0),
                                                    ),
                                                    hintText: 'الاجابة',
                                                    labelText: 'الاجابة',
                                                    labelStyle: TextStyle(
                                                        color:
                                                            "#28969A".toHexa()),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          actions: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    if (!validation()) {
                                                      scaffoldKey.showTosta(
                                                          context,
                                                          message:
                                                              'يرجى تعبئة جميع الحقول',
                                                          isError: true);
                                                      return;
                                                    }
                                                    Firebase.shared.support(
                                                        context,
                                                        scaffoldKey:
                                                            scaffoldKey,
                                                        type: Supporttype,
                                                        title: title,
                                                        subtitle: subtitle);
                                                  },
                                                  child: Container(
                                                    height: 22,
                                                    width: 64,
                                                    decoration: BoxDecoration(
                                                        boxShadow: const [
                                                          BoxShadow(
                                                            color: Colors.grey,
                                                            offset: Offset(
                                                              0.0,
                                                              2.0,
                                                            ),
                                                            blurRadius: 0.10,
                                                            spreadRadius: 0.10,
                                                          ),
                                                        ],
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                                Radius.circular(
                                                                    20)),
                                                        color: Colors.white,
                                                        border: Border.all(
                                                          color: "#28969A"
                                                              .toHexa(),
                                                        )),
                                                    child: Text(
                                                      'حفظ',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: "#28969A"
                                                              .toHexa()),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Container(
                                                    height: 22,
                                                    width: 64,
                                                    decoration: BoxDecoration(
                                                        boxShadow: const [
                                                          BoxShadow(
                                                            color: Colors.grey,
                                                            offset: Offset(
                                                              0.0,
                                                              2.0,
                                                            ),
                                                            blurRadius: 0.10,
                                                            spreadRadius: 0.10,
                                                          ),
                                                        ],
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                                Radius.circular(
                                                                    20)),
                                                        color: Colors.white,
                                                        border: Border.all(
                                                            color: "#28969A"
                                                                .toHexa())),
                                                    child: Text(
                                                      'الغاء',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: "#28969A"
                                                              .toHexa()),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        );
                                      });
                                    },
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      Assets.shared.add,
                                    ),
                                    const Text("اضافة")
                                  ],
                                ),
                              )),
                          const SizedBox(
                            height: 10,
                          ),
                          TextButton(
                              onPressed: () {
                                if (Hebi == true) {
                                  Navigator.of(context).pop();
                                } else {
                                  Navigator.pushNamed(context, '/LoginPage');
                                }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    Assets.shared.homeIcon,
                                  ),
                                  const SizedBox(width: 5,),
                                  textWidget(
                                    text: "الرئيسية",
                                    color: CommonColor.borderColor,
                                    fontFamily: AppDetails.cairoRegular,
                                    fontSize: 20,
                                  ),
                                ],
                              )),
                          const SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () =>
                                Navigator.pushNamed(context, '/questionsPage'),
                            child: Container(
                              width: 336,
                              height: 150,
                              decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.grey,
                                      offset: Offset(
                                        0.0,
                                        5.0,
                                      ),
                                      blurRadius: 0.10,
                                      spreadRadius: 0.10,
                                    ),
                                  ],
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    Assets.shared.question,
                                    height: 90,
                                    width: 90,
                                  ),
                                  const Text(
                                    "الاسئلة الشائعة ",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 23),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 80,
                          ),
                          InkWell(
                              onTap: () =>
                                  Navigator.pushNamed(context, '/accountPage'),
                              child: Container(
                                width: 336,
                                height: 150,
                                decoration: BoxDecoration(
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(
                                          0.0,
                                          5.0,
                                        ),
                                        blurRadius: 0.10,
                                        spreadRadius: 0.10,
                                      ),
                                    ],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      Assets.shared.account,
                                      height: 90,
                                      width: 90,
                                    ),
                                    const Text(
                                      "ارشادات الاستخدام",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 23),
                                    )
                                  ],
                                ),
                              )),
                        ])))));
  }
}
