import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ghiras/Firebase.dart';
import 'package:ghiras/widgets/AppDetails.dart';
import 'package:ghiras/widgets/assets.dart';
import 'package:ghiras/widgets/extensions.dart';
import 'package:intl/intl.dart';
import '../../Model/AvailableModel.dart';
import '../../Model/ReportsModel.dart';
import '../../Model/ReviewsModel.dart';
import '../../enum/Calendar.dart';
import '../../enum/report.dart';
import '../../enum/status.dart';
import '../../widgets/commonColor.dart';
import '../../widgets/commonWidget.dart';
import '../../widgets/sessionAlertDialogWidget.dart';
import '../sessionCall.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _selectedDate = DateTime.now();
  int _selectedMonthIndex = DateTime.now().month - 1;
  DateTime now = DateTime.now();
  String formattedDate = DateFormat('d MMM yyyy').format(DateTime.now());
  Calendar page = Calendar.home;
  TextEditingController rejected = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController note = TextEditingController();
  late ReportsModel data;

  // available
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  DateTime availableDate = DateTime.now();

  void _previousMonth() {
    setState(() {
      availableDate = DateTime(availableDate.year, availableDate.month - 1, 1);
    });
  }

  void _nextMonth() {
    setState(() {
      availableDate = DateTime(availableDate.year, availableDate.month + 1, 1);
    });
  }

  void _onDateSelected(DateTime selectedDate) {
    setState(() {
      availableDate = selectedDate;
    });
  }

  String _selectedAmPm = 'AM';
  final List<String> _ampm = ['AM', 'PM'];
  final List<int> _hours = List.generate(12, (index) => index + 1);
  final List<int> _minutes = List.generate(60, (index) => index);
  int _selectedHour = 1;
  int _selectedMinute = 0;

  List<DateTime> _getDatesInMonth(DateTime month) {
    var firstDayOfMonth = DateTime(month.year, month.month, 1);
    var lastDayOfMonth = DateTime(month.year, month.month + 1, 0);
    var days = List<DateTime>.generate(lastDayOfMonth.day,
        (index) => firstDayOfMonth.add(Duration(days: index)));
    return days;
  }

  int _getDaysInMonth(int monthIndex) {
    DateTime now = DateTime.now();
    DateTime thisMonth =
        DateTime(now.year - 50 + monthIndex ~/ 12, monthIndex % 12 + 1);
    return DateTime(thisMonth.year, thisMonth.month + 1, 0).day;
  }

  @override
  Widget build(BuildContext context) {
    return pageStart(context);
  }

  pageStart(context) {
    if (page == Calendar.home) {
      return calendar(context);
    } else if (page == Calendar.ratings) {
      return sessionInformationScreen(context);
    } else if (page == Calendar.report) {
      return reportScreen(context);
    } else if (page == Calendar.available) {
      return available(context);
    }
  }

  Widget calendar(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 50,
            ),
            dateCardWidget(),
            const SizedBox(
              height: 25,
            ),
            FutureBuilder<List<ReportsModel>>(
                future: Firebase.shared.reports(uid: Firebase.shared.auth.currentUser!.uid),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<ReportsModel>? items = [];
                    for (var add in snapshot.data!) {
                      if (add.status == Status.active) {
                        if (DateFormat('EEE, M/d/y').format(add.createdDate) == DateFormat('EEE, M/d/y').format(_selectedDate)) {
                          items.add(add);
                        }
                      }
                    }
                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            shadowColor: CommonColor.blackColor,
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: CommonColor.whiteColor,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 16.0, top: 16, right: 16.0),
                                      child: Image.asset(
                                          items[index].report == Report.online
                                              ? Assets.shared.interview
                                              : Assets.shared.tea),
                                    ),
                                    Column(
                                      children: [
                                        textWidget(
                                          text: DateFormat('hh:mm a')
                                              .format(items[index].createdDate),
                                          fontFamily: AppDetails.cairoRegular,
                                          color: CommonColor.checkedDarkColor,
                                          fontSize: 16,
                                        ),
                                        Visibility(
                                            visible: items[index].report == Report.online,
                                            child: InkWell(
                                                onTap: () {
                                                  Firebase.shared.updateReportsStatus(id: items[index].id!, status: Status.close);
                                                  setState(() {
                                                    page = Calendar.ratings;
                                                    data = items[index];
                                                  });
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            SessionCall(
                                                              report:
                                                                  items[index],
                                                            )),
                                                  );
                                                },
                                                child: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 30),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      color:
                                                          "#ABDDDF".toHexa()),
                                                  child: textWidget(
                                                    text: "ابدا",
                                                    fontFamily:
                                                        AppDetails.cairoRegular,
                                                    color: CommonColor
                                                        .checkedDarkColor,
                                                    fontSize: 16,
                                                  ),
                                                ))),
                                        Visibility(
                                            visible: items[index].report ==
                                                Report.outside,
                                            child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    page = Calendar.report;
                                                    data = items[index];
                                                  });
                                                },
                                                child: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 30),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      color:
                                                          "#ABDDDF".toHexa()),
                                                  child: textWidget(
                                                    text: "كتابه تقرير",
                                                    fontFamily:
                                                        AppDetails.cairoRegular,
                                                    color: CommonColor
                                                        .checkedDarkColor,
                                                    fontSize: 16,
                                                  ),
                                                ))),
                                      ],
                                    ),
                                    InkWell(
                                      child: Container(
                                        height: 75,
                                        width: 70,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(20),
                                                    bottomLeft:
                                                        Radius.circular(20)),
                                            color: "#D1DFC8".toHexa()),
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Image.asset(
                                            Assets.shared.eye,
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 20),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              title: Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  const SizedBox(
                                                    height: 40,
                                                  ),
                                                  textWidget(
                                                    text: "معلومات الموعد",
                                                    fontSize: 22,
                                                    fontFamily:
                                                        AppDetails.cairoRegular,
                                                  ),
//                                                  Positioned(
//                                                       bottom: 20,
//                                                       left: 65,
//                                                       child: Center(
//                                                           child: Image.asset(
//                                                               Assets.shared
//                                                                   .vector))),
                                                ],
                                              ),
                                              content: SingleChildScrollView(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    textWidget(
                                                      text:
                                                          "اسم صاحب النباتات:",
                                                      fontSize: 18,
                                                      fontFamily: AppDetails
                                                          .cairoRegular,
                                                      color: CommonColor
                                                          .calendarColor,
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    textWidget(
                                                      text:
                                                          items[index].nameUser,
                                                      fontSize: 16,
                                                      fontFamily: AppDetails
                                                          .cairoRegular,
                                                      color: CommonColor
                                                          .blackColor,
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    textWidget(
                                                      text: "رقم التواصل:",
                                                      fontSize: 18,
                                                      fontFamily: AppDetails
                                                          .cairoRegular,
                                                      color: CommonColor
                                                          .calendarColor,
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    textWidget(
                                                      text: items[index].phone,
                                                      fontSize: 16,
                                                      fontFamily: AppDetails
                                                          .cairoRegular,
                                                      color: CommonColor
                                                          .blackColor,
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    textWidget(
                                                      text: "العنوان:",
                                                      fontSize: 18,
                                                      fontFamily: AppDetails
                                                          .cairoRegular,
                                                      color: CommonColor
                                                          .calendarColor,
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    textWidget(
                                                      text: items[index].place,
                                                      fontSize: 16,
                                                      fontFamily: AppDetails
                                                          .cairoRegular,
                                                      color: CommonColor
                                                          .blackColor,
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    textWidget(
                                                      text: "زمن الجلسة:",
                                                      fontSize: 18,
                                                      fontFamily: AppDetails
                                                          .cairoRegular,
                                                      color: CommonColor
                                                          .calendarColor,
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    textWidget(
                                                      text: DateFormat(
                                                              'hh:mm a')
                                                          .format(items[index]
                                                              .createdDate),
                                                      fontSize: 16,
                                                      fontFamily: AppDetails
                                                          .cairoRegular,
                                                      color: CommonColor
                                                          .blackColor,
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    textWidget(
                                                      text: "نوع الجلسة:",
                                                      fontSize: 18,
                                                      fontFamily: AppDetails
                                                          .cairoRegular,
                                                      color: CommonColor
                                                          .calendarColor,
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    textWidget(
                                                      text:
                                                          items[index].report ==
                                                                  Report.online
                                                              ? 'اون لاين'
                                                              : 'زيارة ميدانية',
                                                      fontSize: 16,
                                                      fontFamily: AppDetails
                                                          .cairoRegular,
                                                      color: CommonColor
                                                          .blackColor,
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 10),
                                                      margin: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 40),
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: "#365133"
                                                                .toHexa()),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                        color: CommonColor
                                                            .whiteColor,
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors
                                                                .grey.shade500,
                                                            blurRadius: 2.0,
                                                            spreadRadius: 0.0,
                                                            offset:
                                                                const Offset(
                                                                    0, 3),
                                                          )
                                                        ],
                                                      ),
                                                      child: IntrinsicHeight(
                                                        child: Row(
                                                          children: [
                                                            InkWell(
                                                              onTap: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                                showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return Center(
                                                                      child:
                                                                          AlertDialog(
                                                                        actionsPadding: const EdgeInsets
                                                                            .only(
                                                                            bottom:
                                                                                20),
                                                                        shape:
                                                                            RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(20),
                                                                        ),
                                                                        title:
                                                                            SizedBox(
                                                                          height:
                                                                              80,
                                                                          width:
                                                                              80,
                                                                          child: Image.asset(Assets
                                                                              .shared
                                                                              .cancel),
                                                                        ),
                                                                        contentPadding: const EdgeInsets
                                                                            .only(
                                                                            left:
                                                                                20,
                                                                            right:
                                                                                20,
                                                                            top:
                                                                                20,
                                                                            bottom:
                                                                                20),
                                                                        content:
                                                                            Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          mainAxisSize:
                                                                              MainAxisSize.min,
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
                                                                            descriptionWidget(),
                                                                          ],
                                                                        ),
                                                                        actions: [
                                                                          Container(
                                                                            padding:
                                                                                const EdgeInsets.symmetric(horizontal: 10),
                                                                            margin:
                                                                                const EdgeInsets.symmetric(horizontal: 50),
                                                                            decoration:
                                                                                BoxDecoration(
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
                                                                            child:
                                                                                IntrinsicHeight(
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
                                                                fontFamily:
                                                                    AppDetails
                                                                        .cairoRegular,
                                                                fontSize: 15,
                                                                color: "#365133"
                                                                    .toHexa(),
                                                                text:
                                                                    "الغاء الجلسة",
                                                              ),
                                                            ),
                                                            VerticalDivider(
                                                              color: "#365133"
                                                                  .toHexa(),
                                                              thickness: 2,
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                                showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return sessionAlertDialogWidget(
                                                                      reports:
                                                                          items[
                                                                              index],
                                                                    );
                                                                  },
                                                                );
                                                              },
                                                              child: textWidget(
                                                                fontFamily:
                                                                    AppDetails
                                                                        .cairoRegular,
                                                                text:
                                                                    "اعادة جدولة",
                                                                fontSize: 15,
                                                                color: "#365133"
                                                                    .toHexa(),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              actionsAlignment:
                                                  MainAxisAlignment.center,
                                              actions: [
                                                ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    elevation: 6.0,
                                                    shadowColor: CommonColor
                                                        .calendarColor,
                                                    backgroundColor:
                                                        CommonColor.whiteColor,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      side: BorderSide(
                                                          color: CommonColor
                                                              .calendarColor),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: textWidget(
                                                    text: "رجوع",
                                                    color: CommonColor
                                                        .calendarColor,
                                                  ),
                                                ),
                                                ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    elevation: 6.0,
                                                    shadowColor: CommonColor
                                                        .calendarColor,
                                                    backgroundColor:
                                                        CommonColor.whiteColor,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      side: BorderSide(
                                                          color: CommonColor
                                                              .calendarColor),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: textWidget(
                                                    text: "حفظ",
                                                    color: CommonColor
                                                        .calendarColor,
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                )),
                          ),
                        );
                      },
                    );
                  } else {
                    return const SizedBox();
                  }
                }),
          ],
        ),
      ),
    );
  }

  Container descriptionWidget() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(20), // Border radius for the container
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
          contentPadding:
              const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
    );
  }

  Card dateCardWidget() {
    return Card(
      shadowColor: CommonColor.blackColor,
      shape: RoundedRectangleBorder(
          side: BorderSide(color: CommonColor.whiteColor),
          borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      page = Calendar.available;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: CommonColor.calendarLightColor),
                    child: textWidget(
                      text: "ضبط الوقت المتاح للجلسات",
                    ),
                  ),
                ),
                textWidget(
                  color: CommonColor.blackColor,
                  fontFamily: AppDetails.fenixRegular,
                  fontSize: 20,
                  text: DateFormat('d MMM yyyy').format(DateTime.now()),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(12, (index) {
                DateTime thisMonth = DateTime(DateTime.now().year, index + 1);
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedMonthIndex = index;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: index == _selectedMonthIndex
                          ? CommonColor.selectedMonthColor
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text(
                        DateFormat('MMM').format(thisMonth),
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: AppDetails.fenixRegular,
                          color: index == _selectedMonthIndex
                              ? Colors.black
                              : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          SizedBox(
            height: 90,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _getDaysInMonth(_selectedMonthIndex),
              itemBuilder: (context, index) {
                DateTime firstDayOfMonth =
                    DateTime(DateTime.now().year, _selectedMonthIndex + 1, 1);
                int day = index + 1;
                DateTime currentDate =
                    DateTime(firstDayOfMonth.year, firstDayOfMonth.month, day);
                String formattedDate =
                    DateFormat('d-MMM-yyyy').format(currentDate);
                String dayOfWeek = DateFormat('EEE')
                    .format(currentDate); // Get first 3 letters of day
                bool isSelectedDate = _selectedDate.year == currentDate.year &&
                    _selectedDate.month == currentDate.month &&
                    _selectedDate.day == currentDate.day;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedDate = currentDate;
                    });
                    debugPrint('Selected Date: $_selectedDate');
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      color: isSelectedDate
                          ? "#EAF3EF".toHexa()
                          : "#f2f2f2".toHexa(),
                      elevation: 5,
                      shadowColor: CommonColor.blackColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('${currentDate.day}',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: isSelectedDate
                                        ? "#9ED8A0".toHexa()
                                        : CommonColor.blackColor,
                                    fontFamily: AppDetails.fenixRegular)),
                            const SizedBox(
                              height: 6,
                            ),
                            Text(dayOfWeek,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: AppDetails.fenixRegular,
                                  color: isSelectedDate
                                      ? "#9ED8A0".toHexa()
                                      : CommonColor.blackColor,
                                ))
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget sessionInformationScreen(BuildContext context) {
    return SingleChildScrollView(
        child: Center(
            child: Container(
      constraints: const BoxConstraints(
        maxWidth: 500,
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Image.asset(
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
                Assets.shared.backgroundRectangle,
              ),
              Positioned(
                  top: 120,
                  left: 200,
                  child: textWidget(
                    color: CommonColor.calendarColor,
                    text: "معلومات الجلسة",
                    fontFamily: AppDetails.cairoRegular,
                    fontSize: 25,
                  )),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 44, right: 44),
            child: Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              shadowColor: Colors.black,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 35, vertical: 25),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: CommonColor.calendarColor)),
                child: Column(
                  children: [
                    CommonTextFormField(
                      isReadyOnly: true,
                      label: "رقم الجلسة",
                      textInputAction: TextInputAction.next,
                      validator: (msg) {
                        return null;
                      },
                      controller: TextEditingController(),
                      hintText: data.id,
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(height: 25),
                    CommonTextFormField(
                      isReadyOnly: true,
                      label: "اسم صاحب النبات",
                      textInputAction: TextInputAction.next,
                      validator: (msg) {
                        return null;
                      },
                      controller: TextEditingController(),
                      hintText: data.nameUser,
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(height: 25),
                    CommonTextFormField(
                      isReadyOnly: true,
                      label: "زمن الجلسة",
                      textInputAction: TextInputAction.next,
                      validator: (msg) {
                        return null;
                      },
                      controller: TextEditingController(),
                      hintText: DateFormat('hh:mm a').format(data.createdDate),
                      keyboardType: TextInputType.text,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 36,
                width: 123,
                child: CommonButton(
                  onPress: () {
                    setState(() {
                      page = Calendar.home;
                    });
                  },
                  text: "العودة",
                  buttonColor: CommonColor.buttonColor,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                  height: 36,
                  width: 123,
                  child: CommonButton(
                    onPress: () {
                      setState(() {
                        page = Calendar.report;
                      });
                    },
                    text: "اضافة تقرير",
                    buttonColor: CommonColor.buttonColor,
                  )),
            ],
          ),
          const SizedBox(height: 20),
          FutureBuilder<ReviewsModel>(
              future: Firebase.shared.reviewsByUid(uid: data.id!),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  ReviewsModel? reviews = snapshot.data;
                  return Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      SizedBox(
                        width: 238,
                        child: Card(
                          shadowColor: Colors.black,
                          shape: RoundedRectangleBorder(
                              side: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(15)),
                          elevation: 4,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 50,
                              ),
                              textWidget(
                                text: data.nameUser,
                                fontSize: 15,
                                fontFamily: AppDetails.cairoRegular,
                                color: CommonColor.checkedDarkColor,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              RatingBarIndicator(
                                itemSize: 15,
                                rating: reviews!.review,
                                itemCount: 5,
                                itemBuilder: (context, _) => const Icon(
                                  CupertinoIcons.rosette,
                                  color: Colors.pink,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              textWidget(
                                text: reviews.note,
                                fontSize: 15,
                                fontFamily: AppDetails.cairoRegular,
                                color: Colors.grey,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.white,
                        child: reviews.logo != ""
                            ? Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: NetworkImage(reviews.logo),
                                        fit: BoxFit.cover)),
                              )
                            : Icon(
                                Icons.person,
                                size: 52,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                      )
                    ],
                  );
                } else {
                  return SizedBox(
                    width: 250,
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Card(
                          shadowColor: Colors.black,
                          shape: RoundedRectangleBorder(
                              side: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(15)),
                          elevation: 4,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 50,
                              ),
                              textWidget(
                                text: data.nameUser,
                                fontSize: 15,
                                fontFamily: AppDetails.cairoRegular,
                                color: CommonColor.checkedDarkColor,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              RatingBarIndicator(
                                itemSize: 15,
                                rating: 5,
                                itemCount: 5,
                                itemBuilder: (context, _) => const Icon(
                                  CupertinoIcons.rosette,
                                  color: Colors.pink,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              textWidget(
                                text: "     لم يتم اضافه التقيم     ",
                                fontSize: 15,
                                fontFamily: AppDetails.cairoRegular,
                                color: Colors.grey,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.person,
                            size: 52,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ],
                    ),
                  );
                }
              })
        ],
      ),
    )));
  }

  Widget reportScreen(BuildContext context) {
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
                Container(
                  padding: const EdgeInsets.only(top: 90, left: 10, right: 10),
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Card(
                        color: Colors.white,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 30,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.57,
                                child: Container(
                                  height: 44,
                                  width: 250,
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
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          boxShadow: [
                                            BoxShadow(
                                              color: data.report ==
                                                      Report.outside
                                                  ? CommonColor.containerColor
                                                  : Colors.white,
                                              offset: const Offset(
                                                0.0,
                                                2.0,
                                              ),
                                              blurRadius: 0.10,
                                              spreadRadius: 0.10,
                                            ),
                                          ],
                                          border: Border.all(
                                            color: Colors.white,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 25.0, vertical: 10),
                                          child: textWidget(
                                            text: "زيارة ميدانية",
                                            color: CommonColor
                                                .secondTextWidgetColor,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          border: Border.all(
                                            color: Colors.white,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: data.report ==
                                                      Report.online
                                                  ? CommonColor.containerColor
                                                  : Colors.white,
                                              offset: const Offset(
                                                0.0,
                                                2.0,
                                              ),
                                              blurRadius: 0.10,
                                              spreadRadius: 0.10,
                                            ),
                                          ],
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 25.0, vertical: 10),
                                          child: textWidget(
                                            text: "اون لاين",
                                            color: CommonColor
                                                .secondTextWidgetColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 26,
                              ),
                              CommonTextFormField(
                                label: "عنوان الجلسة",
                                textInputAction: TextInputAction.next,
                                validator: (msg) {
                                  return null;
                                },
                                controller: title,
                                hintText: data.title,
                                keyboardType: TextInputType.text,
                              ),
                              const SizedBox(height: 25),
                              CommonTextFormField(
                                isReadyOnly: true,
                                label: "رقم الجلسة",
                                textInputAction: TextInputAction.next,
                                validator: (msg) {
                                  return null;
                                },
                                controller: TextEditingController(),
                                hintText: data.id,
                                keyboardType: TextInputType.text,
                              ),
                              const SizedBox(height: 25),
                              CommonTextFormField(
                                isReadyOnly: true,
                                label: "اسم صاحب النبات",
                                textInputAction: TextInputAction.next,
                                validator: (msg) {
                                  return null;
                                },
                                controller: TextEditingController(),
                                hintText: data.nameUser,
                                keyboardType: TextInputType.text,
                              ),
                              const SizedBox(height: 25),
                              CommonTextFormField(
                                isReadyOnly: true,
                                label: "تاريخ الجلسه",
                                textInputAction: TextInputAction.next,
                                validator: (msg) {
                                  return null;
                                },
                                controller: TextEditingController(),
                                hintText: DateFormat('d MMM yyyy')
                                    .format(data.createdDate),
                                keyboardType: TextInputType.text,
                              ),
                              const SizedBox(height: 25),
                              CommonTextFormField(
                                isReadyOnly: true,
                                label: "زمن الجلسة",
                                textInputAction: TextInputAction.next,
                                validator: (msg) {
                                  return null;
                                },
                                controller: TextEditingController(),
                                hintText: DateFormat('hh:mm a')
                                    .format(data.createdDate),
                                keyboardType: TextInputType.text,
                              ),
                              const SizedBox(height: 25),
                              CommonTextFormField(
                                label: "الملاحظات",
                                hintText: data.note,
                                textInputAction: TextInputAction.next,
                                validator: (msg) {
                                  return null;
                                },
                                controller: note,
                                keyboardType: TextInputType.text,
                              ),
                              const SizedBox(height: 25),
                              Row(
                                children: [
                                  Expanded(
                                    child: CommonTextFormField(
                                      isReadyOnly: true,
                                      label: "معرف صاحب النبات",
                                      textInputAction: TextInputAction.next,
                                      validator: (msg) {
                                        return null;
                                      },
                                      controller: TextEditingController(),
                                      hintText: data.idUser,
                                      keyboardType: TextInputType.text,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: CommonTextFormField(
                                      isReadyOnly: true,
                                      label: "معرف الاخصائي",
                                      textInputAction: TextInputAction.next,
                                      validator: (msg) {
                                        return null;
                                      },
                                      controller: TextEditingController(),
                                      hintText: data.idSpecialist,
                                      keyboardType: TextInputType.text,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              height: 36,
                              width: 123,
                              child: CommonButton(
                                onPress: () {
                                  setState(() {
                                    page = Calendar.home;
                                  });
                                },
                                text: "العودة",
                                borderRadius: 20,
                                fontSize: 15,
                                buttonColor: CommonColor.buttonColor,
                              )),
                          const SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                              height: 36,
                              width: 123,
                              child: CommonButton(
                                onPress: () {
                                  if (title.text == "" || note.text == "") {
                                    scaffoldKey.showTosta(context,
                                        message:
                                            'هناك خطأ ما يرجى تعبئة جميع الحقول',
                                        isError: true);
                                    return;
                                  }
                                  Firebase.shared.updateReports(context,
                                      scaffoldKey: scaffoldKey,
                                      date: data.createdDate,
                                      phone: data.phone!,
                                      place: data.place!,
                                      title: title.text,
                                      note: note.text,
                                      uidUser: data.uidUser!,
                                      nameUser: data.nameUser!,
                                      idUser: data.idUser!,
                                      uidSpecialist: data.uidSpecialist!,
                                      idSpecialist: data.idSpecialist!,
                                      id: data.id!,
                                      rejected: data.rejected!,
                                      status: data.status,
                                      report: data.report);
                                  setState(() {
                                    page = Calendar.home;
                                  });
                                },
                                text: "حفظ",
                                buttonColor: CommonColor.buttonColor,
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.12,
                  decoration: BoxDecoration(
                    color: CommonColor.WidgetColor,
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(50),
                      bottomLeft: Radius.circular(50),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 60, left: 30, right: 30),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Card(
                      elevation: 4,
                      shadowColor: Colors.grey,
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              const BorderSide(color: Colors.transparent)),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: textWidget(
                            text: "اضافة تقرير جديد",
                            fontSize: 22,
                            fontFamily: AppDetails.cairoRegular,
                            color: CommonColor.blackColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ])),
    ));
  }

  Widget available(BuildContext context) {
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
                  Assets.shared.available,
                  width: MediaQuery.of(context).size.width,
                ),
                Align(
                    alignment: Alignment.center,
                    child: Container(
                      padding: const EdgeInsets.all(30),
                      margin: const EdgeInsets.only(top: 85),
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
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        'ضبط الوقت المتاح للجلسات',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: "#365133".toHexa(),
                        ),
                      ),
                    )),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(20),
              width: 357,
              decoration: BoxDecoration(boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(
                    0.0,
                    2.0,
                  ),
                  blurRadius: 0.10,
                  spreadRadius: 0.10,
                ),
              ], color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: _previousMonth,
                          color: CommonColor.borderColor,
                        ),
                        Text(
                          DateFormat.yMMMM().format(availableDate),
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: CommonColor.borderColor),
                        ),
                        IconButton(
                          color: CommonColor.borderColor,
                          icon: const Icon(Icons.arrow_forward),
                          onPressed: _nextMonth,
                        ),
                      ],
                    ),
                  ),
                  GridView.count(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 7,
                    padding: EdgeInsets.zero,
                    children: List.generate(
                      7,
                      (index) => Center(
                        child: Text(
                          DateFormat.E().format(DateTime(DateTime.now().year,
                              DateTime.now().month, index + 1)),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: CommonColor.calendarColor),
                        ),
                      ),
                    ),
                  ),
                  const Divider(
                    indent: 0,
                    thickness: 1,
                  ),
                  GridView.count(
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    crossAxisCount: 7,
                    children: _getDatesInMonth(availableDate).map((date) {
                      bool isSelected = date.year == availableDate.year &&
                          date.month == availableDate.month &&
                          date.day == availableDate.day;
                      return GestureDetector(
                        onTap: () => _onDateSelected(date),
                        child: Center(
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isSelected
                                  ? "#72B28A".toHexa()
                                  : Colors.transparent,
                            ),
                            child: Center(
                              child: Text(
                                '${date.day}',
                                style: TextStyle(
                                  fontFamily: AppDetails.cairoRegular,
                                  fontSize: 17,
                                  color: isSelected
                                      ? Colors.white
                                      : CommonColor.calendarColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            textWidget(
              text: "الزمن",
              color: CommonColor.checkedDarkColor,
              fontSize: 17,
              fontFamily: AppDetails.cairoRegular,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Material(
                  elevation: 6,
                  shadowColor: Colors.grey.withOpacity(0.5),
                  // Optional: Set shadow color
                  borderRadius: BorderRadius.circular(20),
                  // Optional: Set border radius
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      iconSize: 24,
                      iconEnabledColor: CommonColor.calendarColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 0),
                      value: _selectedAmPm,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedAmPm = newValue!;
                        });
                      },
                      items:
                          _ampm.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: textWidget(
                            text: value,
                            fontFamily: AppDetails.cairoRegular,
                            fontSize: 17,
                            color: CommonColor.calendarColor,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                Material(
                  elevation: 6,
                  shadowColor: Colors.grey.withOpacity(0.5),
                  // Optional: Set shadow color
                  borderRadius: BorderRadius.circular(20),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<int>(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 0),
                      itemHeight: null,
                      // iconSize: 0,
                      iconEnabledColor: CommonColor.calendarColor,
                      value: _selectedMinute,
                      onChanged: (int? newValue) {
                        setState(() {
                          _selectedMinute = newValue!;
                        });
                      },
                      items: _minutes.map<DropdownMenuItem<int>>((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: textWidget(
                            text: value.toString().padLeft(2, '0'),
                            fontFamily: AppDetails.cairoRegular,
                            fontSize: 17,
                            color: CommonColor.calendarColor,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                Material(
                    elevation: 6,
                    shadowColor: Colors.grey.withOpacity(0.5),
                    // Optional: Set shadow color
                    borderRadius: BorderRadius.circular(20),
                    // Optional: Set border radius
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<int>(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 0),
                        iconEnabledColor: CommonColor.calendarColor,
                        itemHeight: null,
                        // iconSize: 0,
                        value: _selectedHour,
                        onChanged: (int? newValue) {
                          setState(() {
                            _selectedHour = newValue!;
                          });
                        },
                        items: _hours.map<DropdownMenuItem<int>>((int value) {
                          return DropdownMenuItem<int>(
                            value: value,
                            child: textWidget(
                              text: value.toString(),
                              fontFamily: AppDetails.cairoRegular,
                              fontSize: 17,
                              color: CommonColor.calendarColor,
                            ),
                          );
                        }).toList(),
                      ),
                    ))
              ],
            ),
            const SizedBox(height: 25),
            CommonButton(
              buttonWidth: 97,
              buttonHeight: 32,
              onPress: () {
                final today = availableDate;
                if (_selectedAmPm == 'AM') {
                  final fiftyDaysFromNow = today.add(
                      Duration(hours: _selectedHour, minutes: _selectedMinute));
                  Firebase.shared.createTime(context,
                      scaffoldKey: scaffoldKey,
                      Date: fiftyDaysFromNow,
                      uid: Firebase.shared.auth.currentUser!.uid);
                } else if (_selectedAmPm == 'PM') {
                  final fiftyDaysFromNow = today.add(Duration(
                      hours: _selectedHour + 11,
                      minutes: _selectedMinute + 60));
                  Firebase.shared.createTime(context,
                      scaffoldKey: scaffoldKey,
                      Date: fiftyDaysFromNow,
                      uid: Firebase.shared.auth.currentUser!.uid);
                }
              },
              text: "اضافة",
              buttonColor: CommonColor.buttonColor,
            ),
            const SizedBox(height: 25),
            StreamBuilder<List<AvailableModel>>(
                stream: Firebase.shared.availableStream(
                    uid: Firebase.shared.auth.currentUser!.uid),
                builder: (context, snapshot) {
                  List<AvailableModel>? availableList = [];
                  if (snapshot.hasData) {
                    for (var time in snapshot.data!) {
                      if (DateFormat('EEE, M/d/y').format(time.Date) ==
                          DateFormat('EEE, M/d/y').format(availableDate)) {
                        availableList.add(time);
                      }
                    }
                    availableList!.sort((a, b) {
                      return b.Date.compareTo(a.Date);
                    });
                    return Wrap(
                        children: List.generate(
                      availableList.length,
                      (index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 50, right: 50, top: 10),
                          child: Material(
                              elevation: 6,
                              shadowColor: Colors.grey.withOpacity(0.5),
                              // Optional: Set shadow color
                              borderRadius: BorderRadius.circular(20),
                              // Optional: Set border radius
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 25, vertical: 12),
                                      decoration: BoxDecoration(
                                          color: CommonColor.buttonColor,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: textWidget(
                                        color: CommonColor.calendarColor,
                                        fontSize: 18,
                                        fontFamily: AppDetails.cairoSemiBold,
                                        text: DateFormat('hh:mm a')
                                            .format(availableList[index].Date),
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5.0, top: 10, bottom: 10),
                                    child: textWidget(
                                      text: DateFormat('EEE, M/d/y').format(availableList[index].Date),
                                      color: CommonColor.borderColor,
                                      fontSize: 18,
                                      fontFamily: AppDetails.cairoSemiBold,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            content: textWidget(
                                              text: 'هل انت متاكد من الحذف',
                                              color: CommonColor.borderColor,
                                              fontSize: 18,
                                              fontFamily:
                                                  AppDetails.cairoSemiBold,
                                            ),
                                            actions: <Widget>[
                                              InkWell(
                                                onTap: () {
                                                  Firebase.shared.deleteTime(
                                                      context,
                                                      scaffoldKey: scaffoldKey,
                                                      uid: availableList[index]
                                                          .id);
                                                  Navigator.of(context)
                                                      .pop(false);
                                                },
                                                child: textWidget(
                                                  text: 'حذف',
                                                  color:
                                                      CommonColor.borderColor,
                                                  fontSize: 18,
                                                  fontFamily:
                                                      AppDetails.cairoSemiBold,
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () =>
                                                    Navigator.of(context)
                                                        .pop(false),
                                                child: textWidget(
                                                  text: 'عوده',
                                                  color:
                                                      CommonColor.borderColor,
                                                  fontSize: 18,
                                                  fontFamily:
                                                      AppDetails.cairoSemiBold,
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: Icon(
                                      Icons.cancel_outlined,
                                      color: Colors.red,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  )
                                ],
                              )),
                        );
                      },
                    ));
                  } else {
                    return const SizedBox();
                  }
                }),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      page = Calendar.home;
                    });
                  },
                  child: Container(
                    height: 22,
                    width: 64,
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        color: CommonColor.buttonColor,
                        border: Border.all(
                          color: CommonColor.buttonColor,
                        )),
                    child: Text(
                      'حفظ',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15, color: "#ffffff".toHexa()),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      page = Calendar.home;
                    });
                  },
                  child: Container(
                    height: 22,
                    width: 64,
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        color: CommonColor.buttonColor,
                        border: Border.all(color: CommonColor.buttonColor)),
                    child: const InkWell(
                      child: Text(
                        'الغاء',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            )
          ])),
    ));
  }
}
