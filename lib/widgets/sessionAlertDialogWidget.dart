import 'package:flutter/material.dart';
import 'package:ghiras/widgets/extensions.dart';
import 'package:intl/intl.dart';
import '../Firebase.dart';
import '../Model/ReportsModel.dart';
import '../enum/status.dart';
import 'AppDetails.dart';
import 'commonColor.dart';
import 'commonWidget.dart';

class sessionAlertDialogWidget extends StatelessWidget {
  final ReportsModel reports;
  sessionAlertDialogWidget({super.key, required this.reports});


  String _selectedAmPm = 'AM';
  final List<String> _ampm = ['AM', 'PM'];
  final List<int> _hours = List.generate(12, (index) => index + 1);
  final List<int> _minutes = List.generate(60, (index) => index);
  int _selectedMonthIndex = DateTime.now().month - 1;
  int _getDaysInMonth(int monthIndex) {
    DateTime now = DateTime.now();
    DateTime thisMonth =
    DateTime(now.year - 50 + monthIndex ~/ 12, monthIndex % 12 + 1);
    return DateTime(thisMonth.year, thisMonth.month + 1, 0).day;
  }
  DateTime _selectedDate = DateTime.now();
  int _selectedMinute = 0;
  int _selectedHour = 1;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (BuildContext context, void Function(void Function()) setState) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        title: Column(
          children: [
            textWidget(
              text: "الرجاء كتابة موعد",
              color: CommonColor.titleColor,
              fontSize: 23,
              fontFamily: AppDetails.cairoRegular,
            ),
            textWidget(
              text: " الجلسة الجديدة",
              color: CommonColor.titleColor,
              fontSize: 23,
              fontFamily: AppDetails.cairoRegular,
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              shadowColor: CommonColor.blackColor,
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: CommonColor.whiteColor),
                  borderRadius: BorderRadius.circular(15)),
              elevation: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        textWidget(
                          text: "تاريخ الجلسة الجديد",
                          fontFamily: AppDetails.cairoRegular,
                          fontSize: 16,
                          color: CommonColor.titleColor,
                        ),
                        textWidget(
                          color: CommonColor.blackColor,
                          fontFamily: AppDetails.fenixRegular,
                          fontSize: 15,
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
                              color: index == _selectedMonthIndex ? CommonColor.selectedMonthColor : Colors.transparent,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                              child: Text(
                                DateFormat('MMM').format(thisMonth),
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: AppDetails.fenixRegular,
                                  color: index == _selectedMonthIndex ? CommonColor.selectedDaefontColor : Colors.grey,
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
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      shrinkWrap: true,
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
                        String dayOfWeek = DateFormat('EEE').format(currentDate); // Get first 3 letters of day
                        bool isSelectedDate = _selectedDate.year == currentDate.year && _selectedDate.month == currentDate.month && _selectedDate.day == currentDate.day;
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
                              color: isSelectedDate ? "#EAF3EF".toHexa() : "#f2f2f2".toHexa(),
                              elevation: 5,
                              shadowColor: CommonColor.blackColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('${currentDate.day}',
                                        style: TextStyle(
                                            fontSize: 15,
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
            ),
            const SizedBox(
              height: 05,
            ),
            textWidget(
              text: "وقت الجلسة الجديد",
              color: CommonColor.titleColor,
              fontSize: 16,
              fontFamily: AppDetails.cairoRegular,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: CommonColor.calendarColor,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      iconEnabledColor: CommonColor.calendarColor,
                      itemHeight: null,
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      value: _selectedAmPm,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedAmPm = newValue!;
                        });
                      },
                      items: _ampm.map<DropdownMenuItem<String>>((String value) {
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
                Container(
                  // height:50,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: CommonColor.calendarColor,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<int>(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      itemHeight: null,
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
                Container(
                  // height:50,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: CommonColor.calendarColor,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<int>(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 15.0),
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
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.all(2),
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
                      final today = _selectedDate;
                      if (_selectedAmPm == 'AM') {
                        final fiftyDaysFromNow = today.add(Duration(hours: _selectedHour, minutes: _selectedMinute));
                        Firebase.shared.updateReports(context, scaffoldKey: scaffoldKey, date: fiftyDaysFromNow, phone: reports.phone!, place: reports.place!, title: reports.title!, uidUser: reports.uidUser!, nameUser: reports.nameUser!, idUser: reports.idUser!, uidSpecialist: reports.uidSpecialist!, idSpecialist: reports.idSpecialist!, note: reports.note!, id: reports.id!, rejected: reports.rejected!, status: Status.pending, report: reports.report);
                      } else if (_selectedAmPm == 'PM') {
                        final fiftyDaysFromNow = today.add(Duration(hours: _selectedHour + 11, minutes: _selectedMinute + 60));
                        Firebase.shared.updateReports(context, scaffoldKey: scaffoldKey, date: fiftyDaysFromNow, phone: reports.phone!, place: reports.place!, title: reports.title!, uidUser: reports.uidUser!, nameUser: reports.nameUser!, idUser: reports.idUser!, uidSpecialist: reports.uidSpecialist!, idSpecialist: reports.idSpecialist!, note: reports.note!, id: reports.id!, rejected: reports.rejected!, status: Status.pending, report: reports.report);
                      }
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: textWidget(
                        fontFamily: AppDetails.cairoRegular,
                        text: "ارسال",
                        fontSize: 15,
                        color: "#365133".toHexa(),
                      ),
                    ),
                  ),
                  Center(
                    child: VerticalDivider(
                      color: "#365133".toHexa(),
                      thickness: 2,
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: textWidget(
                        fontFamily: AppDetails.cairoRegular,
                        fontSize: 15,
                        color: "#365133".toHexa(),
                        text: "العودة",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}
