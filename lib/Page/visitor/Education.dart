

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ghiras/widgets/extensions.dart';

import '../../Model/EducationModel.dart';
import '../../enum/HomeUser.dart';
import '../../widgets/AppDetails.dart';
import '../../widgets/assets.dart';
import '../../widgets/commonColor.dart';
import '../../widgets/commonWidget.dart';

class Education extends StatefulWidget {
  const Education({super.key});

  @override
  State<Education> createState() => _EducationState();
}

class _EducationState extends State<Education> {

  String join = "";
  String join_Hibe = "";

  List<EducationTap> educationWHIB = [];
  List<EducationModel> education = [
    EducationModel(
        id: '0',
        Title: 'تصميم المناظر الطبيعية',
        logo: Assets.shared.Rectangle1),
    EducationModel(
        id: '1', Title: 'امراض النباتات', logo: Assets.shared.diseases),
    EducationModel(
        id: '2', Title: 'كميات الري المناسبة', logo: Assets.shared.Rectangle3),
    EducationModel(
        id: '3', Title: 'ضبط الحساسات', logo: Assets.shared.Rectangle4),
    EducationModel(
        id: '4', Title: 'ادوات البستنه', logo: Assets.shared.Rectangle6),
    EducationModel(
        id: '5', Title: 'انواع النباتات', logo: Assets.shared.Rectangle5),
  ];
  List<EducationTap> educationTap = [
    EducationTap(
        id: '0',
        uid: '0',
        Title: 'تصميم المناظر الطبيعية للحدائق',
        logo: Assets.shared.Rectangle01),
    EducationTap(
        id: '1',
        uid: '0',
        Title: 'تصميم المخططات للمناظر الطبيعة',
        logo: Assets.shared.Rectangle02),
    EducationTap(
        id: '2',
        uid: '0',
        Title: 'تصميم الحدائق الداخلية',
        logo: Assets.shared.Rectangle03),
    EducationTap(
        id: '3',
        uid: '0',
        Title: 'تصميم المناظر الطبيعية للمنتزهات',
        logo: Assets.shared.Rectangle04),
  ];
  List<EducationDrs> educationHo = [
    EducationDrs(
        id: '0',
        uid: '1',
        Title:
        'تتضمن هندسة المناظر الطبيعية تخطيط وتصميم وإدارة ورعاية البيئات المبنية والطبيعية. بفضل مجموعة مهاراتهم الفريدة، يعمل مهندسو المناظر الطبيعية على تحسين صحة الإنسان والبيئة في جميع المجتمعات. إنهم يخططون ويصممون الحدائق والحرم الجامعية ومناظر الشوارع والممرات والساحات والمساكن وغيرها من المشاريع التي تعزز المجتمعات.',
        logo: [Assets.shared.eng, Assets.shared.john]),
  ];
  UserHome page = UserHome.Educationback;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Container(
              width: 288,
              height: 52,
              decoration: BoxDecoration(boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(
                    0.0,
                    3.0,
                  ),
                  blurRadius: 0.10,
                  spreadRadius: 0.10,
                ),
              ], color: Colors.white, borderRadius: BorderRadius.circular(30)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Image.asset(Assets.shared.start3)
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                      child: Image.asset(Assets.shared.start2)
                  ),
                  InkWell(
                      onTap: () => Navigator.pushNamed(context, '/weather'),
                      child: Image.asset(Assets.shared.start1)
                  ),
                  InkWell(
                      onTap: () => Navigator.pushNamed(context, '/Bot'),
                      child: Image.asset(Assets.shared.start4)
                  ),
                ],
              )
          ),
        ),
        backgroundColor: Colors.white,
        body:pageStart(context)
    );
  }

  pageStart(context) {
    if (page == UserHome.Educationback) {
      return Education(context);
    } else if (page == UserHome.educationInkWell) {
      return EducationInkWell(context);
    } else if (page == UserHome.educationInkDrs) {
      return educationInkDrs(context);
    }
  }

  Widget Education(BuildContext context) {
    return Center(
      child: Container(
          constraints: const BoxConstraints(
            maxWidth: 500,
          ),
          child: Stack(
            children: [
              Image.asset(
                fit: BoxFit.cover,
                Assets.shared.Educationback,
                width: MediaQuery.of(context).size.width,
              ),
              Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.only(top: 60),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    textWidget(
                      text: "موضوعات عن النباتات",
                      color: CommonColor.checkedDarkColor,
                      fontFamily: AppDetails.cairoRegular,
                      fontSize: 27,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Expanded(
                        child: GridView.count(
                          crossAxisCount: 2,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                          children: List.generate(education.length, (index) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  join = education[index].id;
                                  join_Hibe = education[index].Title;
                                  page = UserHome.educationInkWell;
                                });
                              },
                              child: Stack(
                                alignment: AlignmentDirectional.center,
                                children: [
                                  Image.asset(
                                    education[index].logo,
                                  ),
                                  Container(
                                      margin: const EdgeInsets.only(top: 70),
                                      width: 156,
                                      height: 34,
                                      color: CommonColor.whiteColor,
                                      child: Center(
                                        child: textWidget(
                                          text: education[index].Title,
                                          color: CommonColor.checkedDarkColor,
                                          fontFamily: AppDetails.cairoRegular,
                                          fontSize: 15,
                                        ),
                                      )),
                                ],
                              ),
                            );
                          }),
                        ))
                  ],
                ),
              ),
            ],
          )),
    );
  }

  Widget EducationInkWell(BuildContext context) {
    List<EducationTap> educationWHIB = [];
    for (var hebi in educationTap) {
      if (hebi.uid == join) {
        educationWHIB.add(hebi);
      }
    }
    return Center(
      child: Container(
          constraints: const BoxConstraints(
            maxWidth: 500,
          ),
          child: Stack(
            children: [
              Image.asset(
                fit: BoxFit.cover,
                Assets.shared.Educationback,
                width: MediaQuery.of(context).size.width,
              ),
              Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.only(top: 60),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.topCenter,
                      children: [
                        textWidget(
                          text: join_Hibe,
                          color: CommonColor.checkedDarkColor,
                          fontFamily: AppDetails.cairoRegular,
                          fontSize: 27,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: InkWell(
                                onTap: () {
                                  setState(() {
                                    page = UserHome.Educationback;
                                  });
                                },
                                child: Icon(
                                  CupertinoIcons.right_chevron,
                                  color: CommonColor.calendarColor,
                                )),
                          ),
                        )
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.only(top: 30),
                        shrinkWrap: true,
                        itemCount: educationWHIB.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                join = educationWHIB[index].id;
                                join_Hibe = educationWHIB[index].Title;
                                page = UserHome.educationInkDrs;
                              });
                            },
                            child: Card(
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Container(
                                width: 344,
                                height: 122,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: "#D9D9D9".toHexa(),
                                      offset: const Offset(
                                        0.0,
                                        2.0,
                                      ),
                                      blurRadius: 0.10,
                                      spreadRadius: 0.10,
                                    ),
                                  ],
                                  color: "#ffffff".toHexa(),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(30)),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            educationWHIB[index].Title,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20),
                                          )
                                        ],
                                      ),
                                    ),
                                    Image.asset(educationWHIB[index].logo),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }

  Widget educationInkDrs(BuildContext context) {
    List<EducationDrs> educationHebi = [];
    for (var hebi in educationHo) {
      if (hebi.uid == join) {
        educationHebi.add(hebi);
      }
    }
    return SingleChildScrollView(
      child: Center(
        child: Container(
            constraints: const BoxConstraints(
              maxWidth: 500,
            ),
            child: Stack(
              children: [
                Image.asset(
                  fit: BoxFit.cover,
                  Assets.shared.Hebi,
                  width: MediaQuery.of(context).size.width,
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.only(top: 130),
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.topCenter,
                        children: [
                          textWidget(
                            text: join_Hibe,
                            color: CommonColor.checkedDarkColor,
                            fontFamily: AppDetails.cairoRegular,
                            fontSize: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      page = UserHome.Educationback;
                                    });
                                  },
                                  child: Icon(
                                    CupertinoIcons.right_chevron,
                                    color: CommonColor.calendarColor,
                                  )),
                            ),
                          )
                        ],
                      ),
                      ListView.builder(
                        padding: const EdgeInsets.only(top: 30),
                        shrinkWrap: true,
                        itemCount: educationHebi.length,
                        itemBuilder: (context, index) {
                          return Row(
                            children: <Widget>[
                              Flexible(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      educationHebi[index].Title,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: CommonColor.fillColor,
                                          fontSize: 20),
                                    ),
                                    SizedBox(height: 10,),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          educationHebi[index].logo.first,
                                        ),
                                        SizedBox(width: 10,),
                                        Image.asset(
                                          educationHebi[index].logo.last,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
