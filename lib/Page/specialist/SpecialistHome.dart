import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ghiras/Firebase.dart';
import 'package:ghiras/widgets/extensions.dart';
import 'package:intl/intl.dart';
import '../../Model/ReportsModel.dart';
import '../../Model/ReviewsModel.dart';
import '../../Model/UserModel.dart';
import '../../enum/Usertype.dart';
import '../../enum/report.dart';
import '../../enum/status.dart';
import '../../widgets/AppDetails.dart';
import '../../widgets/assets.dart';
import '../../widgets/commonColor.dart';
import '../../widgets/commonWidget.dart';
import '../../widgets/sessionAlertDialogWidget.dart';
import '../HomePage.dart';

class SpecialistHome extends StatefulWidget {
  const SpecialistHome({super.key});

  @override
  State<SpecialistHome> createState() => _SpecialistHomeState();
}

class _SpecialistHomeState extends State<SpecialistHome> {
  bool Ratings = false;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  TextEditingController rejected = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Ratings == false
        ? SingleChildScrollView(
            child: Center(
            child: Container(
                constraints: const BoxConstraints(
                  maxWidth: 500,
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FutureBuilder<UserModel>(
                          future: Firebase.shared.userByUid(
                              uid: Firebase.shared.auth.currentUser!.uid),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              UserModel? user = snapshot.data;
                              return Stack(
                                children: [
                                  Image.asset(
                                    fit: BoxFit.cover,
                                    Assets.shared.SpeciaListHome,
                                    width: MediaQuery.of(context).size.width,
                                  ),
                                  Align(
                                      alignment: Alignment.center,
                                      child: Container(
                                        padding: const EdgeInsets.all(25),
                                        margin: const EdgeInsets.only(top: 120),
                                        width: 357,
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
                                            borderRadius:
                                                BorderRadius.circular(35)),
                                        child: Column(
                                          children: [
                                            const SizedBox(
                                              height: 30,
                                            ),
                                            Text(
                                              'اهلا،${user!.name}',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: "#365133".toHexa(),
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  width: 70.01,
                                                  child: Divider(
                                                    color: "#9DBA89".toHexa(),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                const Text("مواعيد اليوم"),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                SizedBox(
                                                  width: 70.01,
                                                  child: Divider(
                                                    color: "#9DBA89".toHexa(),
                                                  ),
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            FutureBuilder<List<ReportsModel>>(
                                                future: Firebase.shared.reports(
                                                    uid: Firebase.shared.auth
                                                        .currentUser!.uid),
                                                builder: (context, snapshot) {
                                                  if (snapshot.hasData) {
                                                    List<ReportsModel>? items =
                                                        [];
                                                    for (var add
                                                        in snapshot.data!) {
                                                      if (add.status ==
                                                          Status.active) {
                                                        if (DateFormat(
                                                                    'EEE, M/d/y')
                                                                .format(add
                                                                    .createdDate) ==
                                                            DateFormat(
                                                                    'EEE, M/d/y')
                                                                .format(DateTime
                                                                    .now())) {
                                                          items.add(add);
                                                        }
                                                      }
                                                    }
                                                    return ListView.builder(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10.0),
                                                      shrinkWrap: true,
                                                      itemCount: items.length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return Card(
                                                          elevation: 3,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                          ),
                                                          shadowColor:
                                                              CommonColor
                                                                  .blackColor,
                                                          child: Container(
                                                              width: 323,
                                                              height: 51,
                                                              decoration:
                                                                  BoxDecoration(
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color: "#D9D9D9"
                                                                        .toHexa(),
                                                                    offset:
                                                                        const Offset(
                                                                      0.0,
                                                                      5.0,
                                                                    ),
                                                                    blurRadius:
                                                                        0.10,
                                                                    spreadRadius:
                                                                        0.10,
                                                                  ),
                                                                ],
                                                                color: "#f3f3f3"
                                                                    .toHexa(),
                                                                borderRadius:
                                                                    const BorderRadius
                                                                        .all(
                                                                        Radius.circular(
                                                                            20)),
                                                              ),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            10),
                                                                    child: Image
                                                                        .asset(
                                                                      items[index].report !=
                                                                              Report
                                                                                  .online
                                                                          ? Assets
                                                                              .shared
                                                                              .tea
                                                                          : Assets
                                                                              .shared
                                                                              .interview,
                                                                    ),
                                                                  ),
                                                                  textWidget(
                                                                    text: DateFormat(
                                                                            'hh:mm a')
                                                                        .format(
                                                                            items[index].createdDate),
                                                                    fontFamily:
                                                                        AppDetails
                                                                            .cairoRegular,
                                                                    color: CommonColor
                                                                        .checkedDarkColor,
                                                                    fontSize:
                                                                        16,
                                                                  ),
                                                                  Stack(
                                                                    alignment:
                                                                        AlignmentDirectional
                                                                            .center,
                                                                    children: [
                                                                      Image
                                                                          .asset(
                                                                        Assets.shared.background_S,
                                                                      ),
                                                                      InkWell(
                                                                        onTap:
                                                                            () {
                                                                          showDialog(
                                                                            context:
                                                                                context,
                                                                            builder:
                                                                                (context) {
                                                                              return AlertDialog(
                                                                                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                                                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                                                                title: Stack(
                                                                                  alignment: Alignment.center,
                                                                                  children: [
                                                                                    const SizedBox(
                                                                                      height: 40,
                                                                                    ),
                                                                                    textWidget(
                                                                                      text: "معلومات الموعد",
                                                                                      fontSize: 22,
                                                                                      fontFamily: AppDetails.cairoRegular,
                                                                                    ),
//                                                                                    Positioned(bottom: 20, left: 65, child: Center(child: Image.asset(Assets.shared.vector))),
                                                                                  ],
                                                                                ),
                                                                                content: SingleChildScrollView(
                                                                                  child: Column(
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    mainAxisSize: MainAxisSize.min,
                                                                                    children: [
                                                                                      textWidget(
                                                                                        text: "اسم صاحب النباتات:",
                                                                                        fontSize: 18,
                                                                                        fontFamily: AppDetails.cairoRegular,
                                                                                        color: CommonColor.calendarColor,
                                                                                      ),
                                                                                      const SizedBox(
                                                                                        height: 5,
                                                                                      ),
                                                                                      textWidget(
                                                                                        text: items[index].nameUser,
                                                                                        fontSize: 16,
                                                                                        fontFamily: AppDetails.cairoRegular,
                                                                                        color: CommonColor.blackColor,
                                                                                      ),
                                                                                      const SizedBox(
                                                                                        height: 5,
                                                                                      ),
                                                                                      textWidget(
                                                                                        text: "رقم التواصل:",
                                                                                        fontSize: 18,
                                                                                        fontFamily: AppDetails.cairoRegular,
                                                                                        color: CommonColor.calendarColor,
                                                                                      ),
                                                                                      const SizedBox(
                                                                                        height: 5,
                                                                                      ),
                                                                                      textWidget(
                                                                                        text: items[index].phone,
                                                                                        fontSize: 16,
                                                                                        fontFamily: AppDetails.cairoRegular,
                                                                                        color: CommonColor.blackColor,
                                                                                      ),
                                                                                      const SizedBox(
                                                                                        height: 5,
                                                                                      ),
                                                                                      textWidget(
                                                                                        text: "العنوان:",
                                                                                        fontSize: 18,
                                                                                        fontFamily: AppDetails.cairoRegular,
                                                                                        color: CommonColor.calendarColor,
                                                                                      ),
                                                                                      const SizedBox(
                                                                                        height: 5,
                                                                                      ),
                                                                                      textWidget(
                                                                                        text: items[index].place,
                                                                                        fontSize: 16,
                                                                                        fontFamily: AppDetails.cairoRegular,
                                                                                        color: CommonColor.blackColor,
                                                                                      ),
                                                                                      const SizedBox(
                                                                                        height: 5,
                                                                                      ),
                                                                                      textWidget(
                                                                                        text: "زمن الجلسة:",
                                                                                        fontSize: 18,
                                                                                        fontFamily: AppDetails.cairoRegular,
                                                                                        color: CommonColor.calendarColor,
                                                                                      ),
                                                                                      const SizedBox(
                                                                                        height: 5,
                                                                                      ),
                                                                                      textWidget(
                                                                                        text: DateFormat('hh:mm a').format(items[index].createdDate),
                                                                                        fontSize: 16,
                                                                                        fontFamily: AppDetails.cairoRegular,
                                                                                        color: CommonColor.blackColor,
                                                                                      ),
                                                                                      const SizedBox(
                                                                                        height: 5,
                                                                                      ),
                                                                                      textWidget(
                                                                                        text: "نوع الجلسة:",
                                                                                        fontSize: 18,
                                                                                        fontFamily: AppDetails.cairoRegular,
                                                                                        color: CommonColor.calendarColor,
                                                                                      ),
                                                                                      const SizedBox(
                                                                                        height: 5,
                                                                                      ),
                                                                                      textWidget(
                                                                                        text: items[index].report == Report.online ? 'اون لاين' : 'زيارة ميدانية',
                                                                                        fontSize: 16,
                                                                                        fontFamily: AppDetails.cairoRegular,
                                                                                        color: CommonColor.blackColor,
                                                                                      ),
                                                                                      const SizedBox(
                                                                                        height: 20,
                                                                                      ),
                                                                                      Container(
                                                                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                                                                        margin: const EdgeInsets.symmetric(horizontal: 40),
                                                                                        decoration: BoxDecoration(
                                                                                          border: Border.all(color: "#365133".toHexa()),
                                                                                          borderRadius: BorderRadius.circular(30),
                                                                                          color: CommonColor.whiteColor,
                                                                                          boxShadow: [
                                                                                            BoxShadow(
                                                                                              color: Colors.grey.shade500,
                                                                                              blurRadius: 2.0,
                                                                                              spreadRadius: 0.0,
                                                                                              offset: const Offset(0, 3),
                                                                                            )
                                                                                          ],
                                                                                        ),
                                                                                        child: IntrinsicHeight(
                                                                                          child: Row(
                                                                                            children: [
                                                                                              InkWell(
                                                                                                onTap: () {
                                                                                                  Navigator.of(context).pop();
                                                                                                  showDialog(
                                                                                                    context: context,
                                                                                                    builder: (context) {
                                                                                                      return Center(
                                                                                                        child: AlertDialog(
                                                                                                          actionsPadding: const EdgeInsets.only(bottom: 20),
                                                                                                          shape: RoundedRectangleBorder(
                                                                                                            borderRadius: BorderRadius.circular(20),
                                                                                                          ),
                                                                                                          title: SizedBox(
                                                                                                            height: 80,
                                                                                                            width: 80,
                                                                                                            child: Image.asset(Assets.shared.cancel),
                                                                                                          ),
                                                                                                          contentPadding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
                                                                                                          content: Column(
                                                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                                                            mainAxisSize: MainAxisSize.min,
                                                                                                            children: [
                                                                                                              Padding(
                                                                                                                padding: const EdgeInsets.only(right: 20.0),
                                                                                                                child: textWidget(
                                                                                                                  text: "الرجاء كتابة سبب الغاء الجلسة",
                                                                                                                  color: CommonColor.titleColor,
                                                                                                                  fontFamily: AppDetails.cairoRegular,
                                                                                                                  fontSize: 24,
                                                                                                                ),
                                                                                                              ),
                                                                                                              const SizedBox(
                                                                                                                height: 20,
                                                                                                              ),
                                                                                                              Container(
                                                                                                                margin: const EdgeInsets.symmetric(horizontal: 20),
                                                                                                                decoration: BoxDecoration(
                                                                                                                  borderRadius: BorderRadius.circular(20),
                                                                                                                  // Border radius for the container
                                                                                                                  boxShadow: [
                                                                                                                    BoxShadow(
                                                                                                                      color: Colors.grey.shade500,
                                                                                                                      blurRadius: 2.0,
                                                                                                                      spreadRadius: 0.0,
                                                                                                                      offset: const Offset(0, 3), // shadow direction: bottom right
                                                                                                                    ),
                                                                                                                  ],
                                                                                                                ),
                                                                                                                child: TextFormField(
                                                                                                                  maxLines: 6,
                                                                                                                  textAlignVertical: TextAlignVertical.top,
                                                                                                                  textInputAction: TextInputAction.next,
                                                                                                                  validator: (value) {
                                                                                                                    return null;
                                                                                                                  },
                                                                                                                  controller: rejected,
                                                                                                                  style: TextStyle(
                                                                                                                    fontFamily: AppDetails.cairoMedium,
                                                                                                                    fontSize: 16.0,
                                                                                                                    fontWeight: FontWeight.w400,
                                                                                                                    color: CommonColor.blackColor,
                                                                                                                  ),
                                                                                                                  keyboardType: TextInputType.text,
                                                                                                                  decoration: InputDecoration(
                                                                                                                    filled: true,
                                                                                                                    fillColor: CommonColor.whiteColor,
                                                                                                                    contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                                                                                                    floatingLabelBehavior: FloatingLabelBehavior.always,
                                                                                                                    labelStyle: TextStyle(
                                                                                                                      fontFamily: AppDetails.cairoRegular,
                                                                                                                      fontSize: 17,
                                                                                                                      color: CommonColor.checkedDarkColor,
                                                                                                                    ),
                                                                                                                    counterText: "",
                                                                                                                    border: OutlineInputBorder(
                                                                                                                      borderSide: BorderSide(
                                                                                                                        color: CommonColor.borderColor,
                                                                                                                        width: 1,
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                    errorBorder: OutlineInputBorder(
                                                                                                                      borderRadius: BorderRadius.circular(20),
                                                                                                                      borderSide: BorderSide(
                                                                                                                        color: CommonColor.blackColor,
                                                                                                                        width: 1,
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                    enabledBorder: OutlineInputBorder(
                                                                                                                      borderRadius: BorderRadius.circular(20),
                                                                                                                      borderSide: BorderSide(
                                                                                                                        color: CommonColor.borderColor,
                                                                                                                        width: 1,
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                    focusedBorder: OutlineInputBorder(
                                                                                                                      borderRadius: BorderRadius.circular(20),
                                                                                                                      borderSide: BorderSide(
                                                                                                                        color: CommonColor.borderColor,
                                                                                                                        width: 1,
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                    focusedErrorBorder: OutlineInputBorder(
                                                                                                                      borderRadius: BorderRadius.circular(20),
                                                                                                                      borderSide: BorderSide(
                                                                                                                        color: CommonColor.borderColor,
                                                                                                                        width: 1,
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ],
                                                                                                          ),
                                                                                                          actions: [
                                                                                                            Container(
                                                                                                              padding: const EdgeInsets.symmetric(horizontal: 10),
                                                                                                              margin: const EdgeInsets.symmetric(horizontal: 50),
                                                                                                              decoration: BoxDecoration(
                                                                                                                border: Border.all(color: "#365133".toHexa()),
                                                                                                                borderRadius: BorderRadius.circular(30),
                                                                                                                color: CommonColor.whiteColor,
                                                                                                                boxShadow: [
                                                                                                                  BoxShadow(
                                                                                                                    color: Colors.grey.shade500,
                                                                                                                    blurRadius: 2.0,
                                                                                                                    spreadRadius: 0.0,
                                                                                                                    offset: const Offset(0, 3),
                                                                                                                  )
                                                                                                                ],
                                                                                                              ),
                                                                                                              child: IntrinsicHeight(
                                                                                                                child: Row(
                                                                                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                                                  children: [
                                                                                                                    InkWell(
                                                                                                                      onTap: () {
                                                                                                                        if (rejected.text == "") {
                                                                                                                          scaffoldKey.showTosta(context, message: 'هناك خطأ ما يرجى تعبئة جميع الحقول', isError: true);
                                                                                                                          return;
                                                                                                                        }
                                                                                                                        Firebase.shared.updateReports(context, scaffoldKey: scaffoldKey, date: items[index].createdDate, phone: items[index].phone!, place: items[index].place!, title: items[index].title!, uidUser: items[index].uidUser!, nameUser: items[index].nameUser!, idUser: items[index].idUser!, uidSpecialist: items[index].uidSpecialist!, idSpecialist: items[index].idSpecialist!, note: items[index].note!, id: items[index].id!, rejected: rejected.text, status: Status.cancel, report: items[index].report);
                                                                                                                      },
                                                                                                                      child: textWidget(
                                                                                                                        fontFamily: AppDetails.cairoRegular,
                                                                                                                        fontSize: 15,
                                                                                                                        color: "#365133".toHexa(),
                                                                                                                        text: "ارسال",
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                    // ----vertical
                                                                                                                    Center(
                                                                                                                      child: VerticalDivider(
                                                                                                                        color: "#365133".toHexa(),
                                                                                                                        thickness: 2,
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                    InkWell(
                                                                                                                      onTap: () => Navigator.pop(context),
                                                                                                                      child: textWidget(
                                                                                                                        fontFamily: AppDetails.cairoRegular,
                                                                                                                        text: "العودة",
                                                                                                                        fontSize: 15,
                                                                                                                        color: "#365133".toHexa(),
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                  ],
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ],
                                                                                                        ),
                                                                                                      );
                                                                                                    },
                                                                                                  );
                                                                                                },
                                                                                                child: textWidget(
                                                                                                  fontFamily: AppDetails.cairoRegular,
                                                                                                  fontSize: 15,
                                                                                                  color: "#365133".toHexa(),
                                                                                                  text: "الغاء الجلسة",
                                                                                                ),
                                                                                              ),
                                                                                              VerticalDivider(
                                                                                                color: "#365133".toHexa(),
                                                                                                thickness: 2,
                                                                                              ),
                                                                                              InkWell(
                                                                                                onTap: () {
                                                                                                  Navigator.of(context).pop();
                                                                                                  showDialog(
                                                                                                    context: context,
                                                                                                    builder: (context) {
                                                                                                      return sessionAlertDialogWidget(
                                                                                                        reports: items[index],
                                                                                                      );
                                                                                                    },
                                                                                                  );
                                                                                                },
                                                                                                child: textWidget(
                                                                                                  fontFamily: AppDetails.cairoRegular,
                                                                                                  text: "اعادة جدولة",
                                                                                                  fontSize: 15,
                                                                                                  color: "#365133".toHexa(),
                                                                                                ),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                                actionsAlignment: MainAxisAlignment.center,
                                                                                actions: [
                                                                                  ElevatedButton(
                                                                                    style: ElevatedButton.styleFrom(
                                                                                      elevation: 6.0,
                                                                                      shadowColor: CommonColor.calendarColor,
                                                                                      backgroundColor: CommonColor.whiteColor,
                                                                                      shape: RoundedRectangleBorder(
                                                                                        side: BorderSide(color: CommonColor.calendarColor),
                                                                                        borderRadius: BorderRadius.circular(20),
                                                                                      ),
                                                                                    ),
                                                                                    onPressed: () {
                                                                                      Navigator.of(context).pop();
                                                                                    },
                                                                                    child: textWidget(
                                                                                      text: "رجوع",
                                                                                      color: CommonColor.calendarColor,
                                                                                    ),
                                                                                  ),
                                                                                  ElevatedButton(
                                                                                    style: ElevatedButton.styleFrom(
                                                                                      elevation: 6.0,
                                                                                      shadowColor: CommonColor.calendarColor,
                                                                                      backgroundColor: CommonColor.whiteColor,
                                                                                      shape: RoundedRectangleBorder(
                                                                                        side: BorderSide(color: CommonColor.calendarColor),
                                                                                        borderRadius: BorderRadius.circular(20),
                                                                                      ),
                                                                                    ),
                                                                                    onPressed: () {
                                                                                      Navigator.of(context).pop();
                                                                                    },
                                                                                    child: textWidget(
                                                                                      text: "حفظ",
                                                                                      color: CommonColor.calendarColor,
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              );
                                                                            },
                                                                          );
                                                                        },
                                                                        child: Image
                                                                            .asset(
                                                                          Assets
                                                                              .shared
                                                                              .eye,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  )
                                                                ],
                                                              )),
                                                        );
                                                      },
                                                    );
                                                  } else {
                                                    return const SizedBox();
                                                  }
                                                }),
                                          ],
                                        ),
                                      )),
                                  Container(
                                    margin: const EdgeInsets.only(top: 70),
                                    child: Align(
                                      alignment: Alignment.topCenter,
                                      child: CircleAvatar(
                                        radius: 50,
                                        backgroundColor: Colors.white,
                                        child: user!.image != ""
                                            ? Container(
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                            user.image),
                                                        fit: BoxFit.cover)),
                                              )
                                            : Icon(
                                                Icons.person,
                                                size: 52,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary,
                                              ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return Stack(
                                children: [
                                  Image.asset(
                                    fit: BoxFit.cover,
                                    Assets.shared.SpeciaListHome,
                                    width: MediaQuery.of(context).size.width,
                                  ),
                                  Align(
                                      alignment: Alignment.center,
                                      child: Container(
                                        padding: const EdgeInsets.all(25),
                                        margin: const EdgeInsets.only(top: 120),
                                        width: 357,
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
                                            borderRadius:
                                                BorderRadius.circular(35)),
                                        child: Column(
                                          children: [
                                            const SizedBox(
                                              height: 30,
                                            ),
                                            Text(
                                              'اهلا،   ',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: "#365133".toHexa(),
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  width: 70.01,
                                                  child: Divider(
                                                    color: "#9DBA89".toHexa(),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                const Text("مواعيد اليوم"),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                SizedBox(
                                                  width: 70.01,
                                                  child: Divider(
                                                    color: "#9DBA89".toHexa(),
                                                  ),
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            FutureBuilder<List<ReportsModel>>(
                                                future: Firebase.shared.reports(
                                                    uid: Firebase.shared.auth
                                                        .currentUser!.uid),
                                                builder: (context, snapshot) {
                                                  if (snapshot.hasData) {
                                                    List<ReportsModel>? items =
                                                        [];
                                                    for (var add
                                                        in snapshot.data!) {
                                                      if (add.status ==
                                                          Status.active) {
                                                        if (DateFormat(
                                                                    'EEE, M/d/y')
                                                                .format(add
                                                                    .createdDate) ==
                                                            DateFormat(
                                                                    'EEE, M/d/y')
                                                                .format(DateTime
                                                                    .now())) {
                                                          items.add(add);
                                                        }
                                                      }
                                                    }
                                                    return ListView.builder(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10.0),
                                                      shrinkWrap: true,
                                                      itemCount: items.length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return Card(
                                                          elevation: 3,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                          ),
                                                          shadowColor:
                                                              CommonColor
                                                                  .blackColor,
                                                          child: Container(
                                                              width: 323,
                                                              height: 51,
                                                              decoration:
                                                                  BoxDecoration(
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color: "#D9D9D9"
                                                                        .toHexa(),
                                                                    offset:
                                                                        const Offset(
                                                                      0.0,
                                                                      5.0,
                                                                    ),
                                                                    blurRadius:
                                                                        0.10,
                                                                    spreadRadius:
                                                                        0.10,
                                                                  ),
                                                                ],
                                                                color: "#f3f3f3"
                                                                    .toHexa(),
                                                                borderRadius:
                                                                    const BorderRadius
                                                                        .all(
                                                                        Radius.circular(
                                                                            20)),
                                                              ),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            10),
                                                                    child: Image
                                                                        .asset(
                                                                      items[index].report !=
                                                                              Report
                                                                                  .online
                                                                          ? Assets
                                                                              .shared
                                                                              .tea
                                                                          : Assets
                                                                              .shared
                                                                              .interview,
                                                                    ),
                                                                  ),
                                                                  textWidget(
                                                                    text: DateFormat(
                                                                            'hh:mm a')
                                                                        .format(
                                                                            items[index].createdDate),
                                                                    fontFamily:
                                                                        AppDetails
                                                                            .cairoRegular,
                                                                    color: CommonColor
                                                                        .checkedDarkColor,
                                                                    fontSize:
                                                                        16,
                                                                  ),
                                                                  Stack(
                                                                    alignment:
                                                                        AlignmentDirectional
                                                                            .center,
                                                                    children: [
                                                                      Image
                                                                          .asset(
                                                                        Assets
                                                                            .shared
                                                                            .background_S,
                                                                      ),
                                                                      InkWell(
                                                                        onTap:
                                                                            () {
                                                                          showDialog(
                                                                            context:
                                                                                context,
                                                                            builder:
                                                                                (context) {
                                                                              return AlertDialog(
                                                                                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                                                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                                                                title: Stack(
                                                                                  alignment: Alignment.center,
                                                                                  children: [
                                                                                    const SizedBox(
                                                                                      height: 40,
                                                                                    ),
                                                                                    textWidget(
                                                                                      text: "معلومات الموعد",
                                                                                      fontSize: 22,
                                                                                      fontFamily: AppDetails.cairoRegular,
                                                                                    ),
//                                                                                    Positioned(bottom: 20, left: 65, child: Center(child: Image.asset(Assets.shared.vector))),
                                                                                  ],
                                                                                ),
                                                                                content: SingleChildScrollView(
                                                                                  child: Column(
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    mainAxisSize: MainAxisSize.min,
                                                                                    children: [
                                                                                      textWidget(
                                                                                        text: "اسم صاحب النباتات:",
                                                                                        fontSize: 18,
                                                                                        fontFamily: AppDetails.cairoRegular,
                                                                                        color: CommonColor.calendarColor,
                                                                                      ),
                                                                                      const SizedBox(
                                                                                        height: 5,
                                                                                      ),
                                                                                      textWidget(
                                                                                        text: items[index].nameUser,
                                                                                        fontSize: 16,
                                                                                        fontFamily: AppDetails.cairoRegular,
                                                                                        color: CommonColor.blackColor,
                                                                                      ),
                                                                                      const SizedBox(
                                                                                        height: 5,
                                                                                      ),
                                                                                      textWidget(
                                                                                        text: "رقم التواصل:",
                                                                                        fontSize: 18,
                                                                                        fontFamily: AppDetails.cairoRegular,
                                                                                        color: CommonColor.calendarColor,
                                                                                      ),
                                                                                      const SizedBox(
                                                                                        height: 5,
                                                                                      ),
                                                                                      textWidget(
                                                                                        text: items[index].phone,
                                                                                        fontSize: 16,
                                                                                        fontFamily: AppDetails.cairoRegular,
                                                                                        color: CommonColor.blackColor,
                                                                                      ),
                                                                                      const SizedBox(
                                                                                        height: 5,
                                                                                      ),
                                                                                      textWidget(
                                                                                        text: "العنوان:",
                                                                                        fontSize: 18,
                                                                                        fontFamily: AppDetails.cairoRegular,
                                                                                        color: CommonColor.calendarColor,
                                                                                      ),
                                                                                      const SizedBox(
                                                                                        height: 5,
                                                                                      ),
                                                                                      textWidget(
                                                                                        text: items[index].place,
                                                                                        fontSize: 16,
                                                                                        fontFamily: AppDetails.cairoRegular,
                                                                                        color: CommonColor.blackColor,
                                                                                      ),
                                                                                      const SizedBox(
                                                                                        height: 5,
                                                                                      ),
                                                                                      textWidget(
                                                                                        text: "زمن الجلسة:",
                                                                                        fontSize: 18,
                                                                                        fontFamily: AppDetails.cairoRegular,
                                                                                        color: CommonColor.calendarColor,
                                                                                      ),
                                                                                      const SizedBox(
                                                                                        height: 5,
                                                                                      ),
                                                                                      textWidget(
                                                                                        text: DateFormat('hh:mm a').format(items[index].createdDate),
                                                                                        fontSize: 16,
                                                                                        fontFamily: AppDetails.cairoRegular,
                                                                                        color: CommonColor.blackColor,
                                                                                      ),
                                                                                      const SizedBox(
                                                                                        height: 5,
                                                                                      ),
                                                                                      textWidget(
                                                                                        text: "نوع الجلسة:",
                                                                                        fontSize: 18,
                                                                                        fontFamily: AppDetails.cairoRegular,
                                                                                        color: CommonColor.calendarColor,
                                                                                      ),
                                                                                      const SizedBox(
                                                                                        height: 5,
                                                                                      ),
                                                                                      textWidget(
                                                                                        text: items[index].report == Report.online ? 'اون لاين' : 'زيارة ميدانية',
                                                                                        fontSize: 16,
                                                                                        fontFamily: AppDetails.cairoRegular,
                                                                                        color: CommonColor.blackColor,
                                                                                      ),
                                                                                      const SizedBox(
                                                                                        height: 20,
                                                                                      ),
                                                                                      Container(
                                                                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                                                                        margin: const EdgeInsets.symmetric(horizontal: 40),
                                                                                        decoration: BoxDecoration(
                                                                                          border: Border.all(color: "#365133".toHexa()),
                                                                                          borderRadius: BorderRadius.circular(30),
                                                                                          color: CommonColor.whiteColor,
                                                                                          boxShadow: [
                                                                                            BoxShadow(
                                                                                              color: Colors.grey.shade500,
                                                                                              blurRadius: 2.0,
                                                                                              spreadRadius: 0.0,
                                                                                              offset: const Offset(0, 3),
                                                                                            )
                                                                                          ],
                                                                                        ),
                                                                                        child: IntrinsicHeight(
                                                                                          child: Row(
                                                                                            children: [
                                                                                              InkWell(
                                                                                                onTap: () {
                                                                                                  Navigator.of(context).pop();
                                                                                                  showDialog(
                                                                                                    context: context,
                                                                                                    builder: (context) {
                                                                                                      return Center(
                                                                                                        child: AlertDialog(
                                                                                                          actionsPadding: const EdgeInsets.only(bottom: 20),
                                                                                                          shape: RoundedRectangleBorder(
                                                                                                            borderRadius: BorderRadius.circular(20),
                                                                                                          ),
                                                                                                          title: SizedBox(
                                                                                                            height: 80,
                                                                                                            width: 80,
                                                                                                            child: Image.asset(Assets.shared.cancel),
                                                                                                          ),
                                                                                                          contentPadding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
                                                                                                          content: Column(
                                                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                                                            mainAxisSize: MainAxisSize.min,
                                                                                                            children: [
                                                                                                              Padding(
                                                                                                                padding: const EdgeInsets.only(right: 20.0),
                                                                                                                child: textWidget(
                                                                                                                  text: "الرجاء كتابة سبب الغاء الجلسة",
                                                                                                                  color: CommonColor.titleColor,
                                                                                                                  fontFamily: AppDetails.cairoRegular,
                                                                                                                  fontSize: 24,
                                                                                                                ),
                                                                                                              ),
                                                                                                              const SizedBox(
                                                                                                                height: 20,
                                                                                                              ),
                                                                                                              Container(
                                                                                                                margin: const EdgeInsets.symmetric(horizontal: 20),
                                                                                                                decoration: BoxDecoration(
                                                                                                                  borderRadius: BorderRadius.circular(20),
                                                                                                                  // Border radius for the container
                                                                                                                  boxShadow: [
                                                                                                                    BoxShadow(
                                                                                                                      color: Colors.grey.shade500,
                                                                                                                      blurRadius: 2.0,
                                                                                                                      spreadRadius: 0.0,
                                                                                                                      offset: const Offset(0, 3), // shadow direction: bottom right
                                                                                                                    ),
                                                                                                                  ],
                                                                                                                ),
                                                                                                                child: TextFormField(
                                                                                                                  maxLines: 6,
                                                                                                                  textAlignVertical: TextAlignVertical.top,
                                                                                                                  textInputAction: TextInputAction.next,
                                                                                                                  validator: (value) {
                                                                                                                    return null;
                                                                                                                  },
                                                                                                                  controller: rejected,
                                                                                                                  style: TextStyle(
                                                                                                                    fontFamily: AppDetails.cairoMedium,
                                                                                                                    fontSize: 16.0,
                                                                                                                    fontWeight: FontWeight.w400,
                                                                                                                    color: CommonColor.blackColor,
                                                                                                                  ),
                                                                                                                  keyboardType: TextInputType.text,
                                                                                                                  decoration: InputDecoration(
                                                                                                                    filled: true,
                                                                                                                    fillColor: CommonColor.whiteColor,
                                                                                                                    contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                                                                                                    floatingLabelBehavior: FloatingLabelBehavior.always,
                                                                                                                    labelStyle: TextStyle(
                                                                                                                      fontFamily: AppDetails.cairoRegular,
                                                                                                                      fontSize: 17,
                                                                                                                      color: CommonColor.checkedDarkColor,
                                                                                                                    ),
                                                                                                                    counterText: "",
                                                                                                                    border: OutlineInputBorder(
                                                                                                                      borderSide: BorderSide(
                                                                                                                        color: CommonColor.borderColor,
                                                                                                                        width: 1,
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                    errorBorder: OutlineInputBorder(
                                                                                                                      borderRadius: BorderRadius.circular(20),
                                                                                                                      borderSide: BorderSide(
                                                                                                                        color: CommonColor.blackColor,
                                                                                                                        width: 1,
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                    enabledBorder: OutlineInputBorder(
                                                                                                                      borderRadius: BorderRadius.circular(20),
                                                                                                                      borderSide: BorderSide(
                                                                                                                        color: CommonColor.borderColor,
                                                                                                                        width: 1,
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                    focusedBorder: OutlineInputBorder(
                                                                                                                      borderRadius: BorderRadius.circular(20),
                                                                                                                      borderSide: BorderSide(
                                                                                                                        color: CommonColor.borderColor,
                                                                                                                        width: 1,
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                    focusedErrorBorder: OutlineInputBorder(
                                                                                                                      borderRadius: BorderRadius.circular(20),
                                                                                                                      borderSide: BorderSide(
                                                                                                                        color: CommonColor.borderColor,
                                                                                                                        width: 1,
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ],
                                                                                                          ),
                                                                                                          actions: [
                                                                                                            Container(
                                                                                                              padding: const EdgeInsets.symmetric(horizontal: 10),
                                                                                                              margin: const EdgeInsets.symmetric(horizontal: 50),
                                                                                                              decoration: BoxDecoration(
                                                                                                                border: Border.all(color: "#365133".toHexa()),
                                                                                                                borderRadius: BorderRadius.circular(30),
                                                                                                                color: CommonColor.whiteColor,
                                                                                                                boxShadow: [
                                                                                                                  BoxShadow(
                                                                                                                    color: Colors.grey.shade500,
                                                                                                                    blurRadius: 2.0,
                                                                                                                    spreadRadius: 0.0,
                                                                                                                    offset: const Offset(0, 3),
                                                                                                                  )
                                                                                                                ],
                                                                                                              ),
                                                                                                              child: IntrinsicHeight(
                                                                                                                child: Row(
                                                                                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                                                  children: [
                                                                                                                    InkWell(
                                                                                                                      onTap: () {
                                                                                                                        if (rejected.text == "") {
                                                                                                                          scaffoldKey.showTosta(context, message: 'هناك خطأ ما يرجى تعبئة جميع الحقول', isError: true);
                                                                                                                          return;
                                                                                                                        }
                                                                                                                        Firebase.shared.updateReports(context, scaffoldKey: scaffoldKey, date: items[index].createdDate, phone: items[index].phone!, place: items[index].place!, title: items[index].title!, uidUser: items[index].uidUser!, nameUser: items[index].nameUser!, idUser: items[index].idUser!, uidSpecialist: items[index].uidSpecialist!, idSpecialist: items[index].idSpecialist!, note: items[index].note!, id: items[index].id!, rejected: rejected.text, status: Status.cancel, report: items[index].report);
                                                                                                                      },
                                                                                                                      child: textWidget(
                                                                                                                        fontFamily: AppDetails.cairoRegular,
                                                                                                                        fontSize: 15,
                                                                                                                        color: "#365133".toHexa(),
                                                                                                                        text: "ارسال",
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                    // ----vertical
                                                                                                                    Center(
                                                                                                                      child: VerticalDivider(
                                                                                                                        color: "#365133".toHexa(),
                                                                                                                        thickness: 2,
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                    InkWell(
                                                                                                                      onTap: () => Navigator.pop(context),
                                                                                                                      child: textWidget(
                                                                                                                        fontFamily: AppDetails.cairoRegular,
                                                                                                                        text: "العودة",
                                                                                                                        fontSize: 15,
                                                                                                                        color: "#365133".toHexa(),
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                  ],
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ],
                                                                                                        ),
                                                                                                      );
                                                                                                    },
                                                                                                  );
                                                                                                },
                                                                                                child: textWidget(
                                                                                                  fontFamily: AppDetails.cairoRegular,
                                                                                                  fontSize: 15,
                                                                                                  color: "#365133".toHexa(),
                                                                                                  text: "الغاء الجلسة",
                                                                                                ),
                                                                                              ),
                                                                                              VerticalDivider(
                                                                                                color: "#365133".toHexa(),
                                                                                                thickness: 2,
                                                                                              ),
                                                                                              InkWell(
                                                                                                onTap: () {
                                                                                                  Navigator.of(context).pop();
                                                                                                  showDialog(
                                                                                                    context: context,
                                                                                                    builder: (context) {
                                                                                                      return sessionAlertDialogWidget(
                                                                                                        reports: items[index],
                                                                                                      );
                                                                                                    },
                                                                                                  );
                                                                                                },
                                                                                                child: textWidget(
                                                                                                  fontFamily: AppDetails.cairoRegular,
                                                                                                  text: "اعادة جدولة",
                                                                                                  fontSize: 15,
                                                                                                  color: "#365133".toHexa(),
                                                                                                ),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                                actionsAlignment: MainAxisAlignment.center,
                                                                                actions: [
                                                                                  ElevatedButton(
                                                                                    style: ElevatedButton.styleFrom(
                                                                                      elevation: 6.0,
                                                                                      shadowColor: CommonColor.calendarColor,
                                                                                      backgroundColor: CommonColor.whiteColor,
                                                                                      shape: RoundedRectangleBorder(
                                                                                        side: BorderSide(color: CommonColor.calendarColor),
                                                                                        borderRadius: BorderRadius.circular(20),
                                                                                      ),
                                                                                    ),
                                                                                    onPressed: () {
                                                                                      Navigator.of(context).pop();
                                                                                    },
                                                                                    child: textWidget(
                                                                                      text: "رجوع",
                                                                                      color: CommonColor.calendarColor,
                                                                                    ),
                                                                                  ),
                                                                                  ElevatedButton(
                                                                                    style: ElevatedButton.styleFrom(
                                                                                      elevation: 6.0,
                                                                                      shadowColor: CommonColor.calendarColor,
                                                                                      backgroundColor: CommonColor.whiteColor,
                                                                                      shape: RoundedRectangleBorder(
                                                                                        side: BorderSide(color: CommonColor.calendarColor),
                                                                                        borderRadius: BorderRadius.circular(20),
                                                                                      ),
                                                                                    ),
                                                                                    onPressed: () {
                                                                                      Navigator.of(context).pop();
                                                                                    },
                                                                                    child: textWidget(
                                                                                      text: "حفظ",
                                                                                      color: CommonColor.calendarColor,
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              );
                                                                            },
                                                                          );
                                                                        },
                                                                        child: Image
                                                                            .asset(
                                                                          Assets
                                                                              .shared
                                                                              .eye,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  )
                                                                ],
                                                              )),
                                                        );
                                                      },
                                                    );
                                                  } else {
                                                    return const SizedBox();
                                                  }
                                                }),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        ),
                                      )),
                                  Container(
                                    margin: const EdgeInsets.only(top: 70),
                                    child: Align(
                                      alignment: Alignment.topCenter,
                                      child: CircleAvatar(
                                        radius: 50,
                                        backgroundColor: Colors.white,
                                        child: Icon(
                                          Icons.person,
                                          size: 52,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }
                          }),
                      const SizedBox(
                        height: 15,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushAndRemoveUntil<void>(
                            context,
                            MaterialPageRoute<void>(
                                builder: (BuildContext context) => HomePage(
                                  userType: Usertype.specialist,
                                  currentIndex: 4,
                                )),
                            ModalRoute.withName('/HomePage'),
                          );
                        },
                        child: Container(
                            width: 345,
                            height: 66,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: "#D9D9D9".toHexa(),
                                  offset: const Offset(
                                    0.0,
                                    5.0,
                                  ),
                                  blurRadius: 0.10,
                                  spreadRadius: 0.10,
                                ),
                              ],
                              color: "#f3f3f3".toHexa(),
                              borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Center(
                              child: Text(
                                'عرض تقارير الجلسات ',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: "#365133".toHexa(),
                                  fontSize: 20,
                                ),
                              ),
                            )),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            Ratings = true;
                          });
                        },
                        child: Container(
                            width: 345,
                            height: 66,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: "#D9D9D9".toHexa(),
                                  offset: const Offset(
                                    0.0,
                                    5.0,
                                  ),
                                  blurRadius: 0.10,
                                  spreadRadius: 0.10,
                                ),
                              ],
                              color: "#f3f3f3".toHexa(),
                              borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Center(
                              child: Text(
                                'التقيميات والمراجعة',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: "#365133".toHexa(),
                                  fontSize: 20,
                                ),
                              ),
                            )),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushAndRemoveUntil<void>(
                            context,
                            MaterialPageRoute<void>(
                                builder: (BuildContext context) => HomePage(
                                  userType: Usertype.specialist,
                                  currentIndex: 1,
                                )),
                            ModalRoute.withName('/HomePage'),
                          );
                        },
                        child: Container(
                            width: 345,
                            height: 66,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: "#D9D9D9".toHexa(),
                                  offset: const Offset(
                                    0.0,
                                    5.0,
                                  ),
                                  blurRadius: 0.10,
                                  spreadRadius: 0.10,
                                ),
                              ],
                              color: "#f3f3f3".toHexa(),
                              borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Center(
                              child: Text(
                                'عرض المواعيد',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: "#365133".toHexa(),
                                  fontSize: 20,
                                ),
                              ),
                            )),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushAndRemoveUntil<void>(
                            context,
                            MaterialPageRoute<void>(
                                builder: (BuildContext context) => HomePage(
                                      userType: Usertype.specialist,
                                      currentIndex: 3,
                                    )),
                            ModalRoute.withName('/HomePage'),
                          );
                        },
                        child: Container(
                            width: 345,
                            height: 66,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: "#D9D9D9".toHexa(),
                                  offset: const Offset(
                                    0.0,
                                    5.0,
                                  ),
                                  blurRadius: 0.10,
                                  spreadRadius: 0.10,
                                ),
                              ],
                              color: "#f3f3f3".toHexa(),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Center(
                              child: Text(
                                'ادارة طلبات الجلسات',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: "#365133".toHexa(),
                                  fontSize: 20,
                                ),
                              ),
                            )),
                      ),
                    ])),
          ))
        : ratings();
  }

  ratings() {
    return SingleChildScrollView(
        child: Center(
      child: Container(
          constraints: const BoxConstraints(
            maxWidth: 500,
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Stack(
              children: [
                Image.asset(
                  fit: BoxFit.cover,
                  Assets.shared.SpeciaListHome,
                  width: MediaQuery.of(context).size.width,
                ),
                Align(
                    alignment: Alignment.center,
                    child: Container(
                      padding: const EdgeInsets.all(30),
                      margin: const EdgeInsets.only(top: 115),
                      width: 330,
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
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        'التقيمات و المراجعة',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            color: "#365133".toHexa(),
                            fontWeight: FontWeight.bold),
                      ),
                    )),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding:  const EdgeInsets.only(top: 135),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_forward_ios),
                        onPressed: () {
                          setState(() {
                            Ratings = false;
                          });
                        },
                        color: CommonColor.borderColor,
                      ),
                    )
                ),
              ],
            ),
            FutureBuilder<List<ReviewsModel>>(
                future: Firebase.shared
                    .reviews(uid: Firebase.shared.auth.currentUser!.uid),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<ReviewsModel>? items = snapshot.data!;
                    return ListView.builder(
                      padding: const EdgeInsets.all(10.0),
                      shrinkWrap: true,
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return Card(
                            elevation: 4,
                            surfaceTintColor: Colors.white,
                            color: Colors.white,
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              side: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 30,
                                        backgroundColor: Colors.white,
                                        child: items[index].logo != ""
                                            ? Container(
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                            items[index].logo),
                                                        fit: BoxFit.cover)),
                                              )
                                            : Icon(
                                                Icons.person,
                                                size: 52,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary,
                                              ),
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      Text(items[index].name),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        "التقييم:  ",
                                      ),
                                      RatingBarIndicator(
                                        itemSize: 15,
                                        rating: items[index].review,
                                        itemCount: 5,
                                        itemBuilder: (context, _) =>
                                            Image.asset(
                                          Assets.shared.flowerImg,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        "مراجعة:  ",
                                      ),
                                      Text(
                                        items[index].note,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ));
                      },
                    );
                  } else {
                    return const SizedBox();
                  }
                }),
          ])),
    ));
  }
}
