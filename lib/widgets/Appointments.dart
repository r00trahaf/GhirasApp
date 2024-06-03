import 'package:flutter/material.dart';
import 'package:ghiras/Model/UserModel.dart';
import 'package:ghiras/enum/status.dart';
import 'package:ghiras/widgets/extensions.dart';
import 'package:intl/intl.dart';
import '../Firebase.dart';
import '../Model/AvailableModel.dart';
import '../enum/report.dart';
import '../user_profile.dart';
import 'AppDetails.dart';
import 'commonColor.dart';
import 'commonWidget.dart';

class Appointments extends StatelessWidget {
  final UserModel user;

  Appointments({super.key, required this.user});

  bool page = false;
  Report report = Report.online;
  int _selectedMonthIndex = DateTime.now().month - 1;

  int _getDaysInMonth(int monthIndex) {
    DateTime now = DateTime.now();
    DateTime thisMonth =
        DateTime(now.year - 50 + monthIndex ~/ 12, monthIndex % 12 + 1);
    return DateTime(thisMonth.year, thisMonth.month + 1, 0).day;
  }

  DateTime _selectedDate = DateTime.now();

  String timeline = "";
  String day = "";

  DateTime dateTime = DateTime.now();
  TextEditingController place = TextEditingController();
  TextEditingController phone = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  sendData(context) async {
    UserModel? id = await UserProfile.shared.getUser();
    if (report == Report.online) {
      if (phone.text == '') {
        scaffoldKey.showTosta(context,
            message: 'هناك خطأ ما يرجى تعبئة جميع الحقول', isError: true);
        return;
      }
      Firebase.shared.createReports(context,
          scaffoldKey: scaffoldKey,
          date: dateTime,
          phone: phone.text,
          place: place.text,
          uidUser: Firebase.shared.auth.currentUser!.uid,
          nameUser: id!.name,
          idUser: id.id,
          uidSpecialist: user.uid,
          idSpecialist: user.id,
          title: '',
          note: '',
          rejected: '',
          status: Status.pending,
          report: report);
    } else {
      if (phone.text == '' || place.text == '') {
        scaffoldKey.showTosta(context,
            message: 'هناك خطأ ما يرجى تعبئة جميع الحقول', isError: true);
        return;
      }
      Firebase.shared.createReports(context,
          scaffoldKey: scaffoldKey,
          date: dateTime,
          phone: phone.text,
          place: place.text,
          uidUser: Firebase.shared.auth.currentUser!.uid,
          nameUser: id!.name,
          idUser: id.id,
          uidSpecialist: user.uid,
          idSpecialist: user.id,
          title: '',
          note: '',
          rejected: '',
          status: Status.pending,
          report: report);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder:
        (BuildContext context, void Function(void Function()) setState) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        title: page
            ? Text(
                "حجز موعد",
                textAlign: TextAlign.center,
                style: TextStyle(color: "#9DBA89".toHexa(), fontSize: 20),
              )
            : Text(
                "المواعيد",
                textAlign: TextAlign.center,
                style: TextStyle(color: "#9DBA89".toHexa(), fontSize: 20),
              ),
        content: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: user.image != ""
                      ? Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage(user.image),
                                  fit: BoxFit.cover)),
                        )
                      : Icon(
                          Icons.person,
                          size: 52,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                ),
                title: Text('${user.name} ${user.last}'),
              ),
              const SizedBox(
                height: 15,
              ),
              Visibility(
                visible: page,
                child: CommonTextFormField(
                  isReadyOnly: true,
                  label: "الوقت",
                  textInputAction: TextInputAction.next,
                  validator: (msg) {
                    return null;
                  },
                  controller: TextEditingController(),
                  hintText: timeline,
                  keyboardType: TextInputType.text,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Visibility(
                  visible: page,
                  child: CommonTextFormField(
                    isReadyOnly: true,
                    label: "اليوم",
                    textInputAction: TextInputAction.next,
                    validator: (msg) {
                      return null;
                    },
                    controller: TextEditingController(),
                    hintText: day,
                    keyboardType: TextInputType.text,
                  )),
              Visibility(
                visible: page == false,
                child: Card(
                  shadowColor: CommonColor.blackColor,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: CommonColor.whiteColor),
                      borderRadius: BorderRadius.circular(15)),
                  elevation: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 10.0, top: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            textWidget(
                              color: CommonColor.blackColor,
                              fontFamily: AppDetails.fenixRegular,
                              fontSize: 15,
                              text: DateFormat('d MMM yyyy')
                                  .format(DateTime.now()),
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
                            DateTime thisMonth =
                                DateTime(DateTime.now().year, index + 1);
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedMonthIndex = index;
                                });
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
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
                                      fontSize: 15,
                                      fontFamily: AppDetails.fenixRegular,
                                      color: index == _selectedMonthIndex
                                          ? CommonColor.selectedDaefontColor
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
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: _getDaysInMonth(_selectedMonthIndex),
                          itemBuilder: (context, index) {
                            DateTime firstDayOfMonth = DateTime(
                                DateTime.now().year,
                                _selectedMonthIndex + 1,
                                1);
                            int day = index + 1;
                            DateTime currentDate = DateTime(
                                firstDayOfMonth.year,
                                firstDayOfMonth.month,
                                day);
                            String dayOfWeek = DateFormat('EEE').format(
                                currentDate); // Get first 3 letters of day
                            bool isSelectedDate =
                                _selectedDate.year == currentDate.year &&
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text('${currentDate.day}',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: isSelectedDate
                                                    ? "#9ED8A0".toHexa()
                                                    : CommonColor.blackColor,
                                                fontFamily:
                                                    AppDetails.fenixRegular)),
                                        const SizedBox(
                                          height: 6,
                                        ),
                                        Text(dayOfWeek,
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontFamily:
                                                  AppDetails.fenixRegular,
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
              ),
              const SizedBox(
                height: 15,
              ),
              Visibility(
                  visible: page,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            report = Report.online;
                          });
                        },
                        child: Card(
                          elevation: report == Report.online ? 5 : 0,
                          color: CommonColor.whiteColor.withOpacity(0.02),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(color: "#9DBA89".toHexa()),
                          ),
                          child: Container(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: report == Report.online
                                    ? CommonColor.calendarLightColor
                                    : CommonColor.whiteColor),
                            child: textWidget(
                              text: "اون لاين",
                              color: CommonColor.blackColor,
                              fontSize: 18,
                              fontFamily: AppDetails.cairoRegular,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            report = Report.outside;
                          });
                        },
                        child: Card(
                          elevation: report == Report.outside ? 0 : 5,
                          color: CommonColor.greyColor.withOpacity(0.02),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(color: "#9DBA89".toHexa()),
                          ),
                          child: Container(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: report == Report.outside
                                    ? CommonColor.calendarLightColor
                                    : CommonColor.whiteColor),
                            child: textWidget(
                              text: "زيارة ميدانية",
                              color: CommonColor.blackColor,
                              fontSize: 18,
                              fontFamily: AppDetails.cairoRegular,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
              Visibility(
                visible: page == false,
                child: Text(
                  "المواعيد المتوفره اليوم",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: "#9DBA89".toHexa(), fontSize: 20),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Visibility(
                  visible: report == Report.outside,
                  child: CommonTextFormField(
                    controller: place,
                    label: "المكان",
                    textInputAction: TextInputAction.next,
                    validator: (msg) {
                      return null;
                    },
                    hintText: "الخالدية",
                    keyboardType: TextInputType.text,
                  )),
              Visibility(
                visible: page == false,
                child: FutureBuilder<List<AvailableModel>>(
                    future: Firebase.shared.available(uid: user.uid),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<AvailableModel>? available = [];
                        for (var time in snapshot.data!) {
                          if (DateFormat('EEE, M/d/y').format(time.Date) ==
                              DateFormat('EEE, M/d/y').format(_selectedDate)) {
                            available.add(time);
                          }
                        }
                        available.sort((a, b) {
                          return b.Date.compareTo(a.Date);
                        });
                        return Wrap(
                            children: List.generate(
                          available.length,
                          (index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 20, bottom: 10, top: 10),
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
                                      textWidget(
                                        text:
                                            '           ${DateFormat('hh:mm a').format(available[index].Date)}',
                                        color: CommonColor.borderColor,
                                        fontSize: 18,
                                        fontFamily: AppDetails.cairoSemiBold,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            page = true;
                                            timeline = DateFormat('hh:mm a').format(available[index].Date);
                                            day = DateFormat('d MMM yyyy').format(available[index].Date);
                                            dateTime = available[index].Date;
                                          });
                                        },
                                        child: Container(
                                            padding: const EdgeInsets.only(
                                                left: 20.0,
                                                right: 20,
                                                bottom: 10,
                                                top: 10),
                                            decoration: BoxDecoration(
                                                color: CommonColor.buttonColor,
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: textWidget(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontFamily:
                                                  AppDetails.cairoSemiBold,
                                              text: 'حجز',
                                            )),
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
              ),
              const SizedBox(
                height: 15,
              ),
              Visibility(
                  visible: page,
                  child: CommonTextFormField(
                    label: "رقم التواصل",
                    textInputAction: TextInputAction.next,
                    validator: (msg) {
                      return null;
                    },
                    controller: phone,
                    hintText: "********05",
                    keyboardType: TextInputType.text,
                  )),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
        actions: [
          Visibility(
              visible: page,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () => sendData(context),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          color: "#D1DFC8".toHexa(),
                          border: Border.all(color: "#D1DFC8".toHexa())),
                      child: const Text(
                        'ارسال',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 15, color: Colors.white),
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
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          color: "#D1DFC8".toHexa(),
                          border: Border.all(color: "#D1DFC8".toHexa())),
                      child: const Text(
                        'اغلاق',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ),
                  )
                ],
              )),
          Visibility(
            visible: page == false,
            child: Center(
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      color: "#D1DFC8".toHexa(),
                      border: Border.all(color: "#D1DFC8".toHexa())),
                  child: const Text(
                    'اغلاق',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
              ),
            ),
          )
        ],
      );
    });
  }
}
